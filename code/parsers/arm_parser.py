import json
import os
import re
import uuid
from typing import Dict, Any, List, Optional, Tuple
from helper.save_file_loaded_result import save_file_loaded_result
from config.config import ARGUMENT_MAPPINGS, OUTPUT_PREFIX


class ARMParser:
    def __init__(self, template_path: str):
        self.template_path = template_path
        self.template_content = None
        self.para_name_to_id = {}   # Unified name to id for parameters (parameters, variables)
        self.param_name_to_id = {}   # parameter name to id
        self.var_name_to_id = {}   # variable name to id
        self.resource_name_to_id = {}   # resource name to id
        self.condition_name_to_id = {}   # condition name to id
        self.conditions = []
        self.parameters = []   # Store all parameters for later use
    

    def parse(self) -> Optional[Dict[str, Any]]:
        """
        Parse ARM template and return structured information.
        """
        try:
            # 1. Read the template file
            if not self.read_template():
                return None
        
        except Exception as e:
            # print(f"Error parsing template: {str(e)}")
            # NOTE: Only use below line of code during evaluation.
            raise Exception(f"There is an error when reading the TF template: {str(e)}")  
            # return None

        # 2. Parse the template file
        parsed_data = self.parse_template()
            
        # 3. Return the parsed template
        return parsed_data
    

    def read_template(self) -> bool:
        """Read the template file content."""
        try:
            with open(self.template_path, 'r', encoding='utf-8-sig') as file:
                self.template_content = file.read()
            return True
        except Exception as e:
            print(f"Error reading template file: {str(e)}")
            return False


    def parse_template(self) -> Dict[str, Any]:
        """Parse the JSON template content."""
        try:
            # Remove JSON comments (lines starting with //)
            # Note: JSON doesn't officially support comments, but ARM templates sometimes have them
            lines = self.template_content.split('\n')
            cleaned_lines = []
            for line in lines:
                # Remove single-line comments
                if '//' in line:
                    comment_pos = line.find('//')
                    # Check if // is inside a string by counting quotes
                    before_comment = line[:comment_pos]
                    # Count unescaped quotes
                    quote_count = 0
                    i = 0
                    while i < len(before_comment):
                        if before_comment[i] == '"' and (i == 0 or before_comment[i-1] != '\\'):
                            quote_count += 1
                        i += 1
                    # Even number of quotes means // is not in a string
                    if quote_count % 2 == 0:
                        line = before_comment.rstrip()
                cleaned_lines.append(line)
            cleaned_content = '\n'.join(cleaned_lines)
            
            # Parse JSON content
            template_data = json.loads(cleaned_content)

            # Case when the template is not a valid JSON object (i.e., a list)
            if not isinstance(template_data, dict):
                raise json.JSONDecodeError(f"There is an error when loading the ARM template: The template is not a valid JSON object", cleaned_content, 0)

            # Validate if the template is a valid ARM template (check the schema)
            schema = template_data.get('$schema', 'NA')
            if not (schema.endswith('deploymentTemplate.json#') or schema.endswith('subscriptionDeploymentTemplate.json#') or schema.endswith('managementGroupDeploymentTemplate.json#') or schema.endswith('tenantDeploymentTemplate.json#')):
                raise json.JSONDecodeError(f"There is an error when loading the ARM template: The template is invalid which schema is not valid: {schema}", cleaned_content, 0)
            
            # Save the loaded template data for debugging
            save_file_loaded_result(template_data)
            
            # Extract file information
            file_name = os.path.basename(self.template_path)
            
            # Register all element names and IDs first
            self._register_names_to_ids(template_data)
            
            # Process the template
            metadata = self.extract_metadata(template_data, file_name)
            parameters = self.extract_parameters(template_data)
            self.parameters = parameters  # Store for later use
            variables = self.extract_variables(template_data)
            parameters.extend(variables)  # Add variables to parameters list
            resources = self.extract_resources(template_data)
            outputs = self.extract_outputs(template_data)
            conditions = self.process_conditions()
        
            # Build the parsed structure according to IR format
            parsed_data = {
                'metadata': metadata,
                'parameters': parameters,
                'conditions': conditions,
                'resources': resources,
                'outputs': outputs,
            }

            return parsed_data
            
        except json.JSONDecodeError as e:
            # print(f"JSON parsing error: {str(e)}")
            # NOTE: Only use below line of code during evaluation.
            raise Exception(f"There is an error when loading the ARM template: {str(e)}")
            return {}
        except Exception as e:
            # print(f"Template parsing error: {str(e)}")
            # NOTE: Only use below line of code during evaluation.
            raise Exception(f"There is an error when parsing the ARM template: {str(e)}")
            return {}


    def _register_names_to_ids(self, template_data: Dict[str, Any]) -> None:
        """
        Register names and generate IDs for parameters, variables, and resources.
        """
        # Register parameters
        params = template_data.get('parameters', {})
        for param_name in params.keys():
            param_id = str(uuid.uuid4())
            self.param_name_to_id[param_name] = param_id
            self.para_name_to_id[f"parameters('{param_name}')"] = param_id
            self.para_name_to_id[f"parameters('{param_name}')"] = param_id
        
        # Register variables
        vars = template_data.get('variables', {})
        for var_name in vars.keys():
            var_id = str(uuid.uuid4())
            self.var_name_to_id[var_name] = var_id
            self.para_name_to_id[f"variables('{var_name}')"] = var_id
        
        # Register resources
        resources = template_data.get('resources', [])
        if isinstance(resources, list):
            for resource in resources:
                resource_name = self._extract_resource_name(resource)
                if resource_name:
                    resource_id = str(uuid.uuid4())
                    self.resource_name_to_id[resource_name] = resource_id
        elif isinstance(resources, dict):
            for resource_name in resources.keys():
                resource_id = str(uuid.uuid4())
                self.resource_name_to_id[resource_name] = resource_id
        else:
            raise Exception(f"Invalid ARM template: resources is not a list or dict.")


    def _extract_resource_name(self, resource: Dict[str, Any]) -> Optional[str]:
        """Extract resource name from ARM resource."""
        # ARM resources can have name as a string or expression
        name = resource.get('name')
        resource_type = resource.get('type', 'unknown')
        
        if isinstance(name, str):
            # If it's a simple string (not an expression), return it
            if not name.startswith('['):
                return name
            # If it's an expression, try to extract resource name from common patterns
            # Pattern: [format('{0}/{1}', param1, param2)] or [concat(...)]
            # Try to extract parameter/variable names from the expression
            param_pattern = r"parameters\s*\(\s*['\"]([^'\"]+)['\"]\s*\)"
            var_pattern = r"variables\s*\(\s*['\"]([^'\"]+)['\"]\s*\)"
            param_matches = re.findall(param_pattern, name, re.IGNORECASE)
            var_matches = re.findall(var_pattern, name, re.IGNORECASE)
            
            if param_matches:
                # Use first parameter name
                return f"{resource_type}_{param_matches[0]}"
            elif var_matches:
                # Use first variable name
                return f"{resource_type}_{var_matches[0]}"
            else:
                # Fallback to hash
                return f"{resource_type}_{abs(hash(name)) % 10000}"
        
        # If name is missing, use type with a unique identifier
        return f"{resource_type}_{str(uuid.uuid4())[:8]}"


    def extract_metadata(self, template_data: Dict[str, Any], file_name: str) -> Dict[str, Any]:
        """Extract metadata information."""
        metadata_section = template_data.get('metadata', {})
        description = metadata_section.get('description', 'NA') if isinstance(metadata_section, dict) else 'NA'
        
        additional_info = {}
        if isinstance(metadata_section, dict):
            # Extract generator info if present
            generator = metadata_section.get('_generator', {})
            if generator:
                additional_info['generator'] = generator
            # Extract other metadata fields
            for key, value in metadata_section.items():
                if key not in ['description', '_generator']:
                    additional_info[key] = value
        
        # Get schema and content version
        schema = template_data.get('$schema', 'NA')
        content_version = template_data.get('contentVersion', 'NA')
        api_version = template_data.get('apiVersion', 'NA')
        cloud_provider = 'Azure'
        if schema != 'NA':
            additional_info['schema'] = schema
        if content_version != 'NA':
            additional_info['contentVersion'] = content_version
            cloud_provider = f"Azure_{content_version}"
        if api_version != 'NA':
            additional_info['apiVersion'] = api_version
        
        return {
            'template_id': str(uuid.uuid4()),
            'template_type': 'ARM',
            'cloud_service_provider': cloud_provider,
            'file_name': file_name,
            'description': description,
            'additional_info': additional_info if additional_info else "NA"
        }

    
    def extract_parameters(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """
        Extract parameters section.
        """
        parameters = []
        params = template_data.get('parameters', {})
        
        for param_name, param_data in params.items():
            param_id = self.param_name_to_id.get(param_name, str(uuid.uuid4()))
            
            param_type = param_data.get('type', 'NA')
            default = param_data.get('defaultValue', 'NA')
            metadata = param_data.get('metadata', {})
            description = metadata.get('description', 'NA') if isinstance(metadata, dict) else 'NA'

            # Extract dependencies from defaultValue expressions such as:
            # [parameters('infrastructure').actionGroupName]
            references = self._extract_refs_helper(default)
            depend_params, depend_resources = self._extract_dependency_helper(references)
            depend_params = list(dict.fromkeys([dep for dep in depend_params if dep != param_id]))
            depend_resources = list(dict.fromkeys(depend_resources))
            
            # Extract constraints
            # NOTE: SMT Conversion at here
            try:
                constraints = self.extract_constraints_helper(param_data, param_type, param_name)
            except Exception as e:
                # print(f"Error extracting constraints: {e}")
                constraints = {}
            
            param_info = {
                'id': param_id,
                'name': param_name,
                'type': param_type,
                'param_type': 'parameter',
                'default': default,
                'constraints': constraints,
                'description': description,
                'depend_parameter': depend_params if depend_params else 'NA',
                'depend_resource': depend_resources if depend_resources else 'NA',
                'depend_condition': 'NA'
            }
            parameters.append(param_info)
        
        return parameters


    def extract_constraints_helper(self, param_data: Dict[str, Any], param_type: str, param_name: str) -> Dict[str, Any]:
        """Extract parameter constraints and convert to SMT-LIB2 format."""
        constraints = {}
        
        # Convert ARM types to SMT types
        smt_type = 'String'  # Default
        if param_type == 'int':
            smt_type = 'Int'
        elif param_type == 'bool':
            smt_type = 'Bool'
        elif param_type in ['string', 'secureString', 'secureObject']:
            smt_type = 'String'
        elif param_type in ['array', 'object']:
            smt_type = 'String'  # Complex types treated as String for now
        
        # Build SMT expressions
        expressions = [f"(declare-const {param_name} {smt_type})"]
        
        # Extract ARM-specific constraints and convert to SMT
        if 'minLength' in param_data:
            min_len = param_data['minLength']
            constraints['min_length'] = min_len
            if smt_type == 'String':
                # For strings, we can use length constraints (requires string length function)
                # For now, we'll note it but not add SMT constraint (SMT-LIB2 string theory is complex)
                pass
        
        if 'maxLength' in param_data:
            max_len = param_data['maxLength']
            constraints['max_length'] = max_len
        
        if 'minValue' in param_data:
            min_val = param_data['minValue']
            constraints['min_value'] = min_val
            if smt_type == 'Int':
                expressions.append(f'(assert (>= {param_name} {min_val}))')
        
        if 'maxValue' in param_data:
            max_val = param_data['maxValue']
            constraints['max_value'] = max_val
            if smt_type == 'Int':
                expressions.append(f'(assert (<= {param_name} {max_val}))')
        
        if 'allowedValues' in param_data:
            allowed_vals = param_data['allowedValues']
            if not allowed_vals:
                pass
                # raise Exception(f"Invalid ARM template: allowedValues is empty for parameter {param_name}.")
            else:
                constraints['allowed_values'] = allowed_vals
                
                # Convert allowed values to SMT format
                values = []
                for val in allowed_vals:
                    if isinstance(val, bool):
                        values.append(str(val).lower())
                    else:
                        values.append(val)
                
                if len(values) == 1:
                    if smt_type == 'Int':
                        expressions.append(f'(assert (= {param_name} {values[0]}))')
                    elif smt_type == 'Bool':
                        expressions.append(f'(assert (= {param_name} {values[0]}))')
                    else:
                        expressions.append(f'(assert (= {param_name} "{values[0]}"))')
                else:
                    if smt_type == 'Int':
                        or_conditions = " ".join([f'(= {param_name} {val})' for val in values])
                    elif smt_type == 'Bool':
                        or_conditions = " ".join([f'(= {param_name} {val})' for val in values])
                    else:
                        or_conditions = " ".join([f'(= {param_name} "{val}")' for val in values])
                    expressions.append(f'(assert (or {or_conditions}))')
        
        constraints['expressions'] = expressions
        return constraints if constraints else {}


    def extract_variables(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract variables section (similar to Terraform locals)."""
        variables = []
        vars = template_data.get('variables', {})
        
        for var_name, var_value in vars.items():
            var_id = self.var_name_to_id.get(var_name, str(uuid.uuid4()))
            
            # Extract dependencies
            references = self._extract_refs_helper(var_value)
            depend_params, depend_resources = self._extract_dependency_helper(references)
            
            # Handle conditional expressions (similar to Terraform)
            processed_value, depend_conditions = self._handle_condition_value(var_value, var_name, True)
            
            var_info = {
                'id': var_id,
                'name': var_name,
                'type': 'NA',
                'param_type': 'variables',
                'default': processed_value,
                'constraints': {},
                'description': 'NA',
                'depend_parameter': depend_params if depend_params else "NA",
                'depend_resource': depend_resources if depend_resources else "NA",
                'depend_condition': depend_conditions if depend_conditions else "NA",
            }
            variables.append(var_info)
        
        return variables


    def _handle_condition_value(self, attribute_value: Any, attribute_name: str, is_variable: bool = False) -> Tuple[Any, List[str]]:
        """
        Handle conditional expressions in variable values.
        ARM uses if(condition, trueValue, falseValue) function.
        """
        depend_conditions = []
        
        def process_conditional_recursive(obj):
            if isinstance(obj, str):
                # Check for ARM if() function: [if(condition, trueValue, falseValue)]
                # Need to handle nested parentheses properly
                if_pattern = r'\[if\s*\('
                match = re.search(if_pattern, obj, re.IGNORECASE)
                if match:
                    # Extract the full if() function call with proper parenthesis matching
                    start_pos = match.end() - 1  # Position of opening (
                    depth = 0
                    in_quotes = False
                    quote_char = None
                    i = start_pos
                    
                    while i < len(obj):
                        if not in_quotes and (obj[i] == '"' or obj[i] == "'"):
                            in_quotes = True
                            quote_char = obj[i]
                        elif in_quotes and obj[i] == quote_char:
                            in_quotes = False
                            quote_char = None
                        elif not in_quotes and obj[i] == '(':
                            depth += 1
                        elif not in_quotes and obj[i] == ')':
                            depth -= 1
                            if depth == 0:
                                # Found matching closing parenthesis
                                if_call = obj[match.start():i+1]  # Include closing ]
                                # Extract condition part (first argument of if)
                                # if(condition, trueValue, falseValue)
                                args_str = obj[match.end():i].strip()
                                args = self._parse_arm_function_arguments(args_str)
                                if len(args) >= 1:
                                    condition = args[0]
                                    # Extract condition references
                                    condition_id = self._extract_condition_refs_from_string(condition, [], attribute_name)
                                    depend_conditions.append(condition_id)
                                break
                        i += 1
                return obj
            elif isinstance(obj, dict):
                processed_dict = {}
                for key, value in obj.items():
                    processed_dict[key] = process_conditional_recursive(value)
                return processed_dict
            elif isinstance(obj, list):
                return [process_conditional_recursive(item) for item in obj]
            else:
                return obj
        
        processed_value = process_conditional_recursive(attribute_value)
        return processed_value, depend_conditions


    def _extract_condition_refs_from_string(self, condition_str: str, depend_conditions: List[str] = [], var_name: Optional[str] = None) -> str:
        """Convert the string condition into condition expression and create a condition element"""
        condition_str = condition_str.strip()
        depend_para = self._extract_refs_helper(condition_str)
        depend_para = [self.para_name_to_id[para] for para in depend_para if para in self.para_name_to_id] if depend_para else "NA"

        condition_element = {
            'id': str(uuid.uuid4()),
            'name': f"condition_{len(self.conditions)+1}",
            'condition': condition_str,
            'ruled_para': "NA",
            'constraint': "NA",
            'description': "NA",
            'depend_para': depend_para if depend_para else "NA",
            'depend_cond': depend_conditions if depend_conditions else "NA",
        }

        self.conditions.append(condition_element)
        self.condition_name_to_id[condition_str] = condition_element['id']
        
        return condition_element['id']


    def _extract_refs_helper(self, obj: Any) -> List[str]:
        """
        Helper function to extract parameter/variable/resource references.
        Handles ARM expressions like [parameters('name')], [variables('name')], [resourceId(...)]
        """
        refs = []
        
        def extract_dependencies_recursive(obj):
            if isinstance(obj, str):
                # Find ARM function calls: [functionName(...)] or nested inside other functions
                # Pattern for parameters: parameters('paramName') - can be inside other functions
                param_pattern = r"parameters\s*\(\s*['\"]([^'\"]+)['\"]\s*\)"
                param_matches = re.findall(param_pattern, obj, re.IGNORECASE)
                for match in param_matches:
                    refs.append(f"parameters('{match}')")
                
                # Pattern for variables: variables('varName') - can be inside other functions
                var_pattern = r"variables\s*\(\s*['\"]([^'\"]+)['\"]\s*\)"
                var_matches = re.findall(var_pattern, obj, re.IGNORECASE)
                for match in var_matches:
                    refs.append(f"variables('{match}')")
                
                # Pattern for resourceId: [resourceId('type', 'name')] or [resourceId('type', 'name', 'parent')]
                resource_id_pattern = r"\[resourceId\s*\([^)]+\)\]"
                resource_id_matches = re.findall(resource_id_pattern, obj, re.IGNORECASE)
                for match in resource_id_matches:
                    # Extract resource name from resourceId
                    name_pattern = r"['\"]([^'\"]+)['\"]"
                    names = re.findall(name_pattern, match)
                    if names:
                        # Use the last name as resource identifier (usually the resource name)
                        # Also try to match with registered resource names
                        for name in reversed(names):
                            if name in self.resource_name_to_id:
                                refs.append(name)
                                break
                        else:
                            # If no match found, add the last name anyway
                            refs.append(names[-1])
                
                # Pattern for reference: [reference('resourceName')] or [reference(resourceId(...))]
                reference_pattern = r"\[reference\s*\([^)]+\)\]"
                reference_matches = re.findall(reference_pattern, obj, re.IGNORECASE)
                for match in reference_matches:
                    # Try to extract resource name
                    name_pattern = r"['\"]([^'\"]+)['\"]"
                    names = re.findall(name_pattern, match)
                    if names:
                        refs.append(names[0])

            elif isinstance(obj, dict):
                for value in obj.values():
                    extract_dependencies_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    extract_dependencies_recursive(item)
        
        extract_dependencies_recursive(obj)
        return refs

    
    def _extract_dependency_helper(self, references: List[str]) -> Tuple[List[str], List[str]]:
        """Helper function to extract dependencies from references."""
        depend_params = []
        depend_resources = []
        if not references:
            return [], []
        
        for reference in references:
            if reference in self.para_name_to_id:
                depend_params.append(self.para_name_to_id[reference])
            elif reference in self.resource_name_to_id:
                depend_resources.append(self.resource_name_to_id[reference])
        
        return depend_params, depend_resources


    def extract_resources(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract resources section"""
        resources = []
        res = template_data.get('resources', [])
        
        if not res:
            return resources
            
        if isinstance(res, list):
            for resource in res:
                resource_name = self._extract_resource_name(resource)
                resources.append(self.handle_resource_construction(resource, resource_name))
        elif isinstance(res, dict):
            for resource_name, resource_data in res.items():
                resources.append(self.handle_resource_construction(resource_data, resource_name))
        else:
            raise Exception(f"Invalid ARM template: resources is not a list or dict: {type(res)}")
            
        return resources

        # for resource in res:
        #     resource_name = self._extract_resource_name(resource)
        #     resource_id = self.resource_name_to_id.get(resource_name, str(uuid.uuid4()))
            
        #     # Extract properties
        #     properties_data = resource.get('properties', {})
        #     property_units = self.extract_resource_properties(properties_data)
            
        #     # Extract arguments (dependsOn, condition, etc.)
        #     arguments = self.extract_resource_arguments(resource)
            
        #     resource_info = {
        #         'id': resource_id,
        #         'name': resource_name,
        #         'type': resource.get('type', 'NA'),
        #         'properties': property_units if property_units else "NA",
        #         'arguments': arguments if arguments else "NA",
        #     }
        #     resources.append(resource_info)
        
        # return resources

    
    def handle_resource_construction(self, resource: Dict[str, Any], resource_name: str) -> Dict[str, Any]:
        """Handle the resource construction"""
        resource_id = self.resource_name_to_id.get(resource_name, str(uuid.uuid4()))
            
        # Extract properties
        properties_data = resource.get('properties', {})
        if isinstance(properties_data, str):
            # Case the property is an object parameter
            refs = self._extract_refs_helper(properties_data)
            depend_params, depend_resources = self._extract_dependency_helper(refs)
            property_units = [{
                'name': 'property',
                'value': properties_data,
                'resource_refs': 'NA',
                'parameter_refs': depend_params if depend_params else 'NA',
                'depend_conditions': 'NA',
            }]
        else:
            property_units = self.extract_resource_properties(properties_data)
            
        # Extract arguments (dependsOn, condition, etc.)
        arguments = self.extract_resource_arguments(resource)
            
        resource_info = {
            'id': resource_id,
            'name': resource_name,
            'type': resource.get('type', 'NA'),
            'properties': property_units if property_units else "NA",
            'arguments': arguments if arguments else "NA",
        }
        return resource_info


    def extract_resource_arguments(self, resource_data: Dict[str, Any]) -> Dict[str, Any]:
        """Extract the resource attributes (arguments)"""
        if not resource_data:
            return "NA"
        
        arguments = {}
        
        # Iterate through all keys in resource_data
        for key, value in resource_data.items():
            # Skip properties - handled separately in extract_resource_properties
            if key == 'properties':
                continue
            
            # Handle dependsOn with special logic
            elif key == 'dependsOn':
                depends_on = value
                # Extract dependencies from the dependsOn value itself.
                # Important: keep only explicit references (e.g. variables('x')),
                # and do not infer synthetic resource names from variable names.
                references = self._extract_refs_helper(depends_on)
                depend_params, depend_resources = self._extract_dependency_helper(references)
                depend_params = list(dict.fromkeys(depend_params))
                depend_resources = list(dict.fromkeys(depend_resources))

                arguments['depends_on'] = {
                    'value': depends_on,
                    'resource_refs': depend_resources if depend_resources else "NA",
                    'parameter_refs': depend_params if depend_params else "NA"
                }
            
            # Handle condition with special logic
            elif key == 'condition':
                condition = value
                # Extract condition ID if it's a reference
                condition_id = None
                if isinstance(condition, str):
                    # Try to extract condition name from expression
                    cond_pattern = r"['\"]([^'\"]+)['\"]"
                    cond_names = re.findall(cond_pattern, condition)
                    if cond_names and cond_names[0] in self.condition_name_to_id:
                        condition_id = self.condition_name_to_id[cond_names[0]]
                    else:
                        # Create a new condition entry
                        condition_id = self._extract_condition_refs_from_string(condition, [], None)
                
                if condition_id:
                    arguments['condition'] = {
                        'condition_id': condition_id,
                        'true_value': "1",
                        'false_value': "0"
                    }
            
            # Handle all other keys generically
            else:
                # Extract parameter and resource dependencies from the value
                references = self._extract_refs_helper(value)
                depend_params, depend_resources = self._extract_dependency_helper(references)
                
                # For dependsOn-like fields, we want resource names, not IDs
                # For other fields, we can use IDs
                resource_refs = depend_resources if depend_resources else "NA"
                parameter_refs = depend_params if depend_params else "NA"
                
                arguments[key] = {
                    'value': value,
                    'resource_refs': resource_refs,
                    'parameter_refs': parameter_refs
                }
        
        return arguments if arguments else "NA"
    

    def extract_resource_properties(self, properties_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """
        Extract individual properties from resource properties data.
        Each property becomes a separate unit with its own dependencies.
        """
        property_units = []
        
        if not properties_data or not isinstance(properties_data, dict):
            return "NA"
        
        for prop_name, prop_value in properties_data.items():
            # Find references in this specific property
            references = self._extract_refs_helper(prop_value)
            depend_params, depend_resources = self._extract_dependency_helper(references)
            
            # Check for condition dependencies in this property
            depend_conditions = self._extract_condition_refs_from_property(prop_value)
            depend_conditions = [self.condition_name_to_id[cond] for cond in depend_conditions if cond in self.condition_name_to_id] if depend_conditions else "NA"

            property_unit = {
                'name': prop_name,
                'value': prop_value,
                'resource_refs': depend_resources if depend_resources else "NA",
                'parameter_refs': depend_params if depend_params else "NA",
                'depend_conditions': depend_conditions
            }
            property_units.append(property_unit)
        
        return property_units


    def _extract_condition_refs_from_property(self, prop_value: Any) -> List[str]:
        """
        Extract condition references from a property value.
        Looks for if() functions and condition references.
        """
        condition_refs = []
        
        def extract_conditions_recursive(obj):
            if isinstance(obj, str):
                # Look for if() function: [if(condition, trueValue, falseValue)]
                # Need to handle nested parentheses properly
                if_pattern = r'\[if\s*\('
                search_start = 0
                while True:
                    match = re.search(if_pattern, obj[search_start:], re.IGNORECASE)
                    if not match:
                        break
                    
                    # Adjust match position to account for search_start offset
                    match_start = search_start + match.start()
                    match_end = search_start + match.end()
                    
                    # Extract the full if() function call with proper parenthesis matching
                    start_pos = match_end - 1  # Position of opening (
                    depth = 0
                    in_quotes = False
                    quote_char = None
                    i = start_pos
                    found = False
                    
                    while i < len(obj):
                        if not in_quotes and (obj[i] == '"' or obj[i] == "'"):
                            in_quotes = True
                            quote_char = obj[i]
                        elif in_quotes and obj[i] == quote_char:
                            in_quotes = False
                            quote_char = None
                        elif not in_quotes and obj[i] == '(':
                            depth += 1
                        elif not in_quotes and obj[i] == ')':
                            depth -= 1
                            if depth == 0:
                                # Found matching closing parenthesis
                                # Extract condition part (first argument of if)
                                args_str = obj[match_end:i].strip()
                                args = self._parse_arm_function_arguments(args_str)
                                if len(args) >= 1:
                                    condition_str = args[0].strip()
                                    if condition_str and condition_str not in condition_refs:
                                        condition_refs.append(condition_str)
                                # Continue searching after this match
                                search_start = i + 1
                                found = True
                                break
                        i += 1
                    
                    if not found:
                        # No closing parenthesis found, stop searching
                        break
            elif isinstance(obj, dict):
                for value in obj.values():
                    extract_conditions_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    extract_conditions_recursive(item)
        
        extract_conditions_recursive(prop_value)
        return condition_refs


    def extract_outputs(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract outputs section"""
        outputs = []
        out = template_data.get('outputs', {})
        if not out:
            return outputs
        
        for output_name, output_data in out.items():
            if not isinstance(output_data, dict):
                # continue
                raise json.JSONDecodeError(f"There is an error when loading the ARM template: The output is not a valid JSON object", output_data, 0)
            # Extract references from output value
            output_value = output_data.get('value', 'NA')
            references = self._extract_refs_helper(output_value)
            depend_params, depend_resources = self._extract_dependency_helper(references)
            
            # Extract description
            metadata = output_data.get('metadata', {})
            description = metadata.get('description', 'NA') if isinstance(metadata, dict) else 'NA'
            
            # Extract condition dependencies
            depend_condition = []
            if_depend_conditions = self._extract_condition_refs_from_property(output_value)
            if if_depend_conditions:
                depend_condition = [self.condition_name_to_id[cond] for cond in if_depend_conditions if cond in self.condition_name_to_id]
            
            # Formulate the value
            value = {
                'value': output_value,
                'depend_conditions': depend_condition if depend_condition else "NA"
            }
            
            output_info = {
                'id': str(uuid.uuid4()),
                'name': f"{OUTPUT_PREFIX}{output_name}",
                'description': description,
                'value': value,
                'source_resource': depend_resources if depend_resources else "NA",
                'source_parameter': depend_params if depend_params else "NA",
                'export_name': {
                    'name': output_name,
                    'depend_parameter': "NA",
                    'depend_resource': "NA",
                    'depend_conditions': "NA"
                },
                'depend_conditions': "NA"
            }
            outputs.append(output_info)
        
        return outputs
    
    
    def process_conditions(self) -> List[Dict[str, Any]]:
        """
        Process conditions and convert them to SMT-LIB2 format.
        """
        processed_conditions = []
        
        for condition in self.conditions:
            condition_str = condition.get('condition', '')
            
            # Get condition dependencies
            depend_cond = condition.get('depend_cond', [])
            if depend_cond == "NA":
                depend_cond = []
            
            # Convert condition to SMT-LIB2 format
            # NOTE: SMT Conversion at here
            try:   # TODO: Handle the error in future updates
                smt_expressions = self.convert_arm_condition_to_smt(condition_str, self.parameters, depend_cond)
            except Exception as e:
                # print(f"Error converting condition to SMT-LIB2 format: {e}")
                smt_expressions = []
            
            # Update the condition field with the SMT-LIB2 format
            condition['condition'] = smt_expressions if smt_expressions else "NA"
            
            processed_conditions.append(condition)
        
        return processed_conditions


    def convert_arm_condition_to_smt(self, condition_str: str, parameters: List[Dict[str, Any]], depend_cond: List[str] = None) -> List[str]:
        """
        Convert ARM condition expression to SMT-LIB2 format.
        
        Handles ARM functions:
        - equals(a, b)
        - and(cond1, cond2, ...)
        - or(cond1, cond2, ...)
        - not(condition)
        - empty(value)
        - contains(array, item)
        - greaterOrEquals(a, b), lessOrEquals(a, b), etc.
        
        Args:
            condition_str: The condition expression string
            parameters: List of all parameters
            depend_cond: List of condition IDs that this condition depends on
        
        Returns:
            List of SMT-LIB2 expression strings
        """
        if not condition_str:
            return []
        
        condition_str = condition_str.strip()
        depend_params = set()
        synthetic_var_types: Dict[str, str] = {}
        condition_deps = depend_cond if depend_cond else []
        
        # Convert the condition to SMT format
        smt_condition = self._convert_arm_condition_expression_to_smt(
            condition_str, depend_params, parameters, condition_deps, synthetic_var_types
        )
        
        if not smt_condition:
            return []
        
        # Build SMT expressions list
        smt_expressions = []
        
        # Add parameter declarations
        for param_name in depend_params:
            param_info = self._find_parameter_info(param_name, parameters)
            if param_info:
                # Get SMT type
                smt_type = self._get_smt_type_for_parameter(param_name, param_info)
                
                # Special handling for variables whose type is not explicitly declared in ARM.
                if param_info.get('param_type') == 'variables':
                    smt_type = self._infer_variable_smt_type(param_info)
                
                smt_expressions.append(f"(declare-const {param_name} {smt_type})")
            elif param_name in synthetic_var_types:
                smt_expressions.append(f"(declare-const {param_name} {synthetic_var_types[param_name]})")
            else:
                # If not found, default to String
                smt_expressions.append(f"(declare-const {param_name} String)")
        
        # Add the condition assertion
        if smt_condition:
            smt_expressions.append(f"(assert {smt_condition})")
        
        return smt_expressions if smt_expressions else []


    def _convert_arm_condition_expression_to_smt(
        self,
        condition_str: str,
        depend_params: set,
        parameters: List[Dict[str, Any]],
        condition_deps: List[str] = None,
        synthetic_var_types: Dict[str, str] = None,
    ) -> str:
        """
        Convert an ARM condition expression string to SMT-LIB2 format.
        
        Handles ARM functions like equals(), and(), or(), not(), empty(), etc.
        """
        condition_str = condition_str.strip()
        if synthetic_var_types is None:
            synthetic_var_types = {}
        
        # Remove surrounding brackets if present: [condition] -> condition
        if condition_str.startswith('[') and condition_str.endswith(']'):
            condition_str = condition_str[1:-1].strip()
        
        # Handle parameter references FIRST (before function calls)
        # This is important because parameters('x') looks like a function call
        param_ref_match = re.match(r"parameters\s*\(\s*['\"]([^'\"]+)['\"]\s*\)", condition_str, re.IGNORECASE)
        if param_ref_match:
            param_name = param_ref_match.group(1)
            depend_params.add(param_name)
            return param_name
        
        # Handle variable references (before function calls)
        var_ref_match = re.match(r"variables\s*\(\s*['\"]([^'\"]+)['\"]\s*\)", condition_str, re.IGNORECASE)
        if var_ref_match:
            var_name = var_ref_match.group(1)
            depend_params.add(var_name)
            return var_name
        
        # Parse function calls: functionName(arg1, arg2, ...)
        # Only check for function calls after checking for parameter/variable references
        func_match = self._parse_arm_function_call(condition_str)
        if func_match:
            func_name, func_args = func_match
            # Skip if it's parameters() or variables() - already handled above
            if func_name not in ['parameters', 'variables']:
                return self._convert_arm_function_to_smt(
                    func_name, func_args, depend_params, parameters, condition_deps, synthetic_var_types
                )
        
        # Handle boolean literals
        if condition_str.lower() in ['true', 'false']:
            return condition_str.lower()
        
        # Handle string literals
        if (condition_str.startswith('"') and condition_str.endswith('"')) or \
           (condition_str.startswith("'") and condition_str.endswith("'")):
            value = condition_str[1:-1]
            return f'"{value}"'
        
        # Handle numeric literals
        try:
            num = int(condition_str)
            return str(num)
        except ValueError:
            try:
                num = float(condition_str)
                return str(num)
            except ValueError:
                pass
        
        # Default: treat as string literal
        return f'"{condition_str}"'


    def _parse_arm_function_call(self, expr: str) -> Optional[Tuple[str, List[str]]]:
        """
        Parse an ARM function call from an expression.
        Returns (function_name, list_of_arguments) or None if not a function call.
        
        Examples:
        - "equals(parameters('x'), 'value')" -> ("equals", ["parameters('x')", "'value'"])
        - "and(equals(a, b), not(empty(c)))" -> ("and", ["equals(a, b)", "not(empty(c))"])
        """
        expr = expr.strip()
        
        # Match function call pattern: functionName(arg1, arg2, ...)
        # Function names: equals, and, or, not, empty, contains, greaterOrEquals, etc.
        func_pattern = r'^([a-zA-Z_][a-zA-Z0-9_]*)\s*\('
        match = re.match(func_pattern, expr, re.IGNORECASE)
        
        if not match:
            return None
        
        func_name = match.group(1).lower()
        
        # Find the matching closing parenthesis
        start_pos = match.end() - 1  # Position of opening (
        depth = 0
        in_quotes = False
        quote_char = None
        i = start_pos
        
        while i < len(expr):
            if not in_quotes and (expr[i] == '"' or expr[i] == "'"):
                in_quotes = True
                quote_char = expr[i]
            elif in_quotes and expr[i] == quote_char:
                in_quotes = False
                quote_char = None
            elif not in_quotes and expr[i] == '(':
                depth += 1
            elif not in_quotes and expr[i] == ')':
                depth -= 1
                if depth == 0:
                    # Found matching closing parenthesis
                    args_str = expr[match.end():i].strip()
                    args = self._parse_arm_function_arguments(args_str)
                    return (func_name, args)
            i += 1
        
        return None


    def _parse_arm_function_arguments(self, args_str: str) -> List[str]:
        """
        Parse function arguments, handling nested parentheses and quotes.
        
        Example: "parameters('x'), 'value', equals(a, b)" -> ["parameters('x')", "'value'", "equals(a, b)"]
        """
        if not args_str.strip():
            return []
        
        args = []
        current_arg = ""
        depth = 0
        in_quotes = False
        quote_char = None
        i = 0
        
        while i < len(args_str):
            char = args_str[i]
            
            if not in_quotes and (char == '"' or char == "'"):
                in_quotes = True
                quote_char = char
                current_arg += char
            elif in_quotes and char == quote_char:
                in_quotes = False
                quote_char = None
                current_arg += char
            elif not in_quotes and char == '(':
                depth += 1
                current_arg += char
            elif not in_quotes and char == ')':
                depth -= 1
                current_arg += char
            elif not in_quotes and depth == 0 and char == ',':
                # Found argument separator
                if current_arg.strip():
                    args.append(current_arg.strip())
                current_arg = ""
            else:
                current_arg += char
            
            i += 1
        
        # Add last argument
        if current_arg.strip():
            args.append(current_arg.strip())
        
        return args


    def _convert_arm_function_to_smt(
        self,
        func_name: str,
        func_args: List[str],
        depend_params: set,
        parameters: List[Dict[str, Any]],
        condition_deps: List[str] = None,
        synthetic_var_types: Dict[str, str] = None,
    ) -> str:
        """
        Convert an ARM function call to SMT-LIB2 format.
        
        Supported functions:
        - equals(a, b): Equality comparison
        - and(cond1, cond2, ...): Logical AND
        - or(cond1, cond2, ...): Logical OR
        - not(condition): Logical NOT
        - empty(value): Check if value is empty
        - contains(array, item): Check if array contains item
        - greaterOrEquals(a, b), lessOrEquals(a, b), greater(a, b), less(a, b): Comparisons
        """
        if synthetic_var_types is None:
            synthetic_var_types = {}

        if func_name == 'equals':
            if len(func_args) != 2:
                return ""
            left = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            right = self._convert_arm_condition_expression_to_smt(
                func_args[1].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            return f"(= {left} {right})"
        
        elif func_name == 'and':
            if len(func_args) < 2:
                return ""
            smt_parts = []
            for arg in func_args:
                part_smt = self._convert_arm_condition_expression_to_smt(
                    arg.strip(), depend_params, parameters, condition_deps, synthetic_var_types
                )
                if part_smt:
                    smt_parts.append(part_smt)
            if smt_parts:
                return f"(and {' '.join(smt_parts)})"
            return ""
        
        elif func_name == 'or':
            if len(func_args) < 2:
                return ""
            smt_parts = []
            for arg in func_args:
                part_smt = self._convert_arm_condition_expression_to_smt(
                    arg.strip(), depend_params, parameters, condition_deps, synthetic_var_types
                )
                if part_smt:
                    smt_parts.append(part_smt)
            if smt_parts:
                return f"(or {' '.join(smt_parts)})"
            return ""
        
        elif func_name == 'not':
            if len(func_args) != 1:
                return ""
            inner = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            if inner:
                return f"(not {inner})"
            return ""
        
        elif func_name == 'empty':
            # empty(value) -> value == "" or value == null
            if len(func_args) != 1:
                return ""
            value_smt = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            # For SMT, we check if value equals empty string or null
            return f"(or (= {value_smt} \"\") (= {value_smt} \"null\"))"
        
        elif func_name in ['contains', 'contain']:
            # contains(collectionOrString, item)
            # 1) Handle createArray(...) precisely: contains(createArray(a,b), x) => (or (= x a) (= x b))
            raw_haystack = func_args[0].strip()
            parsed_haystack_call = self._parse_arm_function_call(raw_haystack)
            if parsed_haystack_call and parsed_haystack_call[0] == 'createarray':
                create_array_args = parsed_haystack_call[1]
                if not create_array_args:
                    return "false"
                item_smt = self._convert_arm_condition_expression_to_smt(
                    func_args[1].strip(), depend_params, parameters, condition_deps, synthetic_var_types
                )
                equality_terms = []
                for elem in create_array_args:
                    elem_smt = self._convert_arm_condition_expression_to_smt(
                        elem.strip(), depend_params, parameters, condition_deps, synthetic_var_types
                    )
                    if elem_smt:
                        equality_terms.append(f"(= {item_smt} {elem_smt})")
                if not equality_terms:
                    return "false"
                if len(equality_terms) == 1:
                    return equality_terms[0]
                return f"(or {' '.join(equality_terms)})"

            # 2) Handle string containment: contains("abc", "b") => (str.contains "abc" "b")
            if len(func_args) != 2:
                return ""
            haystack_smt = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            item_smt = self._convert_arm_condition_expression_to_smt(
                func_args[1].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            if haystack_smt and item_smt:
                return f"(str.contains {haystack_smt} {item_smt})"

            # 3) Fallback to symbolic Bool to avoid malformed/overconstrained formulas.
            return self._new_synthetic_symbol("contains", "Bool", depend_params, synthetic_var_types)

        elif func_name == 'length':
            # length(x) for strings and arrays.
            # For string-compatible terms, use str.len directly.
            # For unsupported complex terms, fall back to symbolic Int.
            if len(func_args) != 1:
                return self._new_synthetic_symbol("length", "Int", depend_params, synthetic_var_types)
            raw_arg = func_args[0].strip()
            parsed_arg_call = self._parse_arm_function_call(raw_arg)
            if parsed_arg_call and parsed_arg_call[0] == 'createarray':
                return str(len(parsed_arg_call[1]))

            arg_smt = self._convert_arm_condition_expression_to_smt(
                raw_arg, depend_params, parameters, condition_deps, synthetic_var_types
            )
            if self._is_boolean_smt_expr(arg_smt):
                return self._new_synthetic_symbol("length", "Int", depend_params, synthetic_var_types)
            return f"(str.len {arg_smt})"

        elif func_name == 'createarray':
            # Keep createArray representable for conditions where the exact list semantics
            # are not directly modeled (except in contains/length special handling).
            return self._new_synthetic_symbol("array", "String", depend_params, synthetic_var_types)
        
        elif func_name in ['greaterorequals', 'greaterorequal']:
            if len(func_args) != 2:
                return ""
            left = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            right = self._convert_arm_condition_expression_to_smt(
                func_args[1].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            left = self._to_numeric_smt_term(left, depend_params, parameters, synthetic_var_types, "num_ge_l")
            right = self._to_numeric_smt_term(right, depend_params, parameters, synthetic_var_types, "num_ge_r")
            return f"(>= {left} {right})"
        
        elif func_name in ['lessorequals', 'lessorequal']:
            if len(func_args) != 2:
                return ""
            left = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            right = self._convert_arm_condition_expression_to_smt(
                func_args[1].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            left = self._to_numeric_smt_term(left, depend_params, parameters, synthetic_var_types, "num_le_l")
            right = self._to_numeric_smt_term(right, depend_params, parameters, synthetic_var_types, "num_le_r")
            return f"(<= {left} {right})"
        
        elif func_name == 'greater':
            if len(func_args) != 2:
                return ""
            left = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            right = self._convert_arm_condition_expression_to_smt(
                func_args[1].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            left = self._to_numeric_smt_term(left, depend_params, parameters, synthetic_var_types, "num_gt_l")
            right = self._to_numeric_smt_term(right, depend_params, parameters, synthetic_var_types, "num_gt_r")
            return f"(> {left} {right})"
        
        elif func_name == 'less':
            if len(func_args) != 2:
                return ""
            left = self._convert_arm_condition_expression_to_smt(
                func_args[0].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            right = self._convert_arm_condition_expression_to_smt(
                func_args[1].strip(), depend_params, parameters, condition_deps, synthetic_var_types
            )
            left = self._to_numeric_smt_term(left, depend_params, parameters, synthetic_var_types, "num_lt_l")
            right = self._to_numeric_smt_term(right, depend_params, parameters, synthetic_var_types, "num_lt_r")
            return f"(< {left} {right})"
        
        return ""


    def _new_synthetic_symbol(
        self,
        prefix: str,
        smt_type: str,
        depend_params: set,
        synthetic_var_types: Dict[str, str],
    ) -> str:
        """Create a synthetic symbol with explicit SMT type."""
        symbol = f"__arm_{prefix}_{len(synthetic_var_types) + 1}"
        while symbol in synthetic_var_types:
            symbol = f"__arm_{prefix}_{len(synthetic_var_types) + 1}_{str(uuid.uuid4())[:4]}"
        synthetic_var_types[symbol] = smt_type
        depend_params.add(symbol)
        return symbol


    def _extract_top_level_arm_function_name(self, expr: Any) -> str:
        """Return top-level ARM function name from [func(...)] style expression."""
        if not isinstance(expr, str):
            return ""
        s = expr.strip()
        if s.startswith('[') and s.endswith(']'):
            s = s[1:-1].strip()
        parsed = self._parse_arm_function_call(s)
        if not parsed:
            return ""
        return parsed[0].lower()


    def _infer_variable_smt_type(self, param_info: Dict[str, Any]) -> str:
        """
        Infer SMT type for ARM variables (which usually have type NA in IR).
        Keeps inference conservative to avoid malformed SMT.
        """
        default_value = param_info.get("default", "NA")
        if isinstance(default_value, bool):
            return "Bool"
        if isinstance(default_value, int):
            return "Int"
        if isinstance(default_value, str):
            raw = default_value.strip()
            if re.fullmatch(r"-?\d+", raw):
                return "Int"
            top_func = self._extract_top_level_arm_function_name(raw)
            if top_func in {"equals", "and", "or", "not", "empty", "contains", "contain", "greater", "less", "greaterorequals", "lessorequals", "bool"}:
                return "Bool"
            if top_func in {"add", "sub", "mul", "div", "mod", "length", "int", "float", "copyindex"}:
                return "Int"
        return "String"


    def _is_boolean_smt_expr(self, term: str) -> bool:
        """Heuristic check for SMT boolean term."""
        if not isinstance(term, str):
            return False
        t = term.strip().lower()
        if t in ("true", "false"):
            return True
        return (
            t.startswith("(and ")
            or t.startswith("(or ")
            or t.startswith("(not ")
            or t.startswith("(= ")
            or t.startswith("(> ")
            or t.startswith("(< ")
            or t.startswith("(>= ")
            or t.startswith("(<= ")
            or t.startswith("(str.contains ")
        )


    def _to_numeric_smt_term(
        self,
        term: str,
        depend_params: set,
        parameters: List[Dict[str, Any]],
        synthetic_var_types: Dict[str, str],
        symbol_prefix: str,
    ) -> str:
        """Coerce term into a numeric SMT term (Int) when needed."""
        if not isinstance(term, str) or not term.strip():
            return self._new_synthetic_symbol(symbol_prefix, "Int", depend_params, synthetic_var_types)
        t = term.strip()

        # Numeric literal
        if re.fullmatch(r"-?\d+", t):
            return t
        if re.fullmatch(r"-?\d+\.\d+", t):
            # Condition analyzer primarily handles Int well; approximate floats by Int symbol.
            return self._new_synthetic_symbol(symbol_prefix, "Int", depend_params, synthetic_var_types)

        # Quoted numeric literal
        if (t.startswith('"') and t.endswith('"')) or (t.startswith("'") and t.endswith("'")):
            unquoted = t[1:-1].strip()
            if re.fullmatch(r"-?\d+", unquoted):
                return unquoted
            return self._new_synthetic_symbol(symbol_prefix, "Int", depend_params, synthetic_var_types)

        # Already numeric-like expression (e.g., (str.len ...))
        if t.startswith("(str.len "):
            return t

        # Identifier (parameter / variable)
        if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", t):
            param_info = self._find_parameter_info(t, parameters)
            if param_info:
                declared_type = str(param_info.get("type", "")).strip().lower()
                if declared_type == "int":
                    return t
                if param_info.get("param_type") == "variables" and self._infer_variable_smt_type(param_info) == "Int":
                    return t
            return self._new_synthetic_symbol(symbol_prefix, "Int", depend_params, synthetic_var_types)

        # Boolean formula or unsupported expression -> unconstrained Int symbol
        return self._new_synthetic_symbol(symbol_prefix, "Int", depend_params, synthetic_var_types)


    def _find_parameter_info(self, param_name: str, parameters: List[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
        """
        Find parameter information by name.
        """
        for param in parameters:
            if param.get('name') == param_name:
                return param
        return None


    def _get_smt_type_for_parameter(self, param_name: str, param_info: Dict[str, Any]) -> str:
        """
        Get SMT-LIB2 type for a parameter.
        Checks parameter type from param_info, or defaults to String.
        """
        if param_info:
            param_type = param_info.get('type', 'String')
            # Convert ARM types to SMT types
            if param_type == 'int':
                return 'Int'
            elif param_type == 'bool':
                return 'Bool'
            elif param_type in ['string', 'secureString', 'secureObject']:
                return 'String'
            else:
                return 'String'
        
        # Default to String
        return 'String'

