import os
import re
import uuid
from pathlib import Path
from typing import Dict, Any, List, Optional, Tuple, Set

from pycep import BicepParser as PycepParser
from pycep.models import BicepElement
from config.config import OUTPUT_PREFIX
from helper.save_file_loaded_result import save_file_loaded_result


class BicepPycepParser:
    """
    Bicep parser that uses pycep (Python Bicep parser) to parse Bicep files
    directly into our IR, bypassing the Bicep CLI and ARM JSON conversion.

    This avoids the Bicep CLI's strict type checking and linting which can
    prevent ARM output generation for templates with minor semantic errors.
    """

    def __init__(self, template_path: str):
        self.template_path = template_path
        self.param_name_to_id: Dict[str, str] = {}
        self.var_name_to_id: Dict[str, str] = {}
        self.resource_name_to_id: Dict[str, str] = {}
        self.module_name_to_id: Dict[str, str] = {}
        self.para_name_to_id: Dict[str, str] = {}
        self.condition_name_to_id: Dict[str, str] = {}
        self.conditions: List[Dict[str, Any]] = []
        self.parameters: List[Dict[str, Any]] = []
        self.all_param_names: Set[str] = set()
        self.all_var_names: Set[str] = set()
        self.all_resource_names: Set[str] = set()
        self.all_module_names: Set[str] = set()

    def parse(self) -> Optional[Dict[str, Any]]:
        """Parse Bicep template and return structured IR."""
        try:
            bicep_path = Path(self.template_path)
            content = bicep_path.read_text(encoding='utf-8-sig')
            pycep_parser = PycepParser()
            bicep_json = pycep_parser.parse(text=content)
            save_file_loaded_result(bicep_json)
        except Exception as e:
            raise Exception(f"pycep parse error: {str(e)}")

        self._register_names_to_ids(bicep_json)

        metadata = self._extract_metadata(bicep_json)
        parameters = self._extract_parameters(bicep_json)
        variables = self._extract_variables(bicep_json)
        parameters.extend(variables)
        self.parameters = parameters
        resources = self._extract_resources(bicep_json)
        modules = self._extract_modules(bicep_json)
        resources.extend(modules)
        outputs = self._extract_outputs(bicep_json)
        conditions = self.conditions

        return {
            'metadata': metadata,
            'parameters': parameters,
            'conditions': conditions,
            'resources': resources,
            'outputs': outputs,
        }

    # ──────────────────────────────────────────────
    # Registration
    # ──────────────────────────────────────────────

    def _register_names_to_ids(self, bicep_json: Dict[str, Any]) -> None:
        for name in bicep_json.get('parameters', {}):
            pid = str(uuid.uuid4())
            self.param_name_to_id[name] = pid
            self.para_name_to_id[name] = pid
            self.all_param_names.add(name)

        for name in bicep_json.get('variables', {}):
            vid = str(uuid.uuid4())
            self.var_name_to_id[name] = vid
            self.para_name_to_id[name] = vid
            self.all_var_names.add(name)

        for name in bicep_json.get('resources', {}):
            rid = str(uuid.uuid4())
            self.resource_name_to_id[name] = rid
            self.all_resource_names.add(name)

        for name in bicep_json.get('modules', {}):
            mid = str(uuid.uuid4())
            self.module_name_to_id[name] = mid
            self.all_module_names.add(name)

    # ──────────────────────────────────────────────
    # Metadata
    # ──────────────────────────────────────────────

    def _extract_metadata(self, bicep_json: Dict[str, Any]) -> Dict[str, Any]:
        file_name = os.path.basename(self.template_path)
        scope_value = bicep_json.get('globals', {}).get('scope', {}).get('value', 'resourceGroup')

        description = 'NA'
        additional_info: Dict[str, Any] = {'scope': scope_value}

        metadata_section = bicep_json.get('metadata', {})
        if isinstance(metadata_section, dict):
            for key, attrs in metadata_section.items():
                if isinstance(attrs, dict):
                    val = attrs.get('value', attrs)
                else:
                    val = attrs
                if key == 'description':
                    description = str(val) if val else 'NA'
                else:
                    additional_info[key] = val

        return {
            'template_id': str(uuid.uuid4()),
            'template_type': 'Bicep',
            'cloud_service_provider': 'Azure',
            'file_name': file_name,
            'description': description,
            'additional_info': additional_info if additional_info else 'NA',
        }

    # ──────────────────────────────────────────────
    # Parameters
    # ──────────────────────────────────────────────

    def _extract_parameters(self, bicep_json: Dict[str, Any]) -> List[Dict[str, Any]]:
        params = []
        for name, attrs in bicep_json.get('parameters', {}).items():
            pid = self.param_name_to_id.get(name, str(uuid.uuid4()))
            param_type = attrs.get('type', 'NA')
            default = attrs.get('default')
            if default is None:
                default = 'NA'
            decorators = attrs.get('decorators', [])
            for decorator in decorators:
                if decorator.get('type', 'NA').lower() == 'secure':
                    param_type = f'secure{param_type.capitalize()}'   # Update
                    break
            description = self._get_decorator_value(decorators, 'description', 'NA')
            constraints = self._extract_constraints(decorators, param_type, name)

            dep_params, dep_resources = self._extract_dependencies_from_value(default)
            params.append({
                'id': pid,
                'name': name,
                'type': param_type,
                'param_type': 'parameter',
                'default': default,
                'constraints': constraints,
                'description': description,
                'depend_parameter': dep_params if dep_params else 'NA',
                'depend_resource': dep_resources if dep_resources else 'NA',
                'depend_condition': 'NA',
            })
        return params

    def _extract_constraints(self, decorators: List[Dict], param_type: str, param_name: str) -> Dict[str, Any]:
        constraints: Dict[str, Any] = {}

        smt_type = 'String'
        if param_type == 'int':
            smt_type = 'Int'
        elif param_type == 'bool':
            smt_type = 'Bool'

        expressions = [f"(declare-const {param_name} {smt_type})"]

        for deco in decorators:
            deco_type = deco.get('type', '')
            if deco_type == 'min_value':
                val = deco.get('argument')
                constraints['min_value'] = val
                if smt_type == 'Int':
                    expressions.append(f'(assert (>= {param_name} {val}))')
            elif deco_type == 'max_value':
                val = deco.get('argument')
                constraints['max_value'] = val
                if smt_type == 'Int':
                    expressions.append(f'(assert (<= {param_name} {val}))')
            elif deco_type == 'min_length':
                constraints['min_length'] = deco.get('argument')
            elif deco_type == 'max_length':
                constraints['max_length'] = deco.get('argument')
            elif deco_type == 'allowed':
                allowed_vals = deco.get('argument', [])
                if allowed_vals:
                    constraints['allowed_values'] = allowed_vals
                    values = []
                    for v in allowed_vals:
                        if isinstance(v, bool):
                            values.append(str(v).lower())
                        else:
                            values.append(v)
                    if len(values) == 1:
                        if smt_type == 'Int':
                            expressions.append(f'(assert (= {param_name} {values[0]}))')
                        elif smt_type == 'Bool':
                            expressions.append(f'(assert (= {param_name} {values[0]}))')
                        else:
                            expressions.append(f'(assert (= {param_name} "{values[0]}"))')
                    else:
                        if smt_type == 'Int':
                            or_conds = " ".join(f'(= {param_name} {v})' for v in values)
                        elif smt_type == 'Bool':
                            or_conds = " ".join(f'(= {param_name} {v})' for v in values)
                        else:
                            or_conds = " ".join(f'(= {param_name} "{v}")' for v in values)
                        expressions.append(f'(assert (or {or_conds}))')

        constraints['expressions'] = expressions
        return constraints if constraints else {}

    # ──────────────────────────────────────────────
    # Variables
    # ──────────────────────────────────────────────

    def _extract_variables(self, bicep_json: Dict[str, Any]) -> List[Dict[str, Any]]:
        variables = []
        for name, attrs in bicep_json.get('variables', {}).items():
            vid = self.var_name_to_id.get(name, str(uuid.uuid4()))
            value = attrs.get('value', 'NA')
            dep_params, dep_resources = self._extract_dependencies_from_value(value)
            dep_conditions = self._extract_condition_refs_from_value(value, name)

            variables.append({
                'id': vid,
                'name': name,
                'type': attrs.get('type', 'NA') if attrs.get('type') else 'NA',
                'param_type': 'variables',
                'default': value,
                'constraints': {},
                'description': 'NA',
                'depend_parameter': dep_params if dep_params else 'NA',
                'depend_resource': dep_resources if dep_resources else 'NA',
                'depend_condition': dep_conditions if dep_conditions else 'NA',
            })
        return variables

    # ──────────────────────────────────────────────
    # Resources
    # ──────────────────────────────────────────────

    def _extract_resources(self, bicep_json: Dict[str, Any]) -> List[Dict[str, Any]]:
        resources = []
        for name, attrs in bicep_json.get('resources', {}).items():
            rid = self.resource_name_to_id.get(name, str(uuid.uuid4()))
            resource_type = attrs.get('type', 'NA')
            api_version = attrs.get('api_version', '')
            full_type = f"{resource_type}@{api_version}" if api_version else resource_type

            config = attrs.get('config', {})
            actual_config, deploy_condition_expr, loop_info = self._unwrap_config(config)

            properties_data = actual_config.get('properties', {})
            property_units = self._extract_resource_properties(properties_data)

            arguments = self._extract_resource_arguments(actual_config, name)

            if deploy_condition_expr is not None:
                cond_id = self._create_condition_from_expression(
                    deploy_condition_expr, f"deploy_condition_{name}"
                )
                if 'condition' not in arguments or arguments == 'NA':
                    if arguments == 'NA':
                        arguments = {}
                    arguments['condition'] = {
                        'condition_id': cond_id,
                        'true_value': '1',
                        'false_value': '0',
                    }

            if loop_info is not None:
                dep_params, dep_resources = self._extract_dependencies_from_value(loop_info)
                if arguments == 'NA':
                    arguments = {}
                arguments['for_loop'] = {
                    'value': loop_info,
                    'resource_refs': dep_resources if dep_resources else 'NA',
                    'parameter_refs': dep_params if dep_params else 'NA',
                }

            resources.append({
                'id': rid,
                'name': name,
                'type': full_type,
                'properties': property_units if property_units else 'NA',
                'arguments': arguments if arguments else 'NA',
            })
        return resources

    def _extract_modules(self, bicep_json: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract Bicep modules as resource entries in the IR."""
        resources = []
        for name, attrs in bicep_json.get('modules', {}).items():
            mid = self.module_name_to_id.get(name, str(uuid.uuid4()))
            module_type = attrs.get('type', 'unknown')
            detail = attrs.get('detail', {})
            module_path = detail.get('full', '') if isinstance(detail, dict) else ''
            display_type = f"module({module_path})" if module_path else f"module({module_type})"

            config = attrs.get('config', {})
            actual_config, deploy_condition_expr, loop_info = self._unwrap_config(config)

            property_units = self._extract_resource_properties(actual_config)
            arguments = self._extract_resource_arguments(actual_config, name)

            if deploy_condition_expr is not None:
                cond_id = self._create_condition_from_expression(
                    deploy_condition_expr, f"deploy_condition_{name}"
                )
                if arguments == 'NA':
                    arguments = {}
                arguments['condition'] = {
                    'condition_id': cond_id,
                    'true_value': '1',
                    'false_value': '0',
                }

            if loop_info is not None:
                dep_params, dep_resources = self._extract_dependencies_from_value(loop_info)
                if arguments == 'NA':
                    arguments = {}
                arguments['for_loop'] = {
                    'value': loop_info,
                    'resource_refs': dep_resources if dep_resources else 'NA',
                    'parameter_refs': dep_params if dep_params else 'NA',
                }

            resources.append({
                'id': mid,
                'name': name,
                'type': display_type,
                'properties': property_units if property_units else 'NA',
                'arguments': arguments if arguments else 'NA',
            })
        return resources

    def _unwrap_config(self, config: Any) -> Tuple[Dict[str, Any], Any, Optional[Dict[str, Any]]]:
        """
        Unwrap config that may be a DeployCondition or Loop.
        Returns (actual_config_dict, deploy_condition_expression_or_None, loop_type_or_None).
        """
        if not isinstance(config, dict):
            return {}, None, None

        if 'condition' in config and 'config' in config and 'loop_type' not in config:
            return config['config'], config['condition'], None

        if 'loop_type' in config:
            inner = config.get('config', {})
            loop_cond = config.get('condition')
            loop_info = config.get('loop_type')
            return inner, loop_cond, loop_info

        return config, None, None

    def _extract_resource_properties(self, properties_data: Any) -> List[Dict[str, Any]]:
        if not properties_data:
            return []
        if isinstance(properties_data, str):   # Case the property is an object parameter
            param_id = self.para_name_to_id.get(properties_data, 'NA')
            return [{
                'name': 'property',
                'value': properties_data,
                'resource_refs': 'NA',
                'parameter_refs': [param_id] if param_id else 'NA',
                'depend_conditions': 'NA',
            }]
        property_units = []
        for prop_name, prop_value in properties_data.items():
            dep_params, dep_resources = self._extract_dependencies_from_value(prop_value)
            dep_conditions = self._extract_condition_refs_from_value(prop_value)

            property_units.append({
                'name': prop_name,
                'value': prop_value,
                'resource_refs': dep_resources if dep_resources else 'NA',
                'parameter_refs': dep_params if dep_params else 'NA',
                'depend_conditions': dep_conditions if dep_conditions else 'NA',
            })
        return property_units

    def _extract_resource_arguments(self, config: Dict[str, Any], resource_name: str) -> Dict[str, Any]:
        if not config:
            return 'NA'

        arguments = {}
        skip_keys = {'properties'}

        for key, value in config.items():
            if key in skip_keys:
                continue

            if key in ('dependsOn', 'depends_on'):
                resource_refs = self._resolve_depends_on(value)
                arguments['depends_on'] = {
                    'value': value,
                    'resource_refs': resource_refs if resource_refs else 'NA',
                    'parameter_refs': 'NA',
                }

            else:
                dep_params, dep_resources = self._extract_dependencies_from_value(value)
                arguments[key] = {
                    'value': value,
                    'resource_refs': dep_resources if dep_resources else 'NA',
                    'parameter_refs': dep_params if dep_params else 'NA',
                }

        return arguments if arguments else 'NA'

    def _resolve_depends_on(self, value: Any) -> List[str]:
        """Resolve dependsOn values to resource names."""
        resource_refs = []
        if isinstance(value, list):
            for item in value:
                name = str(item) if isinstance(item, str) else str(item)
                if name in self.resource_name_to_id:
                    resource_refs.append(name)
                elif name in self.module_name_to_id:
                    resource_refs.append(name)
                else:
                    resource_refs.append(name)
        elif isinstance(value, str):
            resource_refs.append(str(value))
        return resource_refs

    # ──────────────────────────────────────────────
    # Outputs
    # ──────────────────────────────────────────────

    def _extract_outputs(self, bicep_json: Dict[str, Any]) -> List[Dict[str, Any]]:
        outputs = []
        for name, attrs in bicep_json.get('outputs', {}).items():
            output_value = attrs.get('value', 'NA')
            decorators = attrs.get('decorators', [])
            description = self._get_decorator_value(decorators, 'description', 'NA')

            dep_params, dep_resources = self._extract_dependencies_from_value(output_value)
            dep_conditions = self._extract_condition_refs_from_value(output_value)

            value_entry = {
                'value': output_value,
                'depend_conditions': dep_conditions if dep_conditions else 'NA',
            }

            outputs.append({
                'id': str(uuid.uuid4()),
                'name': f"{OUTPUT_PREFIX}{name}",
                'description': description,
                'value': value_entry,
                'source_resource': dep_resources if dep_resources else 'NA',
                'source_parameter': dep_params if dep_params else 'NA',
                'export_name': {
                    'name': name,
                    'depend_parameter': 'NA',
                    'depend_resource': 'NA',
                    'depend_conditions': 'NA',
                },
                'depend_conditions': 'NA',
            })
        return outputs

    # ──────────────────────────────────────────────
    # Dependency extraction
    # ──────────────────────────────────────────────

    def _extract_dependencies_from_value(self, value: Any) -> Tuple[List[str], List[str]]:
        """
        Walk a pycep value tree and collect parameter/variable IDs and resource IDs.
        Uses isinstance(v, BicepElement) to distinguish references from literal strings.
        Skips property names in accessor operators to avoid false matches.
        """
        param_ids: List[str] = []
        resource_ids: List[str] = []
        visited_refs: Set[str] = set()

        def _resolve_ref(ref_name: str) -> None:
            if ref_name in visited_refs:
                return
            visited_refs.add(ref_name)
            if ref_name in self.para_name_to_id:
                param_ids.append(self.para_name_to_id[ref_name])
            elif ref_name in self.resource_name_to_id:
                resource_ids.append(self.resource_name_to_id[ref_name])
            elif ref_name in self.module_name_to_id:
                resource_ids.append(self.module_name_to_id[ref_name])

        _INTERP_RE = re.compile(r'\$\{([^}]+)\}')
        _IDENT_RE = re.compile(r'\b[a-zA-Z_]\w*\b')

        def _extract_refs_from_interpolation(s: str) -> None:
            for match in _INTERP_RE.finditer(s):
                for ident in _IDENT_RE.findall(match.group(1)):
                    _resolve_ref(ident)

        def walk(obj: Any) -> None:
            if isinstance(obj, BicepElement):
                _resolve_ref(str(obj))
            elif isinstance(obj, str):
                if '${' in obj:
                    _extract_refs_from_interpolation(obj)
            elif isinstance(obj, dict):
                op = obj.get('operator')
                func = obj.get('function')
                if isinstance(op, dict):
                    _walk_operator(op)
                elif isinstance(func, dict):
                    _walk_function(func)
                else:
                    for v in obj.values():
                        walk(v)
            elif isinstance(obj, list):
                for item in obj:
                    walk(item)

        def _walk_operator(op: dict) -> None:
            op_type = op.get('type', '')
            operands = op.get('operands', {})

            if op_type == 'property_accessor':
                walk(operands.get('operand_1'))
                # operand_2 is a property name, not a reference — skip it
            elif op_type == 'function_accessor':
                walk(operands.get('operand_1'))
                # func_name is a method name — skip it
                for key, val in operands.items():
                    if key not in ('operand_1', 'func_name'):
                        walk(val)
            elif op_type == 'nested_resource_accessor':
                walk(operands.get('operand_1'))
                walk(operands.get('operand_2'))
            else:
                for val in operands.values():
                    walk(val)

        def _walk_function(func: Any) -> None:
            if not isinstance(func, dict):
                return
            params = func.get('parameters', {})
            if isinstance(params, dict):
                for v in params.values():
                    walk(v)

        walk(value)
        return param_ids, resource_ids

    # ──────────────────────────────────────────────
    # Condition handling
    # ──────────────────────────────────────────────

    def _extract_condition_refs_from_value(self, value: Any, var_name: Optional[str] = None) -> List[str]:
        """Find ternary (conditional) operators in a value and create condition entries."""
        condition_ids: List[str] = []

        def walk(obj: Any) -> None:
            if isinstance(obj, dict):
                if 'operator' in obj:
                    op = obj['operator']
                    if isinstance(op, dict) and op.get('type') == 'conditional':
                        operands = op.get('operands', {})
                        cond_expr = operands.get('condition')
                        cond_name = f"condition_{len(self.conditions) + 1}"
                        if var_name:
                            cond_name = f"condition_{var_name}"
                        cond_id = self._create_condition_from_expression(cond_expr, cond_name)
                        condition_ids.append(cond_id)
                        walk(operands.get('true_value'))
                        walk(operands.get('false_value'))
                        return
                for v in obj.values():
                    walk(v)
            elif isinstance(obj, list):
                for item in obj:
                    walk(item)

        walk(value)
        return condition_ids

    def _create_condition_from_expression(self, expr: Any, cond_name: str) -> str:
        """Create a condition entry from a pycep expression and return its ID."""
        cond_id = str(uuid.uuid4())

        dep_params, dep_resources = self._extract_dependencies_from_value(expr)
        dep_param_ids = dep_params if dep_params else 'NA'

        try:
            smt_expressions = self._convert_bicep_condition_to_smt(expr, cond_name)
        except Exception as e:
            # print(f"Error converting condition to SMT-LIB2 format: {e}")
            smt_expressions = []

        condition_element = {
            'id': cond_id,
            'name': cond_name,
            'condition': smt_expressions if smt_expressions else 'NA',
            'ruled_para': 'NA',
            'constraint': 'NA',
            'description': 'NA',
            'depend_para': dep_param_ids,
            'depend_cond': 'NA',
        }

        self.conditions.append(condition_element)
        self.condition_name_to_id[cond_name] = cond_id
        return cond_id

    def _convert_bicep_condition_to_smt(self, expr: Any, cond_name: str) -> List[str]:
        """Convert a pycep condition expression to SMT-LIB2 format."""
        depend_params: Set[str] = set()
        smt_body = self._expr_to_smt(expr, depend_params)
        if not smt_body:
            return []

        smt_expressions: List[str] = []
        for p_name in depend_params:
            smt_type = self._get_smt_type_for_param_name(p_name)
            smt_expressions.append(f"(declare-const {p_name} {smt_type})")

        smt_expressions.append(f"(assert {smt_body})")
        return smt_expressions

    def _expr_to_smt(self, expr: Any, depend_params: Set[str]) -> str:
        """Recursively convert a pycep expression to an SMT-LIB2 string."""
        if expr is None:
            return ''

        if isinstance(expr, bool):
            return str(expr).lower()
        if isinstance(expr, int):
            return str(expr)

        if isinstance(expr, BicepElement):
            name = str(expr)
            if name in self.all_param_names or name in self.all_var_names:
                depend_params.add(name)
                return name
            return f'"{name}"'

        if isinstance(expr, str):
            return f'"{expr}"'

        if isinstance(expr, dict):
            op = expr.get('operator')
            func = expr.get('function')
            if isinstance(op, dict):
                return self._operator_to_smt(op, depend_params)
            if isinstance(func, dict):
                return self._function_to_smt(func, depend_params)
            for v in expr.values():
                return self._expr_to_smt(v, depend_params)

        return ''

    def _operator_to_smt(self, op: Dict[str, Any], depend_params: Set[str]) -> str:
        op_type = op.get('type', '')
        operands = op.get('operands', {})

        op_map = {
            'equals': '=', 'not_equals': 'distinct',
            'greater_than': '>', 'greater_than_or_equals': '>=',
            'less_than': '<', 'less_than_or_equals': '<=',
        }

        if op_type in op_map:
            left = self._expr_to_smt(operands.get('operand_1'), depend_params)
            right = self._expr_to_smt(operands.get('operand_2'), depend_params)
            return f"({op_map[op_type]} {left} {right})"

        if op_type == 'and':
            parts = [self._expr_to_smt(v, depend_params) for v in operands.values() if v is not None]
            parts = [p for p in parts if p]
            return f"(and {' '.join(parts)})" if len(parts) >= 2 else (parts[0] if parts else '')

        if op_type == 'or':
            parts = [self._expr_to_smt(v, depend_params) for v in operands.values() if v is not None]
            parts = [p for p in parts if p]
            return f"(or {' '.join(parts)})" if len(parts) >= 2 else (parts[0] if parts else '')

        if op_type == 'not':
            inner = self._expr_to_smt(operands.get('bool_value'), depend_params)
            return f"(not {inner})" if inner else ''

        if op_type == 'conditional':
            cond = self._expr_to_smt(operands.get('condition'), depend_params)
            return cond

        return ''

    def _function_to_smt(self, func: Dict[str, Any], depend_params: Set[str]) -> str:
        func_type = func.get('type', '')
        params = func.get('parameters', {})

        if func_type == 'empty':
            val = self._expr_to_smt(params.get('item_to_test'), depend_params)
            return f'(or (= {val} "") (= {val} "null"))' if val else ''

        if func_type == 'contains':
            container = self._expr_to_smt(params.get('container'), depend_params)
            item = self._expr_to_smt(params.get('item_to_find'), depend_params)
            var_name = f"contains_{abs(hash(f'{container}_{item}')) % 10000}"
            depend_params.add(var_name)
            return var_name

        return ''

    def _get_smt_type_for_param_name(self, name: str) -> str:
        if name in self.param_name_to_id:
            for p in self.parameters:
                if p.get('name') == name:
                    t = p.get('type', 'string')
                    if t == 'int':
                        return 'Int'
                    if t == 'bool':
                        return 'Bool'
                    return 'String'
        if name in self.var_name_to_id:
            for p in self.parameters:
                if p.get('name') == name and p.get('param_type') == 'variables':
                    val = str(p.get('default', ''))
                    if any(kw in str(val).lower() for kw in ['not(', 'and(', 'or(', 'equals(', 'conditional']):
                        return 'Bool'
                    return 'String'
        return 'String'

    # ──────────────────────────────────────────────
    # Helpers
    # ──────────────────────────────────────────────

    @staticmethod
    def _get_decorator_value(decorators: List[Dict], deco_type: str, default: Any = None) -> Any:
        for d in decorators:
            if d.get('type') == deco_type:
                return d.get('argument', default)
        return default
