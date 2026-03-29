"""
Search queries and validation rules for IaC dataset collection.
Part of the replication package for dataset construction.

================================================================================
PURPOSE
================================================================================
Single source of truth for every search query executed against the GitHub
Search API during dataset collection. Provided for full reproducibility.

================================================================================
QUERY DESIGN RATIONALE
================================================================================
Queries are designed to maximise coverage of valid IaC templates without
introducing selection bias toward specific cloud services or resource types.

Repository discovery uses three complementary strategies per language:
  1. Language-based search  — uses GitHub's Linguist language classifier
     (available for Terraform/HCL and Bicep, which have dedicated DSLs).
  2. Topic-based search     — targets curated GitHub repository topics
     (e.g., "cloudformation", "arm-template", "terraform").
  3. Keyword-based search   — broad keyword matching on repository metadata.

Code-level discovery uses the GitHub Code Search API with queries that
contain only language-level structural identifiers (e.g., the "AWS::"
namespace for CloudFormation, the ARM schema URL for ARM, or the "resource"
keyword for Bicep/Terraform). We deliberately avoid service-specific
keywords (e.g., "AWS::EC2::Instance", "Microsoft.Compute") in active
queries because each query returns at most 1,000 results ranked by
GitHub's relevance scoring — using service-specific terms would bias the
dataset toward popular services and under-represent others.

The number of queries differs across languages. This is not arbitrary but
reflects genuine structural differences:
  - CloudFormation templates may use three file extensions (.yaml, .yml,
    .json), requiring one code query per extension.
  - ARM templates have four deployment scopes (resource-group, subscription,
    management-group, tenant), each identified by a distinct schema URL.
  - Bicep and Terraform have unique file extensions (.bicep, .tf) and
    GitHub language tags, so a single general code query per language
    suffices alongside the repo-level searches.

================================================================================
GITHUB SEARCH API CONSTRAINTS
================================================================================
  - Max 1,000 results per query (hard limit imposed by GitHub).
"""

# ---------------------------------------------------------------------------
# Permissive License List
# ---------------------------------------------------------------------------
# Following TerraDS (MSR 2025) methodology: "licenses which allow derivative
# work and redistribution." Values match the `license.spdx_id` field returned
# by the GitHub REST API.
#
# Excluded: GPL-2.0, GPL-3.0, LGPL-2.1, LGPL-3.0, AGPL-3.0 (copyleft),
#           and repositories with no license (license is null).
PERMISSIVE_LICENSES = [
    "MIT",
    "Apache-2.0",
    "BSD-2-Clause",
    "BSD-3-Clause",
    "0BSD",
    "ISC",
    "Unlicense",
    "CC0-1.0",
    "BSL-1.0",
    "Zlib",
    "CC-BY-4.0",
    "PostgreSQL",
    "WTFPL",
    "MPL-2.0",
    "MS-PL",
    "ECL-2.0",
    "Artistic-2.0",
]


# ---------------------------------------------------------------------------
# CloudFormation
# ---------------------------------------------------------------------------

# Search Repo API queries (30 req/min, returns full repo objects)
CLOUDFORMATION_REPO_QUERIES = [
    "topic:cloudformation",
    "topic:aws-cloudformation",
    "cloudformation",
]

# Search Code API queries (9 req/min, returns Minimal Repository)
# Each query targets YAML/YML files with CloudFormation-specific keywords
# and excludes SAM templates (Transform) and Kubernetes manifests (apiVersion).
CLOUDFORMATION_CODE_QUERIES = [
    'extension:yaml Resources Type "AWS::" -Transform -apiVersion',
    'extension:yml Resources Type "AWS::" -Transform -apiVersion',
    'extension:json Resources Type "AWS::" -Transform -apiVersion',
]

# Template validation rules
CLOUDFORMATION_VALID_EXTENSIONS = [".yaml", ".yml", ".json"]
CLOUDFORMATION_MUST_CONTAIN = ["Resources", "Type", "AWS::"]
CLOUDFORMATION_MUST_NOT_CONTAIN = ["Transform", "apiVersion"]


# ---------------------------------------------------------------------------
# ARM (Azure Resource Manager)
# ---------------------------------------------------------------------------

# Search Repo API queries
ARM_REPO_QUERIES = [
    "topic:arm-template",
    "topic:azure-resource-manager",
    "azure resource manager",
]

# Search Code API queries
# ARM templates are JSON files that contain the ARM schema URL and a
# resources array with Azure resource types (Microsoft.*).
ARM_CODE_QUERIES = [
    # General ARM identifiers
    'extension:json "schema.management.azure.com" "deploymentTemplate.json#" resources',
    'extension:json "schema.management.azure.com" "subscriptionDeploymentTemplate.json#" resources',
    'extension:json "schema.management.azure.com" "managementGroupDeploymentTemplate.json#" resources',
    'extension:json "schema.management.azure.com" "tenantDeploymentTemplate.json#" resources',
]

# Template validation rules
ARM_VALID_EXTENSIONS = [".json"]
ARM_MUST_CONTAIN = ["$schema", "schema.management.azure.com", "resources"]
ARM_MUST_NOT_CONTAIN = ["deploymentParameters.json#"]


# ---------------------------------------------------------------------------
# Bicep
# ---------------------------------------------------------------------------

# Search Repo API queries
BICEP_REPO_QUERIES = [
    "language:bicep",
    "topic:bicep",
    "bicep",
]

# Search Code API queries
BICEP_CODE_QUERIES = [
    "extension:bicep resource",
]

# Template validation rules
BICEP_VALID_EXTENSIONS = [".bicep"]
BICEP_MUST_CONTAIN = ["resource"]
BICEP_MUST_NOT_CONTAIN = []


# ---------------------------------------------------------------------------
# Terraform
# ---------------------------------------------------------------------------
# Terraform uses a multi-file module structure: all .tf files in the same
# directory form one logical analysis unit ("template group"). The pipeline
# groups files by directory and saves each group as a subdirectory.

# Search Repo API queries
TERRAFORM_REPO_QUERIES = [
    "language:HCL",
    "topic:terraform",
    "terraform",
]

# Search Code API queries
TERRAFORM_CODE_QUERIES = [
    "extension:tf resource",
]

# Individual .tf file validation — kept empty because single files (e.g.
# variables.tf) are valid parts of a module even without a resource block.
TERRAFORM_VALID_EXTENSIONS = [".tf"]
TERRAFORM_MUST_CONTAIN = []
TERRAFORM_MUST_NOT_CONTAIN = []

# Group-level validation: the concatenated content of all .tf files in a
# directory must contain at least one of these keywords for the group to be
# considered a meaningful Terraform module (not just an empty skeleton).
TERRAFORM_GROUP_MUST_CONTAIN = ["resource"]

# Paths that should be excluded from the file tree before grouping.
TERRAFORM_EXCLUDED_PATH_SEGMENTS = [
    ".terraform/",
    ".terraform\\",
    "terraform.tfstate",
    ".terraform.lock.hcl",
]

# ---------------------------------------------------------------------------
# Language configuration mapping (used by IaCDatasetPipeline)
# ---------------------------------------------------------------------------

LANGUAGE_CONFIG = {
    "cloudformation": {
        "label": "CloudFormation",
        "group_mode": False,
        "repo_queries": CLOUDFORMATION_REPO_QUERIES,
        "code_queries": CLOUDFORMATION_CODE_QUERIES,
        "valid_extensions": CLOUDFORMATION_VALID_EXTENSIONS,
        "must_contain": CLOUDFORMATION_MUST_CONTAIN,
        "must_not_contain": CLOUDFORMATION_MUST_NOT_CONTAIN,
        "group_must_contain": [],
        "excluded_path_segments": [],
        "repo_csv": "data/cloudformation_repositories.csv",
        "template_dir": "data/cloudformation_collected_templates_new",
        "template_csv": "data/cloudformation_collected_templates_new/dataset_metadata.csv",
    },
    "arm": {
        "label": "ARM",
        "group_mode": False,
        "repo_queries": ARM_REPO_QUERIES,
        "code_queries": ARM_CODE_QUERIES,
        "valid_extensions": ARM_VALID_EXTENSIONS,
        "must_contain": ARM_MUST_CONTAIN,
        "must_not_contain": ARM_MUST_NOT_CONTAIN,
        "group_must_contain": [],
        "excluded_path_segments": [],
        "repo_csv": "data/arm_repositories.csv",
        "template_dir": "data/arm_collected_templates_new",
        "template_csv": "data/arm_collected_templates_new/dataset_metadata.csv",
    },
    "bicep": {
        "label": "Bicep",
        "group_mode": False,
        "repo_queries": BICEP_REPO_QUERIES,
        "code_queries": BICEP_CODE_QUERIES,
        "valid_extensions": BICEP_VALID_EXTENSIONS,
        "must_contain": BICEP_MUST_CONTAIN,
        "must_not_contain": BICEP_MUST_NOT_CONTAIN,
        "group_must_contain": [],
        "excluded_path_segments": [],
        "repo_csv": "data/bicep_repositories.csv",
        "template_dir": "data/bicep_collected_templates_new_module",
        "template_csv": "data/bicep_collected_templates_new_module/dataset_metadata.csv",
    },
    "terraform": {
        "label": "Terraform",
        "group_mode": True,
        "repo_queries": TERRAFORM_REPO_QUERIES,
        "code_queries": TERRAFORM_CODE_QUERIES,
        "valid_extensions": TERRAFORM_VALID_EXTENSIONS,
        "must_contain": TERRAFORM_MUST_CONTAIN,
        "must_not_contain": TERRAFORM_MUST_NOT_CONTAIN,
        "group_must_contain": TERRAFORM_GROUP_MUST_CONTAIN,
        "excluded_path_segments": TERRAFORM_EXCLUDED_PATH_SEGMENTS,
        "repo_csv": "data/terraform_repositories.csv",
        "template_dir": "data/terraform_collected_templates_new",
        "template_csv": "data/terraform_collected_templates_new/dataset_metadata.csv",
    },
}
