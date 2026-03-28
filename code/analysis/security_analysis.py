from typing import Any, Dict, Iterator, List, Optional, Set, Tuple, Union

from analysis.base_analysis import BaseAnalysis
from config.security_smells import (
    ARM_UNRESTRICTED_VALUES,
    CIS_DANGEROUS_PORTS,
    SECRET_BEARING_PROPERTIES,
    SECRET_LIKE_PARAMETER_NAME_PATTERNS,
    SENSITIVE_CONSTRAINT_KEYS,
    SENSITIVE_PARAMETER_TYPES,
    UNRESTRICTED_IP_BIND_PROPERTIES,
)


JsonValue = Union[Dict[str, Any], List[Any], str, int, float, bool, None]


class SecurityAnalysis(BaseAnalysis):
    """
    IR-based security analysis checks.

    Currently implemented checks:
    - hard_coded_secrets: detect likely hard-coded secrets in resource properties
    - unrestricted_ip_addresses: detect use of 0.0.0.0 or 0.0.0.0/0 in resource properties

    This analysis is IR-only and language-agnostic; it relies on the unified IR
    schema (resources -> properties -> value / parameter_refs / resource_refs).
    """

    def __init__(self, ir: Dict[str, Any]):
        super().__init__(ir)
        self.language = ir.get("metadata", {}).get("template_type", "NA").lower()
        self.analysis_results: Dict[str, Any] = {}

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------
    def analyze(self, strict_port_filter: bool = True) -> Dict[str, Any]:
        """Run all security checks on the IR."""
        hard_coded_secrets = self._analyze_hard_coded_secrets()
        unrestricted_ips = self._analyze_unrestricted_ip_addresses(strict_port_filter)
        # unrestricted_ips = self._analyze_unrestricted_ip_addresses_any()
        unprotected_secrets = self._analyze_unprotected_secrets()

        if hard_coded_secrets:
            self.analysis_results["hard_coded_secrets"] = hard_coded_secrets
        if unrestricted_ips:
            self.analysis_results["unrestricted_ip_addresses"] = unrestricted_ips
        if unprotected_secrets:
            self.analysis_results["unprotected_secrets"] = unprotected_secrets

        return self.analysis_results

    def display_analysis_result(self) -> None:
        """Simple printer for interactive exploration."""
        print(self.analysis_results)

    # ------------------------------------------------------------------
    # Generic (resource_type, property_path, value) matcher
    # ------------------------------------------------------------------
    def _iter_resource_property_values(
        self,
    ) -> Iterator[Tuple[Dict[str, Any], str, Any]]:
        """
        Yield (resource, property_path, value) for every property on every
        resource (top-level and nested). Used by find_resources_with_property_value.
        """
        for resource in self.get_resources():
            resource_type = resource.get("type")
            properties = resource.get("properties", [])
            if not isinstance(properties, list):
                continue
            for prop in properties:
                prop_name = prop.get("name")
                value: JsonValue = prop.get("value")
                base_path = str(prop_name) if prop_name is not None else ""
                yield (resource, base_path, value)
                for res, path, val in self._iter_nested_property_values(
                    value, resource, base_path
                ):
                    yield (res, path, val)

    def _iter_nested_property_values(
        self,
        value: JsonValue,
        resource: Dict[str, Any],
        base_path: str,
    ) -> Iterator[Tuple[Dict[str, Any], str, Any]]:
        """Yield (resource, property_path, value) for nested dict/list values."""
        if isinstance(value, dict):
            for key, nested_val in value.items():
                key_str = str(key)
                path = f"{base_path}.{key_str}" if base_path else key_str
                yield (resource, path, nested_val)
                yield from self._iter_nested_property_values(
                    nested_val, resource, path
                )
        elif isinstance(value, list):
            for idx, item in enumerate(value):
                path = f"{base_path}[{idx}]" if base_path else f"[{idx}]"
                yield (resource, path, item)
                yield from self._iter_nested_property_values(item, resource, path)

    def find_resources_with_property_value(
        self,
        criteria: Set[Tuple[str, str, Any]],
    ) -> List[Dict[str, Any]]:
        """
        Find all resources that have a property matching (resource_type, property_path, value).

        criteria: set of tuples (resource_type, property_path, value). Resource type
        and property path must match the IR exactly (no normalization). For string
        values, comparison uses stripped value. Enables extensibility: callers can
        pass e.g. UNRESTRICTED_IP_BIND_PROPERTIES expanded with values like "0.0.0.0".

        Returns list of dicts: resource_id, resource_name, resource_type, property_path, value.
        """
        def normalize(v: Any) -> Any:
            if isinstance(v, str):
                return v.strip()
            return v

        def is_hashable(v: Any) -> bool:
            try:
                hash(v)
                return True
            except TypeError:
                return False

        criteria_normalized = set()
        for rt, path, val in criteria:
            n = normalize(val)
            if is_hashable(n):
                criteria_normalized.add((rt, path, n))

        results: List[Dict[str, Any]] = []
        for resource, property_path, value in self._iter_resource_property_values():
            resource_type = resource.get("type")
            nval = normalize(value)
            if not is_hashable(nval):
                continue
            key = (resource_type, property_path, nval)
            if key not in criteria_normalized:
                continue
            results.append(
                {
                    "resource_id": resource.get("id"),
                    "resource_name": resource.get("name"),
                    "resource_type": resource_type,
                    "property_path": property_path,
                    "value": value.strip() if isinstance(value, str) else value,
                }
            )
        return results

    # ------------------------------------------------------------------
    # Hard-coded secret detection
    # ------------------------------------------------------------------
    def _analyze_hard_coded_secrets(self) -> List[Dict[str, Any]]:
        """
        Detect hard-coded secrets in (1) resource properties and (2) parameters.

        Resources: only (resource_type, property_path) in SECRET_BEARING_PROPERTIES,
        with no parameter_refs and value literal without dependency.
        Parameters: parameter name matches SECRET_LIKE_PARAMETER_NAME_PATTERNS and
        default is a literal without dependency.
        """
        results: List[Dict[str, Any]] = []

        for resource in self.get_resources():
            resource_name = resource.get("name")
            resource_id = resource.get("id")
            resource_type = resource.get("type")
            properties = resource.get("properties", [])
            if isinstance(resource_type, dict):   # Currently not support for Rain Module which type is a dictionary
                continue

            if not isinstance(properties, list):
                continue

            for prop in properties:
                prop_name = prop.get("name")
                value: JsonValue = prop.get("value")
                param_refs = prop.get("parameter_refs", "NA")
                base_path = str(prop_name) if prop_name is not None else ""

                # 1) Top-level: only if (resource_type, prop_name) is secret-bearing.
                if isinstance(prop_name, str):
                    key = (resource_type, prop_name)
                    if (
                        key in SECRET_BEARING_PROPERTIES
                        and not self._has_parameter_refs(param_refs)
                        and self._is_literal_without_dependency(value)
                    ):
                        results.append(
                            {
                                "resource_id": resource_id,
                                "resource_name": resource_name,
                                "resource_type": resource_type,
                                "property_path": prop_name,
                            }
                        )

                # 2) Nested: only recurse and report when (resource_type, path) is in allow-list.
                self._scan_value_for_nested_secrets(
                    value=value,
                    resource_id=resource_id,
                    resource_name=resource_name,
                    resource_type=resource_type,
                    base_path=base_path,
                    results=results,
                )

        # Parameters: name pattern + literal default => hard-coded secret
        for param in self.get_parameters():
            param_name = param.get("name")
            param_id = param.get("id")
            default = param.get("default")
            if not self._is_secret_like_parameter_name(param_name):
                continue
            if default is None or default == "NA" or default == "":
                continue
            if self._is_parameter_protected(param):
                if (
                    default is not None
                    and default != "NA"
                    and default != ""
                    and self._is_literal_without_dependency(default)
                ):
                # Case defined by ARM (https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-test-cases#secure-parameters-cant-have-hard-coded-default)
                    results.append(
                        {
                            "parameter_id": param_id,
                            "parameter_name": param_name,
                            # "resource_type": "parameter",
                            # "property_path": "default",
                        }
                    )
            if not self._is_literal_without_dependency(default):
                continue
            # TODO: check if default is a SSM value
            results.append(
                {
                    "parameter_id": param_id,
                    "parameter_name": param_name,
                    # "resource_type": "parameter",
                    # "property_path": "default",
                }
            )
        # Remove duplicate parameter findings by parameter_id.
        deduped_results: List[Dict[str, Any]] = []
        seen_parameter_ids: Set[Any] = set()
        for item in results:
            parameter_id = item.get("parameter_id")
            if parameter_id not in (None, "NA"):
                if parameter_id in seen_parameter_ids:
                    continue
                seen_parameter_ids.add(parameter_id)
            deduped_results.append(item)

        return deduped_results

    def _analyze_unprotected_secrets(self) -> List[Dict[str, Any]]:
        """
        Detect unprotected secret parameters: secret-like name, no default value,
        and the sensitive/masking mechanism is not set or is false.
        """
        results: List[Dict[str, Any]] = []
        for param in self.get_parameters():
            param_type = param.get("param_type", "NA")
            param_name = param.get("name")
            param_id = param.get("id")
            default = param.get("default")
            if param_type == "data" or param_type == "locals":   # Data and local in Terraform will not be exposed in the output and no sensitive protection
                continue
            if not self._is_secret_like_parameter_name(param_name):
                continue
            if self._is_parameter_protected(param):
                continue
            results.append(
                {
                    "parameter_id": param_id,
                    "parameter_name": param_name,
                }
            )
        return results

    @staticmethod
    def _is_parameter_protected(param: Dict[str, Any]) -> bool:
        """
        True if the parameter is marked as sensitive/masked (NoEcho, sensitive,
        secureString type, etc.) so its value is not exposed in metadata/outputs.
        """
        param_type = param.get("type")
        # Case of ARM/Bicep template
        if param_type:
            type_str = str(param_type).strip().lower()
            if any(type_str == t.lower() for t in SENSITIVE_PARAMETER_TYPES):
                return True
        constraints = param.get("constraints", "NA")
        if isinstance(constraints, dict):
            for key in constraints.keys():
                if key not in SENSITIVE_CONSTRAINT_KEYS:
                    continue
                v = constraints[key]
                if v is False or v == 0:
                    continue
                if isinstance(v, str) and v.strip().lower() in ("false", "0", ""):
                    continue
                if v:
                    return True
        return False

    @staticmethod
    def _is_secret_like_parameter_name(name: Any) -> bool:
        """True if parameter name contains any of SECRET_LIKE_PARAMETER_NAME_PATTERNS (case-insensitive)."""
        if not isinstance(name, str):
            return False
        lowered = name.lower()
        return any(p in lowered for p in SECRET_LIKE_PARAMETER_NAME_PATTERNS)

    @staticmethod
    def _has_parameter_refs(parameter_refs: Any) -> bool:
        """
        Return True if the IR says this property depends on parameters.

        In the unified IR, parameter_refs is typically:
        - "NA" when there are no parameter dependencies
        - a list of parameter IDs when dependencies exist
        """
        if parameter_refs == "NA" or parameter_refs is None:
            return False
        if isinstance(parameter_refs, list):
            return len(parameter_refs) > 0
        return True

    def _scan_value_for_nested_secrets(
        self,
        value: JsonValue,
        resource_id: Any,
        resource_name: Any,
        resource_type: Any,
        base_path: str,
        results: List[Dict[str, Any]],
    ) -> None:
        """
        Recursively scan nested structures; report only when (resource_type, path)
        is in SECRET_BEARING_PROPERTIES and value is literal without dependency.
        """
        if isinstance(value, dict):
            for key, nested_val in value.items():
                key_str = str(key)
                path = f"{base_path}.{key_str}" if base_path else key_str
                key_tuple = (resource_type, path)
                if (
                    key_tuple in SECRET_BEARING_PROPERTIES
                    and self._is_literal_without_dependency(nested_val)
                ):
                    results.append(
                        {
                            "resource_id": resource_id,
                            "resource_name": resource_name,
                            "resource_type": resource_type,
                            "property_path": path,
                        }
                    )
                self._scan_value_for_nested_secrets(
                    value=nested_val,
                    resource_id=resource_id,
                    resource_name=resource_name,
                    resource_type=resource_type,
                    base_path=path,
                    results=results,
                )

        elif isinstance(value, list):
            for idx, item in enumerate(value):
                path = f"{base_path}[{idx}]" if base_path else f"[{idx}]"
                self._scan_value_for_nested_secrets(
                    value=item,
                    resource_id=resource_id,
                    resource_name=resource_name,
                    resource_type=resource_type,
                    base_path=path,
                    results=results,
                )

    @staticmethod
    def _is_literal_without_dependency(value: JsonValue) -> bool:
        """
        Return True if the value is a literal that does not appear to use
        any dependency/function construct.

        We conservatively treat the following as *non-literal* (i.e., dependent):
        - CloudFormation-style: '!Ref', '!GetAtt'
        - ARM-style references/intrinsics that read external/template state
          (e.g. parameters(), variables(), reference(), resourceId(), list*)
        - Terraform-style / generic IR: 'resource.', 'data.', '${', 'var.',
          'local.', 'module.'
        """
        # Primitive non-string values are always literals.
        if isinstance(value, (int, float, bool)) or value is None:
            return True

        if not isinstance(value, str):
            # For dicts/lists this function should not be called directly.
            return False

        lowered = value.strip()
        if not lowered:
            return True

        # ARM expressions are often written as "[ ... ]".
        # They are NOT always dependencies: e.g. [concat('a','b')] is still literal.
        # So we inspect the inner expression and only mark as dependent when it
        # references parameters/variables/resources/runtime objects.
        if lowered.startswith("[") and lowered.endswith("]"):
            lowered = lowered[1:-1].strip()
            if not lowered:
                return True

        dependency_markers = [
            "!ref",
            "!getatt",
            # ARM references / runtime intrinsics
            "parameters(",
            "variables(",
            "reference(",
            "resourceid(",
            "subscriptionresourceid(",
            "tenantresourceid(",
            "extensionresourceid(",
            "managementgroupresourceid(",
            "list",  # catches listKeys/listSecrets/list* intrinsics
            "resourcegroup(",
            "subscription(",
            "deployment(",
            # Terraform-style / generic IR
            "resource.",
            "data.",
            "${",
            "var.",
            "local.",
            "module.",
            "resolve:secretsmanager",
            "resolve:ssm-secure",
            "secretsmanager:",
            "ssm-secure:",
        ]

        lowered_cmp = lowered.lower()
        return not any(marker in lowered_cmp for marker in dependency_markers)

    # ------------------------------------------------------------------
    # Unrestricted IP detection — shared helpers
    # ------------------------------------------------------------------
    @staticmethod
    def _is_unrestricted_ip(
        value: Any,
        extra_values: Optional[Set[str]] = None,
    ) -> bool:
        """
        Return True if *value* represents unrestricted network access.

        Checks performed (case-insensitive for strings):
        1. Exact match: ``0.0.0.0``, ``0.0.0.0/0``, ``::/0``
        2. Suffix match: any CIDR ending with ``/0`` (e.g. ``10.0.0.0/0``)
        3. Optional extras (ARM wildcards ``*``, ``Internet``, ``Any``)
        """
        if not isinstance(value, str):
            return False
        trimmed = value.strip()
        if not trimmed:
            return False
        lowered = trimmed.lower()
        if lowered in ("0.0.0.0", "0.0.0.0/0", "::/0", "0000:0000:0000:0000:0000:0000:0000:0000/0"):
            return True
        if lowered.endswith("/0"):
            return True
        if extra_values and lowered in extra_values:
            return True
        return False

    @staticmethod
    def _port_range_covers_dangerous(
        from_port: Any,
        to_port: Any,
        dangerous_ports: Set[int] = CIS_DANGEROUS_PORTS,
    ) -> bool:
        """
        Return True if the port range [from_port, to_port] overlaps any
        *dangerous_ports* or represents "all traffic".

        All-traffic conventions:
        - from_port == -1 or to_port == -1
        - from_port == 0 and to_port == 65535 (full range)
        """
        try:
            fp = int(from_port)
            tp = int(to_port)
        except (TypeError, ValueError):
            return True  # unparseable → flag conservatively

        if fp == -1 or tp == -1:
            return True
        if fp == 0 and tp == 65535:
            return True
        return any(fp <= p <= tp for p in dangerous_ports)

    @staticmethod
    def _parse_arm_port_range(port_str: Any) -> Tuple[int, int]:
        """
        Parse ARM ``destinationPortRange`` into (from_port, to_port).

        ``"22"``    → (22, 22)
        ``"22-80"`` → (22, 80)
        ``"*"``     → (0, 65535)
        """
        if not isinstance(port_str, str):
            try:
                v = int(port_str)
                return (v, v)
            except (TypeError, ValueError):
                return (0, 65535)
        port_str = port_str.strip()
        if port_str == "*":
            return (0, 65535)
        if "-" in port_str:
            parts = port_str.split("-", 1)
            try:
                return (int(parts[0]), int(parts[1]))
            except (ValueError, IndexError):
                return (0, 65535)
        try:
            v = int(port_str)
            return (v, v)
        except ValueError:
            return (0, 65535)

    @staticmethod
    def _get_property_value(
        properties: Any,
        name: str,
    ) -> Any:
        """
        Look up a property value by *name* in either IR properties list or plain dict.

        IR top-level:  ``[{"name": "CidrIp", "value": "0.0.0.0/0"}, ...]``
        Nested dict:   ``{"CidrIp": "0.0.0.0/0", ...}``
        """
        if isinstance(properties, dict):
            return properties.get(name)
        if isinstance(properties, list):
            for item in properties:
                if isinstance(item, dict) and item.get("name") == name:
                    return item.get("value")
        return None

    def _property_path_matches_template(
        self, property_path: str, path_template: str
    ) -> bool:
        """
        Return True if *property_path* matches *path_template*.

        Template uses dot notation (e.g. ``ingress.cidr_blocks``); IR paths may
        contain array indices (e.g. ``ingress[0].cidr_blocks[0]``). Each template
        segment must appear in order in the actual path.
        """
        if not property_path or not path_template:
            return False
        segments = [s.strip() for s in path_template.split(".") if s.strip()]
        if not segments:
            return False
        start = 0
        for seg in segments:
            idx = property_path.find(seg, start)
            if idx == -1:
                return False
            start = idx + len(seg)
        return True

    @staticmethod
    def _strip_api_version(resource_type: str) -> str:
        """Strip the ``@api_version`` suffix from a Bicep resource type string.

        ``Microsoft.Network/networkSecurityGroups@2020-11-01``
        → ``Microsoft.Network/networkSecurityGroups``
        """
        if "@" in resource_type:
            return resource_type.split("@", 1)[0]
        return resource_type

    # ------------------------------------------------------------------
    # Unrestricted IP detection — dispatcher
    # ------------------------------------------------------------------
    def _analyze_unrestricted_ip_addresses(
        self, strict_port_filter: bool = False
    ) -> List[Dict[str, Any]]:
        """Dispatch to the language-specific unrestricted-IP checker."""
        if self.language in ("cloudformation",):
            return self._check_unrestricted_ip_cfn(strict_port_filter)
        if self.language in ("terraform",):
            return self._check_unrestricted_ip_tf(strict_port_filter)
        if self.language in ("arm",):
            return self._check_unrestricted_ip_arm(strict_port_filter)
        if self.language in ("bicep",):
            return self._check_unrestricted_ip_bicep(strict_port_filter)
        return self._check_unrestricted_ip_fallback()

    # ------------------------------------------------------------------
    # CloudFormation checker
    # ------------------------------------------------------------------
    def _check_unrestricted_ip_cfn(
        self, strict_port_filter: bool
    ) -> List[Dict[str, Any]]:
        results: List[Dict[str, Any]] = []
        seen: Set[Tuple[str, str]] = set()

        for resource in self.get_resources():
            rtype = resource.get("type")
            rid = resource.get("id")
            rname = resource.get("name")
            props = resource.get("properties", [])
            if not isinstance(props, list):
                continue

            if rtype == "AWS::EC2::SecurityGroup":
                ingress_list = self._get_property_value(props, "SecurityGroupIngress")
                if not isinstance(ingress_list, list):
                    continue
                for idx, rule in enumerate(ingress_list):
                    if not isinstance(rule, dict):
                        continue
                    cidr_ip = rule.get("CidrIp")
                    cidr_ipv6 = rule.get("CidrIpv6")
                    from_port = rule.get("FromPort")
                    to_port = rule.get("ToPort")

                    for cidr_key, cidr_val in (("CidrIp", cidr_ip), ("CidrIpv6", cidr_ipv6)):
                        if not self._is_unrestricted_ip(cidr_val):
                            continue
                        if strict_port_filter and not self._port_range_covers_dangerous(from_port, to_port):
                            continue
                        path = f"SecurityGroupIngress[{idx}].{cidr_key}"
                        key = (rid, path)
                        if key in seen:
                            continue
                        seen.add(key)
                        results.append({
                            "resource_id": rid,
                            "resource_name": rname,
                            "resource_type": rtype,
                            "property_path": path,
                            "ip_value": str(cidr_val).strip(),
                            "port": self._format_port_range(from_port, to_port),
                            "direction": None,
                        })

            elif rtype == "AWS::EC2::SecurityGroupIngress":
                cidr_ip = self._get_property_value(props, "CidrIp")
                cidr_ipv6 = self._get_property_value(props, "CidrIpv6")
                from_port = self._get_property_value(props, "FromPort")
                to_port = self._get_property_value(props, "ToPort")

                for cidr_key, cidr_val in (("CidrIp", cidr_ip), ("CidrIpv6", cidr_ipv6)):
                    if not self._is_unrestricted_ip(cidr_val):
                        continue
                    if strict_port_filter and not self._port_range_covers_dangerous(from_port, to_port):
                        continue
                    key = (rid, cidr_key)
                    if key in seen:
                        continue
                    seen.add(key)
                    results.append({
                        "resource_id": rid,
                        "resource_name": rname,
                        "resource_type": rtype,
                        "property_path": cidr_key,
                        "ip_value": str(cidr_val).strip(),
                        "port": self._format_port_range(from_port, to_port),
                        "direction": None,
                    })

        return results

    # ------------------------------------------------------------------
    # Terraform checker
    # ------------------------------------------------------------------
    def _check_unrestricted_ip_tf(
        self, strict_port_filter: bool
    ) -> List[Dict[str, Any]]:
        results: List[Dict[str, Any]] = []
        seen: Set[Tuple[str, str]] = set()

        for resource in self.get_resources():
            rtype = resource.get("type")
            rid = resource.get("id")
            rname = resource.get("name")
            props = resource.get("properties", [])
            if not isinstance(props, list):
                continue

            if rtype == "aws_security_group":
                self._check_tf_inline_ingress(
                    resource, props, results, seen, strict_port_filter
                )

            elif rtype == "aws_security_group_rule":
                self._check_tf_security_group_rule(
                    resource, props, results, seen, strict_port_filter
                )

            elif rtype == "aws_vpc_security_group_ingress_rule":
                self._check_tf_vpc_ingress_rule(
                    resource, props, results, seen, strict_port_filter
                )

            elif rtype in (
                "alicloud_security_group_rule",
                "azurerm_mariadb_firewall_rule",
                "azurerm_mssql_firewall_rule",
                "azurerm_mysql_flexible_server_firewall_rule",
                "azurerm_postgresql_firewall_rule",
                "azurerm_sql_firewall_rule",
                "ncloud_network_acl_rule",
                "ncloud_route",
                "ncloud_access_control_group_rule",
                "aws_network_acl",
                "aws_network_acl_rule",
            ):
                self._check_tf_fallback(
                    resource, props, rtype, results, seen, strict_port_filter
                )

        return results

    def _check_tf_inline_ingress(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
        strict_port_filter: bool,
    ) -> None:
        """``aws_security_group`` with inline ``ingress`` blocks."""
        rid = resource.get("id")
        rname = resource.get("name")
        rtype = resource.get("type")
        ingress_list = self._get_property_value(props, "ingress")
        if not isinstance(ingress_list, list):
            return
        for idx, rule in enumerate(ingress_list):
            if not isinstance(rule, dict):
                continue
            from_port = rule.get("from_port")
            to_port = rule.get("to_port")
            for cidr_key in ("cidr_blocks", "ipv6_cidr_blocks"):
                cidr_list = rule.get(cidr_key)
                if not isinstance(cidr_list, list):
                    continue
                for cidx, cidr_val in enumerate(cidr_list):
                    if not self._is_unrestricted_ip(cidr_val):
                        continue
                    if strict_port_filter and not self._port_range_covers_dangerous(from_port, to_port):
                        continue
                    path = f"ingress[{idx}].{cidr_key}[{cidx}]"
                    key = (rid, path)
                    if key in seen:
                        continue
                    seen.add(key)
                    results.append({
                        "resource_id": rid,
                        "resource_name": rname,
                        "resource_type": rtype,
                        "property_path": path,
                        "ip_value": str(cidr_val).strip(),
                        "port": self._format_port_range(from_port, to_port),
                        "direction": None,
                    })

    def _check_tf_security_group_rule(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
        strict_port_filter: bool,
    ) -> None:
        """``aws_security_group_rule`` — standalone rule, needs ``type == ingress``."""
        rule_type = self._get_property_value(props, "type")
        if not isinstance(rule_type, str) or rule_type.strip().lower() != "ingress":
            return
        rid = resource.get("id")
        rname = resource.get("name")
        rtype = resource.get("type")
        from_port = self._get_property_value(props, "from_port")
        to_port = self._get_property_value(props, "to_port")

        for cidr_key in ("cidr_blocks", "ipv6_cidr_blocks"):
            cidr_val = self._get_property_value(props, cidr_key)
            if isinstance(cidr_val, list):
                for cidx, cv in enumerate(cidr_val):
                    if not self._is_unrestricted_ip(cv):
                        continue
                    if strict_port_filter and not self._port_range_covers_dangerous(from_port, to_port):
                        continue
                    path = f"{cidr_key}[{cidx}]"
                    key = (rid, path)
                    if key in seen:
                        continue
                    seen.add(key)
                    results.append({
                        "resource_id": rid,
                        "resource_name": rname,
                        "resource_type": rtype,
                        "property_path": path,
                        "ip_value": str(cv).strip(),
                        "port": self._format_port_range(from_port, to_port),
                        "direction": "ingress",
                    })
            elif self._is_unrestricted_ip(cidr_val):
                if strict_port_filter and not self._port_range_covers_dangerous(from_port, to_port):
                    continue
                key = (rid, cidr_key)
                if key in seen:
                    continue
                seen.add(key)
                results.append({
                    "resource_id": rid,
                    "resource_name": rname,
                    "resource_type": rtype,
                    "property_path": cidr_key,
                    "ip_value": str(cidr_val).strip(),
                    "port": self._format_port_range(from_port, to_port),
                    "direction": "ingress",
                })

    def _check_tf_vpc_ingress_rule(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
        strict_port_filter: bool,
    ) -> None:
        """``aws_vpc_security_group_ingress_rule`` — direction is implicit."""
        rid = resource.get("id")
        rname = resource.get("name")
        rtype = resource.get("type")
        from_port = self._get_property_value(props, "from_port")
        to_port = self._get_property_value(props, "to_port")

        for cidr_key in ("cidr_ipv4", "cidr_ipv6"):
            cidr_val = self._get_property_value(props, cidr_key)
            if not self._is_unrestricted_ip(cidr_val):
                continue
            if strict_port_filter and not self._port_range_covers_dangerous(from_port, to_port):
                continue
            key = (rid, cidr_key)
            if key in seen:
                continue
            seen.add(key)
            results.append({
                "resource_id": rid,
                "resource_name": rname,
                "resource_type": rtype,
                "property_path": cidr_key,
                "ip_value": str(cidr_val).strip(),
                "port": self._format_port_range(from_port, to_port),
                "direction": None,
            })

    def _check_tf_fallback(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        rtype: str,
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
        strict_port_filter: bool = False,
    ) -> None:
        """Fallback for azurerm/ncloud/alicloud and other TF resources in UNRESTRICTED_IP_BIND_PROPERTIES."""
        rid = resource.get("id")
        rname = resource.get("name")

        # Direction-aware exclusion: for alicloud security-group rules,
        # unrestricted destination CIDR on egress is expected and should not
        # be reported by this smell (which focuses on inbound exposure).
        if rtype == "alicloud_security_group_rule":
            rule_type = self._get_property_value(props, "type")
            if not isinstance(rule_type, str) or rule_type.strip().lower() != "ingress":
                return

        if strict_port_filter and not self._tf_fallback_exposes_dangerous_ports_or_all_protocol(props):
            return

        allowed_paths = {
            path for (rt, path) in UNRESTRICTED_IP_BIND_PROPERTIES if rt == rtype
        }
        for resource_iter, property_path, value in self._iter_nested_property_values_from_props(
            props, resource
        ):
            if not isinstance(value, str):
                continue
            if not self._is_unrestricted_ip(value):
                continue
            matched = False
            for tmpl_path in allowed_paths:
                if self._property_path_matches_template(property_path, tmpl_path):
                    matched = True
                    break
            if not matched and property_path not in allowed_paths:
                continue
            key = (rid, property_path)
            if key in seen:
                continue
            seen.add(key)
            results.append({
                "resource_id": rid,
                "resource_name": rname,
                "resource_type": rtype,
                "property_path": property_path,
                "ip_value": value.strip(),
            })

    def _tf_fallback_exposes_dangerous_ports_or_all_protocol(
        self,
        props: List[Dict[str, Any]],
    ) -> bool:
        """
        Best-effort port/protocol gating for Terraform fallback resources.

        Returns True when we can identify:
        - all-protocol traffic (e.g., protocol = all/-1/*/any), or
        - a dangerous port range overlap (22/3389/7/17), or
        - no explicit port/protocol fields (keep previous fallback behavior).
        """
        protocol_keys = ("protocol", "ip_protocol")
        all_protocol_values = {"all", "-1", "*", "any"}
        for key in protocol_keys:
            proto = self._get_property_value(props, key)
            if isinstance(proto, str) and proto.strip().lower() in all_protocol_values:
                return True

        # Canonical from/to style
        from_port = self._get_property_value(props, "from_port")
        to_port = self._get_property_value(props, "to_port")
        if from_port is not None or to_port is not None:
            return self._port_range_covers_dangerous(from_port, to_port)

        # Single-port style
        port = self._get_property_value(props, "port")
        if port is not None:
            try:
                p = int(port)
                return self._port_range_covers_dangerous(p, p)
            except (TypeError, ValueError):
                pass

        # Range style used by some providers (e.g., "-1/-1", "80/80")
        port_range = self._get_property_value(props, "port_range")
        if isinstance(port_range, str):
            pr = port_range.strip()
            if "/" in pr:
                p_from, p_to = pr.split("/", 1)
                return self._port_range_covers_dangerous(p_from, p_to)
            if "-" in pr:
                p_from, p_to = pr.split("-", 1)
                return self._port_range_covers_dangerous(p_from, p_to)
            return self._port_range_covers_dangerous(pr, pr)

        # No port/protocol hints: preserve previous fallback behavior.
        return True

    def _iter_nested_property_values_from_props(
        self,
        props: List[Dict[str, Any]],
        resource: Dict[str, Any],
    ) -> Iterator[Tuple[Dict[str, Any], str, Any]]:
        """Iterate all property paths from a top-level properties list."""
        for prop in props:
            if not isinstance(prop, dict):
                continue
            prop_name = prop.get("name")
            value = prop.get("value")
            base_path = str(prop_name) if prop_name is not None else ""
            yield (resource, base_path, value)
            yield from self._iter_nested_property_values(value, resource, base_path)

    # ------------------------------------------------------------------
    # ARM / Bicep checker
    # ------------------------------------------------------------------
    def _check_unrestricted_ip_arm(
        self, strict_port_filter: bool
    ) -> List[Dict[str, Any]]:
        results: List[Dict[str, Any]] = []
        seen: Set[Tuple[str, str]] = set()

        for resource in self.get_resources():
            rtype = resource.get("type")
            rid = resource.get("id")
            rname = resource.get("name")
            props = resource.get("properties", [])
            if not isinstance(props, list):
                continue

            if rtype == "Microsoft.Network/networkSecurityGroups":
                self._check_arm_nsg(
                    resource, props, results, seen, strict_port_filter
                )
            elif rtype in (
                "Microsoft.Sql/servers",
                "Microsoft.Sql/servers/firewallRules",
            ):
                self._check_arm_sql_firewall(
                    resource, props, rtype, results, seen
                )

        return results

    def _check_arm_nsg(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
        strict_port_filter: bool,
    ) -> None:
        """``Microsoft.Network/networkSecurityGroups`` with inline security rules."""
        rid = resource.get("id")
        rname = resource.get("name")
        rtype = resource.get("type")
        security_rules = self._get_property_value(props, "securityRules")
        if not isinstance(security_rules, list):
            return

        for idx, rule in enumerate(security_rules):
            if not isinstance(rule, dict):
                continue
            rule_props = rule.get("properties")
            if not isinstance(rule_props, dict):
                continue

            direction = rule_props.get("direction", "")
            if isinstance(direction, str) and direction.strip().lower() != "inbound":
                continue
            access = rule_props.get("access", "")
            if isinstance(access, str) and access.strip().lower() != "allow":
                continue
            protocol = rule_props.get("protocol", "")
            if isinstance(protocol, str) and (protocol.strip().lower() != "tcp" and protocol.strip().lower() != "*" and protocol.strip().lower() != "udp"):
                continue

            dest_port_range = rule_props.get("destinationPortRange")
            dest_port_ranges = rule_props.get("destinationPortRanges")

            src_prefix = rule_props.get("sourceAddressPrefix")
            src_prefixes = rule_props.get("sourceAddressPrefixes")

            candidates: List[Tuple[str, str]] = []
            if isinstance(src_prefix, str):
                candidates.append(
                    (f"securityRules[{idx}].properties.sourceAddressPrefix", src_prefix)
                )
            if isinstance(src_prefixes, list):
                for pidx, sp in enumerate(src_prefixes):
                    if isinstance(sp, str):
                        candidates.append(
                            (f"securityRules[{idx}].properties.sourceAddressPrefixes[{pidx}]", sp)
                        )

            for path, addr_val in candidates:
                if not self._is_unrestricted_ip(addr_val, extra_values=ARM_UNRESTRICTED_VALUES):
                    continue

                if strict_port_filter:
                    if not self._arm_port_covers_dangerous(dest_port_range, dest_port_ranges):
                        continue

                key = (rid, path)
                if key in seen:
                    continue
                seen.add(key)
                port_display = self._format_arm_port_display(dest_port_range, dest_port_ranges)
                results.append({
                    "resource_id": rid,
                    "resource_name": rname,
                    "resource_type": rtype,
                    "property_path": path,
                    "ip_value": addr_val.strip(),
                    "port": port_display,
                    "direction": "Inbound",
                })

    def _arm_port_covers_dangerous(
        self,
        dest_port_range: Any,
        dest_port_ranges: Any,
    ) -> bool:
        """Return True if any of the ARM port specifications cover a dangerous port."""
        if isinstance(dest_port_range, (str, int)):
            fp, tp = self._parse_arm_port_range(dest_port_range)
            if self._port_range_covers_dangerous(fp, tp):
                return True
        if isinstance(dest_port_ranges, list):
            for pr in dest_port_ranges:
                fp, tp = self._parse_arm_port_range(pr)
                if self._port_range_covers_dangerous(fp, tp):
                    return True
        return False

    @staticmethod
    def _format_arm_port_display(
        dest_port_range: Any,
        dest_port_ranges: Any,
    ) -> Optional[str]:
        """Build a human-readable port string for ARM findings."""
        if isinstance(dest_port_range, (str, int)):
            return str(dest_port_range)
        if isinstance(dest_port_ranges, list):
            return ",".join(str(p) for p in dest_port_ranges)
        return None

    def _check_arm_sql_firewall(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        rtype: str,
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
    ) -> None:
        """``Microsoft.Sql/servers/firewallRules`` and nested ``firewallRules``."""
        rid = resource.get("id")
        rname = resource.get("name")

        if rtype == "Microsoft.Sql/servers/firewallRules":
            start_ip = self._get_property_value(props, "startIpAddress")
            if self._is_unrestricted_ip(start_ip):
                key = (rid, "startIpAddress")
                if key not in seen:
                    seen.add(key)
                    results.append({
                        "resource_id": rid,
                        "resource_name": rname,
                        "resource_type": rtype,
                        "property_path": "startIpAddress",
                        "ip_value": str(start_ip).strip(),
                    })
        elif rtype == "Microsoft.Sql/servers":
            fw_rules = self._get_property_value(props, "firewallRules")
            if isinstance(fw_rules, list):
                for idx, rule in enumerate(fw_rules):
                    if not isinstance(rule, dict):
                        continue
                    start_ip = rule.get("startIpAddress")
                    if self._is_unrestricted_ip(start_ip):
                        path = f"firewallRules[{idx}].startIpAddress"
                        key = (rid, path)
                        if key not in seen:
                            seen.add(key)
                            results.append({
                                "resource_id": rid,
                                "resource_name": rname,
                                "resource_type": rtype,
                                "property_path": path,
                                "ip_value": str(start_ip).strip(),
                            })

    # ------------------------------------------------------------------
    # Bicep checker
    # ------------------------------------------------------------------
    def _check_unrestricted_ip_bicep(
        self, strict_port_filter: bool
    ) -> List[Dict[str, Any]]:
        """Bicep-specific unrestricted-IP checker.

        Bicep resource types carry an ``@api_version`` suffix
        (e.g. ``Microsoft.Network/networkSecurityGroups@2020-11-01``) and
        standalone security rules are expressed as separate resources
        (``Microsoft.Network/networkSecurityGroups/securityRules@…``).
        """
        results: List[Dict[str, Any]] = []
        seen: Set[Tuple[str, str]] = set()

        for resource in self.get_resources():
            rtype = resource.get("type")
            if not isinstance(rtype, str):
                continue
            base_type = self._strip_api_version(rtype)
            props = resource.get("properties", [])
            if not isinstance(props, list):
                continue

            if base_type == "Microsoft.Network/networkSecurityGroups":
                self._check_bicep_nsg_inline(
                    resource, props, results, seen, strict_port_filter
                )
            elif base_type == "Microsoft.Network/networkSecurityGroups/securityRules":
                self._check_bicep_nsg_standalone_rule(
                    resource, props, results, seen, strict_port_filter
                )
            elif base_type in (
                "Microsoft.Sql/servers",
                "Microsoft.Sql/servers/firewallRules",
                "Microsoft.DBforMySQL/flexibleServers/firewallRules",
                "Microsoft.DBforPostgreSQL/flexibleServers/firewallRules",
                "Microsoft.DBforMariaDB/servers/firewallRules",
            ):
                self._check_bicep_sql_firewall(
                    resource, props, base_type, results, seen
                )

        return results

    def _check_bicep_nsg_inline(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
        strict_port_filter: bool,
    ) -> None:
        """Inline ``securityRules`` within a Bicep NSG resource."""
        rid = resource.get("id")
        rname = resource.get("name")
        rtype = resource.get("type")
        security_rules = self._get_property_value(props, "securityRules")
        if not isinstance(security_rules, list):
            return

        for idx, rule in enumerate(security_rules):
            if not isinstance(rule, dict):
                continue
            rule_props = rule.get("properties")
            if not isinstance(rule_props, dict):
                continue

            direction = rule_props.get("direction", "")
            if isinstance(direction, str) and direction.strip().lower() != "inbound":
                continue
            access = rule_props.get("access", "")
            if isinstance(access, str) and access.strip().lower() != "allow":
                continue
            protocol = rule_props.get("protocol", "")
            if isinstance(protocol, str) and protocol.strip().lower() not in (
                "tcp", "*", "udp",
            ):
                continue

            dest_port_range = rule_props.get("destinationPortRange")
            dest_port_ranges = rule_props.get("destinationPortRanges")
            src_prefix = rule_props.get("sourceAddressPrefix")
            src_prefixes = rule_props.get("sourceAddressPrefixes")

            candidates: List[Tuple[str, str]] = []
            if isinstance(src_prefix, str):
                candidates.append(
                    (f"securityRules[{idx}].properties.sourceAddressPrefix", src_prefix)
                )
            if isinstance(src_prefixes, list):
                for pidx, sp in enumerate(src_prefixes):
                    if isinstance(sp, str):
                        candidates.append(
                            (f"securityRules[{idx}].properties.sourceAddressPrefixes[{pidx}]", sp)
                        )

            for path, addr_val in candidates:
                if not self._is_unrestricted_ip(addr_val, extra_values=ARM_UNRESTRICTED_VALUES):
                    continue
                if strict_port_filter:
                    if not self._arm_port_covers_dangerous(dest_port_range, dest_port_ranges):
                        continue
                key = (rid, path)
                if key in seen:
                    continue
                seen.add(key)
                port_display = self._format_arm_port_display(dest_port_range, dest_port_ranges)
                results.append({
                    "resource_id": rid,
                    "resource_name": rname,
                    "resource_type": rtype,
                    "property_path": path,
                    "ip_value": addr_val.strip(),
                    "port": port_display,
                    "direction": "Inbound",
                })

    def _check_bicep_nsg_standalone_rule(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
        strict_port_filter: bool,
    ) -> None:
        """Standalone ``Microsoft.Network/networkSecurityGroups/securityRules`` resource."""
        rid = resource.get("id")
        rname = resource.get("name")
        rtype = resource.get("type")

        direction = self._get_property_value(props, "direction")
        if isinstance(direction, str) and direction.strip().lower() != "inbound":
            return
        access = self._get_property_value(props, "access")
        if isinstance(access, str) and access.strip().lower() != "allow":
            return
        protocol = self._get_property_value(props, "protocol")
        if isinstance(protocol, str) and protocol.strip().lower() not in (
            "tcp", "*", "udp",
        ):
            return

        dest_port_range = self._get_property_value(props, "destinationPortRange")
        dest_port_ranges = self._get_property_value(props, "destinationPortRanges")
        src_prefix = self._get_property_value(props, "sourceAddressPrefix")
        src_prefixes = self._get_property_value(props, "sourceAddressPrefixes")

        candidates: List[Tuple[str, str]] = []
        if isinstance(src_prefix, str):
            candidates.append(("sourceAddressPrefix", src_prefix))
        if isinstance(src_prefixes, list):
            for pidx, sp in enumerate(src_prefixes):
                if isinstance(sp, str):
                    candidates.append((f"sourceAddressPrefixes[{pidx}]", sp))

        for path, addr_val in candidates:
            if not self._is_unrestricted_ip(addr_val, extra_values=ARM_UNRESTRICTED_VALUES):
                continue
            if strict_port_filter:
                if not self._arm_port_covers_dangerous(dest_port_range, dest_port_ranges):
                    continue
            key = (rid, path)
            if key in seen:
                continue
            seen.add(key)
            port_display = self._format_arm_port_display(dest_port_range, dest_port_ranges)
            results.append({
                "resource_id": rid,
                "resource_name": rname,
                "resource_type": rtype,
                "property_path": path,
                "ip_value": addr_val.strip(),
                "port": port_display,
                "direction": "Inbound",
            })

    def _check_bicep_sql_firewall(
        self,
        resource: Dict[str, Any],
        props: List[Dict[str, Any]],
        base_type: str,
        results: List[Dict[str, Any]],
        seen: Set[Tuple[str, str]],
    ) -> None:
        """SQL / MySQL / PostgreSQL / MariaDB firewall rules in Bicep."""
        rid = resource.get("id")
        rname = resource.get("name")
        rtype = resource.get("type")

        if base_type.endswith("/firewallRules"):
            start_ip = self._get_property_value(props, "startIpAddress")
            if self._is_unrestricted_ip(start_ip):
                key = (rid, "startIpAddress")
                if key not in seen:
                    seen.add(key)
                    results.append({
                        "resource_id": rid,
                        "resource_name": rname,
                        "resource_type": rtype,
                        "property_path": "startIpAddress",
                        "ip_value": str(start_ip).strip(),
                    })
        elif base_type == "Microsoft.Sql/servers":
            fw_rules = self._get_property_value(props, "firewallRules")
            if isinstance(fw_rules, list):
                for idx, rule in enumerate(fw_rules):
                    if not isinstance(rule, dict):
                        continue
                    start_ip = rule.get("startIpAddress")
                    if self._is_unrestricted_ip(start_ip):
                        path = f"firewallRules[{idx}].startIpAddress"
                        key = (rid, path)
                        if key not in seen:
                            seen.add(key)
                            results.append({
                                "resource_id": rid,
                                "resource_name": rname,
                                "resource_type": rtype,
                                "property_path": path,
                                "ip_value": str(start_ip).strip(),
                            })

    # ------------------------------------------------------------------
    # Fallback (unknown language) — broad sweep
    # ------------------------------------------------------------------
    def _check_unrestricted_ip_fallback(self) -> List[Dict[str, Any]]:
        """
        Language-agnostic broad sweep using UNRESTRICTED_IP_BIND_PROPERTIES.
        Used when self.language is not recognized.
        """
        results: List[Dict[str, Any]] = []
        seen: Set[Tuple[str, str]] = set()
        for resource, property_path, value in self._iter_resource_property_values():
            if not isinstance(value, str):
                continue
            if not self._is_unrestricted_ip(value):
                continue
            resource_type = resource.get("type")
            if not resource_type:
                continue
            for (rt, path_tmpl) in UNRESTRICTED_IP_BIND_PROPERTIES:
                if rt != resource_type:
                    continue
                if property_path == path_tmpl or self._property_path_matches_template(
                    property_path, path_tmpl
                ):
                    key = (resource.get("id"), property_path)
                    if key in seen:
                        continue
                    seen.add(key)
                    results.append({
                        "resource_id": resource.get("id"),
                        "resource_name": resource.get("name"),
                        "resource_type": resource_type,
                        "property_path": property_path,
                        "ip_value": value.strip(),
                    })
                    break
        return results

    @staticmethod
    def _format_port_range(from_port: Any, to_port: Any) -> Optional[str]:
        """Format a port range pair into a display string, or None if unavailable."""
        if from_port is None and to_port is None:
            return None
        try:
            fp = int(from_port) if from_port is not None else None
            tp = int(to_port) if to_port is not None else None
        except (TypeError, ValueError):
            return f"{from_port}-{to_port}"
        if fp is not None and tp is not None:
            if fp == tp:
                return str(fp)
            return f"{fp}-{tp}"
        if fp is not None:
            return str(fp)
        return str(tp)

