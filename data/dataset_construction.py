import requests
import json
import os
import re
import time
import math
import base64
import hashlib
import pandas as pd
from typing import Dict, Any, List, Optional, Tuple
from datetime import datetime
import sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from sensitive import GITHUB_TOKEN
from search_queries import PERMISSIVE_LICENSES, LANGUAGE_CONFIG


class IaCDatasetPipeline:
    """
    Four-step pipeline for collecting IaC templates from GitHub:
      1. Repository Collection  (Search Repo API + Search Code API)
      2. Repository Filtering   (fork check, permissive-license check, dedup)
      3+4. Template Extraction & Filtering (Git Trees API, content validation)

    Designed to be consistent across CloudFormation, ARM, Bicep, and Terraform.

    For Terraform the pipeline operates in *group mode*: all .tf files that
    share the same parent directory are treated as a single analysis unit
    (a Terraform module). Each module is saved as a subdirectory and gets one
    row in the output CSV.
    """

    SEARCH_CODE_RATE_LIMIT = 7        # seconds between Search Code API pages
    SEARCH_REPO_RATE_LIMIT = 2        # seconds between Search Repo API pages
    GENERAL_API_RATE_LIMIT = 0.75     # seconds between GET /repos calls
    FILE_DOWNLOAD_RATE_LIMIT = 0.1    # seconds between file content downloads
    REPO_PROCESSING_RATE_LIMIT = 1    # seconds between repository processing

    def __init__(self, github_token: str, language: str):
        if language not in LANGUAGE_CONFIG:
            raise ValueError(
                f"Unsupported language '{language}'. "
                f"Choose from: {list(LANGUAGE_CONFIG.keys())}"
            )

        self.language = language
        self.config = LANGUAGE_CONFIG[language]
        self.github_token = github_token
        self.base_url = "https://api.github.com"
        self.headers = {
            "Accept": "application/vnd.github.v3+json",
            "User-Agent": "IaC-Dataset-Pipeline",
        }
        if github_token:
            self.headers["Authorization"] = f"token {github_token}"

        self.per_page = 100
        self.max_search_pages = math.ceil(1000 / self.per_page)

    # ------------------------------------------------------------------
    # Full pipeline
    # ------------------------------------------------------------------

    def run(self) -> None:
        """Execute the full four-step pipeline."""
        print(f"\n{'=' * 80}")
        print(f"  IaC Dataset Pipeline — {self.config['label']}")
        print(f"{'=' * 80}\n")

        # Step 1
        repos_df = self.collect_repositories()
        print(f"\n[Step 1 complete] Raw repositories collected: {len(repos_df)}\n")

        # Step 2
        filtered_df = self.filter_repositories(repos_df)
        print(f"\n[Step 2 complete] Filtered repositories: {len(filtered_df)}\n")

        # Steps 3+4
        templates_df = self.extract_and_filter_templates(filtered_df)
        print(f"\n[Steps 3+4 complete] Valid templates extracted: {len(templates_df)}")

        print(f"\n{'=' * 80}")
        print(f"  Pipeline finished — {self.config['label']}")
        print(f"  Repositories: {len(filtered_df)}  |  Templates: {len(templates_df)}")
        print(f"{'=' * 80}\n")

    # ==================================================================
    # STEP 1 — Repository Collection
    # ==================================================================

    def collect_repositories(self) -> pd.DataFrame:
        """
        Collect repositories from both Search Repo API and Search Code API,
        merge, deduplicate, and return a DataFrame.

        Columns: html_url, full_name, description, stargazers_count,
                 default_branch, owner, license_spdx_id, fork,
                 collection_source, source_api
        """
        print("[Step 1] Collecting repositories …")

        repo_csv_path = self.config["repo_csv"].replace(
            ".csv", "_raw.csv"
        )

        if os.path.exists(repo_csv_path):
            print(f"  Resuming from existing raw CSV: {repo_csv_path}")
            return pd.read_csv(repo_csv_path, encoding="utf-8")

        all_repos: Dict[str, Dict[str, Any]] = {}

        # --- A) Search Repo API ---
        for query in self.config["repo_queries"]:
            print(f"  [Repo API] query: {query}")
            start = time.time()
            results = self._search_repos_api(query)
            for repo in results:
                fn = repo["full_name"]
                if fn not in all_repos:
                    repo["collection_source"] = f"search_repo:{query}"
                    repo["source_api"] = "repo"
                    all_repos[fn] = repo
            elapsed = time.time() - start
            sleep = max(0, 60 - elapsed)
            print(f"    Found {len(results)} repos  (total unique so far: {len(all_repos)})  sleeping {sleep:.0f}s")
            time.sleep(sleep)

        # --- B) Search Code API (extract parent repositories) ---
        for query in self.config["code_queries"]:
            print(f"  [Code API] query: {query}")
            start = time.time()
            code_results = self._search_code_api(query)
            parent_repos = self._extract_repos_from_code_results(code_results)
            for repo in parent_repos:
                fn = repo["full_name"]
                if fn not in all_repos:
                    repo["collection_source"] = f"search_code:{query}"
                    repo["source_api"] = "code"
                    all_repos[fn] = repo
            elapsed = time.time() - start
            sleep = max(0, 60 - elapsed)
            print(f"    Found {len(parent_repos)} parent repos  (total unique: {len(all_repos)})  sleeping {sleep:.0f}s")
            time.sleep(sleep)

        repos_df = pd.DataFrame(list(all_repos.values()))
        os.makedirs(os.path.dirname(repo_csv_path) or ".", exist_ok=True)
        repos_df.to_csv(repo_csv_path, index=False, encoding="utf-8")
        print(f"  Saved raw repositories to {repo_csv_path}")
        return repos_df

    def _search_repos_api(self, query: str) -> List[Dict[str, Any]]:
        """Search GitHub repositories. Returns list of repo dicts with full metadata."""
        results = []
        url = f"{self.base_url}/search/repositories"
        for page in range(1, self.max_search_pages + 1):
            params = {
                "q": query,
                "per_page": self.per_page,
                "page": page,
                "sort": "stars",
                "order": "desc",
            }
            resp = self._api_get(url, params=params)
            if resp is None:
                break
            items = resp.get("items", [])
            if not items:
                break
            for item in items:
                license_obj = item.get("license") or {}
                results.append({
                    "html_url": item.get("html_url", ""),
                    "full_name": item.get("full_name", ""),
                    "description": self._sanitize_text(item.get("description") or ""),
                    "stargazers_count": item.get("stargazers_count", 0),
                    "default_branch": item.get("default_branch", "main"),
                    "owner": (item.get("owner") or {}).get("login", ""),
                    "license_spdx_id": license_obj.get("spdx_id", ""),
                    "fork": item.get("fork", False),
                })
            time.sleep(self.SEARCH_REPO_RATE_LIMIT)
        return results

    def _search_code_api(self, query: str) -> List[Dict[str, Any]]:
        """Search GitHub code. Returns raw code-search items."""
        results = []
        url = f"{self.base_url}/search/code"
        for page in range(1, self.max_search_pages + 1):
            params = {"q": query, "per_page": self.per_page, "page": page}
            resp = self._api_get(url, params=params)
            if resp is None:
                break
            items = resp.get("items", [])
            if not items:
                break
            results.extend(items)
            time.sleep(self.SEARCH_CODE_RATE_LIMIT)
        return results

    def _extract_repos_from_code_results(
        self, code_items: List[Dict[str, Any]]
    ) -> List[Dict[str, Any]]:
        """
        Extract unique parent repositories from Search Code API results.
        The Minimal Repository in code results has full_name, html_url, fork
        but may lack license/stars/default_branch — those are filled later in
        Step 2 via GET /repos/{owner}/{repo}.
        """
        seen: set = set()
        repos: List[Dict[str, Any]] = []
        for item in code_items:
            repo_obj = item.get("repository", {})
            fn = repo_obj.get("full_name", "")
            if not fn or fn in seen:
                continue
            seen.add(fn)
            repos.append({
                "html_url": repo_obj.get("html_url", ""),
                "full_name": fn,
                "description": self._sanitize_text(repo_obj.get("description") or ""),
                "stargazers_count": None,
                "default_branch": None,
                "owner": (repo_obj.get("owner") or {}).get("login", ""),
                "license_spdx_id": None,
                "fork": repo_obj.get("fork", False),
            })
        return repos

    # ==================================================================
    # STEP 2 — Repository Filtering
    # ==================================================================

    def filter_repositories(self, repos_df: pd.DataFrame) -> pd.DataFrame:
        """
        Filter repositories:
          1. Enrich repos from Code API with full metadata via GET /repos
          2. Remove forks
          3. Remove non-permissive licenses
          4. Deduplicate by full_name
          5. Save to {lang}_repositories.csv
        """
        print("[Step 2] Filtering repositories …")

        output_path = self.config["repo_csv"]
        if os.path.exists(output_path):
            print(f"  Resuming from existing filtered CSV: {output_path}")
            return pd.read_csv(output_path, encoding="utf-8")

        enriched_rows: List[Dict[str, Any]] = []

        for idx, row in repos_df.iterrows():
            fn = row["full_name"]

            needs_enrichment = (
                row.get("source_api") == "code"
                or pd.isna(row.get("license_spdx_id"))
                or pd.isna(row.get("stargazers_count"))
                or pd.isna(row.get("default_branch"))
            )

            if needs_enrichment:
                meta = self._get_repo_metadata(fn, row)
                if meta is None:
                    continue
                enriched_rows.append(meta)
            else:
                enriched_rows.append(row.to_dict())

        enriched_df = pd.DataFrame(enriched_rows)

        # Filter forks
        before = len(enriched_df)
        enriched_df = enriched_df[enriched_df["fork"] == False].copy()
        print(f"  Fork filter: {before} -> {len(enriched_df)}")

        # Filter permissive licenses
        before = len(enriched_df)
        enriched_df = enriched_df[
            enriched_df["license_spdx_id"].apply(self._is_permissive_license)
        ].copy()
        print(f"  License filter: {before} -> {len(enriched_df)}")

        # Deduplicate
        before = len(enriched_df)
        enriched_df = enriched_df.drop_duplicates(subset=["full_name"], keep="first")
        print(f"  Dedup: {before} -> {len(enriched_df)}")

        # Save
        os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
        enriched_df.to_csv(output_path, index=False, encoding="utf-8")
        print(f"  Saved filtered repositories to {output_path}")
        return enriched_df

    def _get_repo_metadata(self, full_name: str, row: Optional[pd.Series] = None) -> Optional[Dict[str, Any]]:
        """Call GET /repos/{owner}/{repo} and return a normalised dict."""
        url = f"{self.base_url}/repos/{full_name}"
        data = self._api_get(url)
        if data is None:
            return None

        license_obj = data.get("license") or {}
        return {
            "html_url": row["html_url"],
            "full_name": row["full_name"],
            "description": row["description"],
            "stargazers_count": data.get("stargazers_count", 0),
            "default_branch": data.get("default_branch", "main"),
            "owner": row["owner"],
            "license_spdx_id": license_obj.get("spdx_id", ""),
            "fork": row["fork"],
            "collection_source": row["collection_source"],
            "source_api": row["source_api"],
        }

    @staticmethod
    def _is_permissive_license(spdx_id) -> bool:
        if pd.isna(spdx_id) or not spdx_id:
            return False
        return str(spdx_id) in PERMISSIVE_LICENSES

    # ------------------------------------------------------------------
    # Text / filename sanitisation
    # ------------------------------------------------------------------

    @staticmethod
    def _sanitize_text(text: str) -> str:
        """Strip non-ASCII characters to avoid encoding issues in CSV output."""
        if not text:
            return ""
        return text.encode("ascii", errors="ignore").decode("ascii").strip()

    @staticmethod
    def _sanitize_filename(name: str) -> str:
        """Remove non-ASCII and filesystem-unsafe characters from filenames."""
        if not name:
            return "unnamed"
        clean = name.encode("ascii", errors="ignore").decode("ascii")
        clean = re.sub(r'[<>:"/\\|?*]', "_", clean).strip()
        return clean or "unnamed"

    # ==================================================================
    # STEPS 3+4 — Template Extraction & Filtering (combined)
    # ==================================================================

    def extract_and_filter_templates(
        self, repos_df: pd.DataFrame
    ) -> pd.DataFrame:
        """
        Dispatch to single-file or group-mode extraction depending on
        the language configuration.
        """
        if self.config.get("group_mode"):
            return self._extract_grouped_templates(repos_df)
        return self._extract_single_templates(repos_df)

    # ------------------------------------------------------------------
    # Single-file mode (CloudFormation, ARM, Bicep)
    # ------------------------------------------------------------------

    def _extract_single_templates(
        self, repos_df: pd.DataFrame
    ) -> pd.DataFrame:
        """
        For each filtered repository:
          1. List files via Git Trees API
          2. Filter by extension
          3. Download content & validate keywords in memory
          4. Save valid templates locally with sequential naming
          5. Append metadata row
        """
        print("[Steps 3+4] Extracting and filtering templates (single-file mode) …")

        template_dir = self.config["template_dir"]
        template_csv = self.config["template_csv"]
        os.makedirs(template_dir, exist_ok=True)

        already_processed_repos: set = set()
        template_counter = 0
        existing_template_urls: set = set()

        if os.path.exists(template_csv):
            existing_df = pd.read_csv(template_csv, encoding="utf-8")
            template_counter = len(existing_df)
            existing_template_urls = set(existing_df["template_html_url"].tolist())
            # Use last repo_name in template CSV to infer processed range; repos that
            # yielded 0 templates are not in the CSV, so we must use position in
            # repos_df rather than set of repo_name.
            repos_order = repos_df["full_name"].tolist()
            if len(existing_df) > 0:
                last_repo = existing_df.iloc[-1]["repo_name"]
                try:
                    last_idx = repos_order.index(last_repo)
                    already_processed_repos = set(repos_order[: last_idx + 1])
                except ValueError:
                    pass
            print(
                f"  Resuming: {template_counter} templates, "
                f"{len(already_processed_repos)} repos already processed"
            )

        csv_exists = os.path.exists(template_csv)
        total_repos = len(repos_df)

        for idx, row in repos_df.iterrows():
            # NOTE: molecule-man/stack-assembly is an invalid repo for CFN
            fn = row["full_name"]
            if fn in already_processed_repos:
                continue

            owner, repo_name = fn.split("/", 1)
            default_branch = row.get("default_branch", "main")
            stars = row.get("stargazers_count", 0)
            source = row.get("collection_source", "")
            repo_html_url = row.get("html_url", f"https://github.com/{fn}")

            print(f"  [{idx + 1}/{total_repos}] {fn}")

            tree = self._get_repo_file_tree(owner, repo_name)
            if tree is None:
                time.sleep(self.REPO_PROCESSING_RATE_LIMIT)
                continue

            matching_files = self._filter_tree_by_extension(tree)
            if not matching_files:
                time.sleep(self.REPO_PROCESSING_RATE_LIMIT)
                continue

            batch_rows: List[Dict[str, Any]] = []

            for file_info in matching_files:
                file_path_in_repo = file_info["path"]
                original_name = self._sanitize_filename(file_path_in_repo.split("/")[-1])
                template_html_url = (
                    f"https://github.com/{fn}/blob/"
                    f"{default_branch}/{file_path_in_repo}"
                )

                if template_html_url in existing_template_urls:
                    continue

                content = self._download_file_content(owner, repo_name, file_path_in_repo)
                if content is None:
                    continue

                if not self._validate_template_content(content):
                    continue

                template_counter += 1
                template_name = f"template_{template_counter:05d}_{original_name}"
                template_path = os.path.join(template_dir, template_name)

                counter = 1
                while os.path.exists(template_path):
                    name_base, ext = os.path.splitext(template_name)
                    template_path = os.path.join(
                        template_dir, f"{name_base}_{counter}{ext}"
                    )
                    counter += 1

                try:
                    with open(template_path, "w", encoding="utf-8") as f:
                        f.write(content)
                except Exception as e:
                    template_counter -= 1
                    print(str(e))
                    time.sleep(self.FILE_DOWNLOAD_RATE_LIMIT)
                    continue

                existing_template_urls.add(template_html_url)

                batch_rows.append({
                    "original_name": original_name,
                    "template_name": template_name,
                    "template_path": template_path,
                    "template_language": self.config["label"],
                    "template_html_url": template_html_url,
                    "repo_html_url": repo_html_url,
                    "repo_name": fn,
                    "repo_stars": stars,
                    "file_size": len(content.encode("utf-8")),
                    "collection_source": source,
                })

                time.sleep(self.FILE_DOWNLOAD_RATE_LIMIT)

            if batch_rows:
                batch_df = pd.DataFrame(batch_rows)
                batch_df.to_csv(
                    template_csv,
                    mode="a",
                    header=not csv_exists,
                    index=False,
                    encoding="utf-8",
                )
                csv_exists = True
                print(f"    Saved {len(batch_rows)} templates")

            already_processed_repos.add(fn)
            time.sleep(self.REPO_PROCESSING_RATE_LIMIT)

        if os.path.exists(template_csv):
            return pd.read_csv(template_csv, encoding="utf-8")
        return pd.DataFrame()

    # ------------------------------------------------------------------
    # Group mode (Terraform) — all .tf files in a directory = one module
    # ------------------------------------------------------------------

    def _extract_grouped_templates(
        self, repos_df: pd.DataFrame
    ) -> pd.DataFrame:
        """
        Terraform-specific extraction: group .tf files by their parent
        directory to form modules.  Each module is saved as a subdirectory
        and represented by one row in the output CSV.

        Extra CSV columns vs single-file mode:
          group_dir   — relative directory path inside the repository
          file_count  — number of .tf files in the module
          file_names  — semicolon-separated list of filenames
        """
        print("[Steps 3+4] Extracting and filtering templates (group mode) …")

        template_dir = self.config["template_dir"]
        template_csv = self.config["template_csv"]
        os.makedirs(template_dir, exist_ok=True)

        already_processed_repos: set = set()
        group_counter = 0

        if os.path.exists(template_csv):
            existing_df = pd.read_csv(template_csv, encoding="utf-8")
            group_counter = len(existing_df)
            # Use last repo_name to infer processed range (repos with 0 groups omitted)
            repos_order = repos_df["full_name"].tolist()
            if len(existing_df) > 0:
                last_repo = existing_df.iloc[-1]["repo_name"]
                try:
                    last_idx = repos_order.index(last_repo)
                    already_processed_repos = set(repos_order[: last_idx + 1])
                except ValueError:
                    pass
            print(
                f"  Resuming: {group_counter} groups, "
                f"{len(already_processed_repos)} repos already processed"
            )

        csv_exists = os.path.exists(template_csv)
        total_repos = len(repos_df)
        group_must = self.config.get("group_must_contain", [])

        for idx, row in repos_df.iterrows():
            fn = row["full_name"]
            if fn in already_processed_repos:
                continue

            owner, repo_name = fn.split("/", 1)
            default_branch = row.get("default_branch", "main")
            stars = row.get("stargazers_count", 0)
            source = row.get("collection_source", "")
            repo_html_url = row.get("html_url", f"https://github.com/{fn}")

            print(f"  [{idx + 1}/{total_repos}] {fn}")

            tree = self._get_repo_file_tree(owner, repo_name)
            if tree is None:
                time.sleep(self.REPO_PROCESSING_RATE_LIMIT)
                continue

            matching_files = self._filter_tree_by_extension(tree)
            if not matching_files:
                time.sleep(self.REPO_PROCESSING_RATE_LIMIT)
                continue

            dir_groups = self._group_files_by_directory(matching_files)
            batch_rows: List[Dict[str, Any]] = []

            for dir_path, files in dir_groups.items():
                contents: Dict[str, str] = {}
                for file_info in files:
                    c = self._download_file_content(
                        owner, repo_name, file_info["path"]
                    )
                    if c is not None:
                        contents[file_info["path"]] = c
                    time.sleep(self.FILE_DOWNLOAD_RATE_LIMIT)

                if not contents:
                    continue

                combined = "\n".join(contents.values())
                if group_must and not all(kw in combined for kw in group_must):
                    continue

                group_counter += 1
                dir_basename = self._sanitize_filename(
                    dir_path.replace("/", "_") if dir_path else "root"
                )
                # if len(dir_basename) >= 100:
                #     print("Too long")
                #     group_counter -= 1
                #     continue
                group_name = f"group_{group_counter:05d}_{dir_basename[:40]}"
                group_local_dir = os.path.join(template_dir, group_name)
                os.makedirs(group_local_dir, exist_ok=True)

                file_names_list: List[str] = []
                total_size = 0
                # for fpath, content in contents.items():   # Mitigate the file path too long issue.
                #     fname = self._sanitize_filename(fpath.split("/")[-1])
                #     out = os.path.join(group_local_dir, fname)
                #     if len(out) >=180:
                #         group_counter -= 1
                #         continue

                for fpath, content in contents.items():
                    fname = self._sanitize_filename(fpath.split("/")[-1])
                    file_names_list.append(fname)
                    out = os.path.join(group_local_dir, fname)
                    dup = 1
                    while os.path.exists(out):
                        base, ext = os.path.splitext(fname)
                        out = os.path.join(group_local_dir, f"{base}_{dup}{ext}")
                        dup += 1
                    with open(out, "w", encoding="utf-8") as f:
                        f.write(content)
                    total_size += len(content.encode("utf-8"))

                if dir_path:
                    group_html_url = (
                        f"https://github.com/{fn}/tree/"
                        f"{default_branch}/{dir_path}"
                    )
                else:
                    group_html_url = (
                        f"https://github.com/{fn}/tree/{default_branch}"
                    )

                batch_rows.append({
                    "original_name": dir_path if dir_path else "(root)",
                    "template_name": group_name,
                    "template_path": group_local_dir,
                    "template_language": self.config["label"],
                    "template_html_url": group_html_url,
                    "repo_html_url": repo_html_url,
                    "repo_name": fn,
                    "repo_stars": stars,
                    "file_size": total_size,
                    "collection_source": source,
                    "group_dir": dir_path if dir_path else "(root)",
                    "file_count": len(contents),
                    "file_names": ";".join(file_names_list),
                })

            if batch_rows:
                batch_df = pd.DataFrame(batch_rows)
                batch_df.to_csv(
                    template_csv,
                    mode="a",
                    header=not csv_exists,
                    index=False,
                    encoding="utf-8",
                )
                csv_exists = True
                print(f"    Saved {len(batch_rows)} template groups")

            already_processed_repos.add(fn)
            time.sleep(self.REPO_PROCESSING_RATE_LIMIT)

        if os.path.exists(template_csv):
            return pd.read_csv(template_csv, encoding="utf-8")
        return pd.DataFrame()

    @staticmethod
    def _group_files_by_directory(
        files: List[Dict[str, Any]],
    ) -> Dict[str, List[Dict[str, Any]]]:
        """Group file tree entries by their parent directory path."""
        groups: Dict[str, List[Dict[str, Any]]] = {}
        for f in files:
            parent = "/".join(f["path"].split("/")[:-1])
            groups.setdefault(parent, []).append(f)
        return groups

    def _get_repo_file_tree(
        self, owner: str, repo: str
    ) -> Optional[List[Dict[str, Any]]]:
        """Get the recursive file tree for a repository."""
        url = f"{self.base_url}/repos/{owner}/{repo}/git/trees/HEAD"
        params = {"recursive": "1"}
        data = self._api_get(url, params=params)
        if data is None:
            return None
        return data.get("tree", [])

    def _filter_tree_by_extension(
        self, tree: List[Dict[str, Any]]
    ) -> List[Dict[str, Any]]:
        """Keep only blob entries whose extension matches the language config,
        excluding any paths that contain segments from excluded_path_segments."""
        valid_ext = tuple(self.config["valid_extensions"])
        excluded = self.config.get("excluded_path_segments", [])
        result = []
        for item in tree:
            if item.get("type") != "blob":
                continue
            path = item["path"]
            if not path.lower().endswith(valid_ext):
                continue
            if excluded and any(seg in path for seg in excluded):
                continue
            result.append(item)
        return result

    def _download_file_content(
        self, owner: str, repo: str, path: str
    ) -> Optional[str]:
        """Download a single file's content via the Contents API."""
        path = path.replace("#", "%23")
        url = f"{self.base_url}/repos/{owner}/{repo}/contents/{path}"
        data = self._api_get(url)
        if data is None:
            return None
        if data.get("encoding") == "base64":
            try:
                return base64.b64decode(data["content"]).decode("utf-8")
            except Exception:
                return None
        return data.get("content", "")

    def _validate_template_content(self, content: str) -> bool:
        """Check must-contain and must-not-contain keyword rules."""
        must = self.config["must_contain"]
        must_not = self.config["must_not_contain"]
        if must and not all(kw in content for kw in must):
            return False
        if must_not and any(kw in content for kw in must_not):
            return False
        return True

    # ==================================================================
    # HTTP helper with rate-limit handling
    # ==================================================================

    def _api_get(
        self, url: str, params: Optional[Dict] = None, max_retries: int = 5
    ) -> Optional[Dict]:
        """
        GET request with automatic retry on rate-limit (HTTP 403 / 429).
        Returns parsed JSON dict or None on failure.
        """
        for attempt in range(max_retries):
            try:
                resp = requests.get(url, headers=self.headers, params=params)

                if resp.status_code in (403, 429):
                    retry_after = int(resp.headers.get("Retry-After", 60))
                    wait = max(retry_after, 2 ** attempt * 10)
                    print(
                        f"    Rate limited ({resp.status_code}). "
                        f"Waiting {wait}s (attempt {attempt + 1}/{max_retries})"
                    )
                    time.sleep(wait)
                    continue

                if resp.status_code == 404:
                    return None

                resp.raise_for_status()
                return resp.json()

            except requests.exceptions.RequestException as e:
                wait = 2 ** attempt * 5
                print(f"    Request error: {e}. Retrying in {wait}s …")
                time.sleep(wait)

        print(f"    Failed after {max_retries} retries: {url}")
        return None


# ======================================================================
# Entry points — one per language
# ======================================================================

def collect_cloudformation():
    """Run the full pipeline for CloudFormation."""
    pipeline = IaCDatasetPipeline(GITHUB_TOKEN, "cloudformation")
    pipeline.run()


def collect_arm():
    """Run the full pipeline for ARM."""
    pipeline = IaCDatasetPipeline(GITHUB_TOKEN, "arm")
    pipeline.run()


def collect_bicep():
    """Run the full pipeline for Bicep."""
    pipeline = IaCDatasetPipeline(GITHUB_TOKEN, "bicep")
    pipeline.run()


def collect_terraform():
    """Run the full pipeline for Terraform (group mode)."""
    pipeline = IaCDatasetPipeline(GITHUB_TOKEN, "terraform")
    pipeline.run()


if __name__ == "__main__":
    import argparse

    LANG_CHOICES = ["cloudformation", "arm", "bicep", "terraform", "all"]

    parser = argparse.ArgumentParser(
        description="IaC Dataset Collection Pipeline"
    )
    parser.add_argument(
        "language",
        choices=LANG_CHOICES,
        help="IaC language to collect (or 'all' for all four)",
    )
    args = parser.parse_args()

    runners = {
        "cloudformation": collect_cloudformation,
        "arm": collect_arm,
        "bicep": collect_bicep,
        "terraform": collect_terraform,
    }

    if args.language == "all":
        for run_fn in runners.values():
            run_fn()
    else:
        runners[args.language]()
