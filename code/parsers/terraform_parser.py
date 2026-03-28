import yaml
import json
import os
import re
import uuid
import hcl2
from typing import Dict, Any, List, Optional, Tuple
from helper.save_file_loaded_result import save_file_loaded_result
from config.config import TERRAFORM_PROVIDERS_RESOURCE_NAME, ARGUMENT_MAPPINGS, OUTPUT_PREFIX


class TerraformParser:
    def __init__(self, template_path: str):
        if '|' in template_path:   # Handle multiple file paths (pipe-separated)
            self.template_paths = [path.strip() for path in template_path.split('|')]
            self.template_path = self.template_paths[0]  # Use first path as primary
        else:
            self.template_paths = [template_path]
            self.template_path = template_path
        
        self.template_content = None
        self.provider = "aws"   # the cloud service provider
        self.para_name_to_id = {}   # Unified name to id for parameters (variables, locals, data)
        self.var_name_to_id = {}   # variable name to id
        self.local_name_to_id = {}   # local name to id for locals
        self.data_name_to_id = {}   # data name to id for data
        self.resource_name_to_id = {}   # resource name to id for resources
        self.module_name_to_id = {}   # module name to id for modules
        self.condition_name_to_id = {}   # condition name to id for conditions
        self.conditions = []
        self.local_name_to_condition_id = {}
        self.parameters = []   # Store all parameters for SMT conversion
        self.terraform_workspace_ref = "terraform.workspace"
        self.terraform_workspace_symbol = "terraform_workspace"
    

    def parse(self) -> Optional[Dict[str, Any]]:
        """
        Parse Terraform template and return structured information.
        """
        try:
            # 1. Read the template file(s)
            if not self.read_template():   # content will be stored in self.template_content
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
        """
        Read the template file content(s).
        If multiple files are provided, they are combined with newlines.
        """
        try:
            file_contents = []
            for file_path in self.template_paths:
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        content = file.read()
                        file_contents.append(content)
                except Exception as e:
                    print(f"Warning: Error reading file {file_path}: {str(e)}")
                    # Continue with other files even if one fails
            
            if not file_contents:
                print(f"Error: No files could be read from paths: {self.template_paths}")
                return False
            
            # Combine all file contents with double newlines for separation
            self.template_content = '\n\n'.join(file_contents)
            return True
        except Exception as e:
            print(f"Error reading template file(s): {str(e)}")
            return False


    # NOTE: Below function is abandoned because it cannot clean the template data as the key name can be the same in some cases..
    # def clean_template_data(self, template_data: Dict[str, Any]) -> Dict[str, Any]:
    #     """
    #     Clean the template data which the hcl2.loads() function tends to add an extra list wrapper.
    #     It will generate something like [{'key': 'value'}] with a length of 1.
    #     Recursively processes the data structure to remove unnecessary list wrappers.
    #     """
    #     def clean_recursive(obj):
    #         if isinstance(obj, dict):
    #             cleaned_dict = {}
    #             for key, value in obj.items():
    #                 cleaned_value = clean_recursive(value)
    #                 cleaned_dict[key] = cleaned_value
    #             return cleaned_dict
    #         elif isinstance(obj, list):
    #             # Check if this is a list of dictionaries that should be merged
    #             if len(obj) > 0 and all(isinstance(item, dict) for item in obj):
    #                 # Check if all dictionaries have different keys (no conflicts)
    #                 all_keys = set()
    #                 for item in obj:
    #                     all_keys.update(item.keys())
                    
    #                 # If total keys equals sum of individual keys, no conflicts
    #                 if len(all_keys) == sum(len(item.keys()) for item in obj):
    #                     # Merge all dictionaries into one
    #                     merged_dict = {}
    #                     for item in obj:
    #                         merged_dict.update(item)
    #                     return clean_recursive(merged_dict)
    #                 else:
    #                     # There are conflicting keys, keep as list but clean each item
    #                     return [clean_recursive(item) for item in obj]
    #             else:
    #                 # Not a list of dictionaries, clean each item
    #                 return obj
    #         else:
    #             # Primitive value, return as is
    #             return obj
        
    #     return clean_recursive(template_data)


    def parse_template(self) -> Dict[str, Any]:
        """Parse the HCL template content."""
        try:
            template_data = hcl2.loads(self.template_content)
        except Exception as e:
            # print(f"Error parsing template: {str(e)}")
            raise Exception(f"There is an error when loading the TF template: {str(e)}")
            return None

        try:
            # Parse HCL content using python-hcl2
            # template_data = hcl2.loads(self.template_content)
            # template_data = self.clean_template_data(template_data)

            # Save the loaded template data for debugging
            save_file_loaded_result(template_data)
            
            # Extract file information
            # For multiple files, use the first file's name or create a combined name
            if len(self.template_paths) > 1:
                file_names = []
                for file_path in self.template_paths:
                    file_names.append(os.path.basename(file_path))
                file_name = "-".join(file_names)
            else:
                file_name = os.path.basename(self.template_path)
            # Register all element names and IDs
            self._register_names_to_ids(template_data, 'variable', 'var.')
            self._register_names_to_ids(template_data, 'locals', 'local.')
            self._register_names_to_ids(template_data, 'data', 'data.')
            self._register_names_to_ids(template_data, 'resource')
            self._register_names_to_ids(template_data, 'module', 'module.')

            # Process the template (to extract conditions from all sections first)
            parameters = self.extract_parameters(template_data)
            self.parameters = parameters  # Store for SMT conversion
            metadata = self.extract_metadata(template_data, file_name)
            resources = self.extract_resources(template_data)
            outputs = self.extract_outputs(template_data)
            conditions = self.process_conditions()
        
            # Build the parsed structure according to IR format
            parsed_data = {
                'metadata': metadata,
                'parameters': parameters,
                # 'locals': self.extract_locals(template_data),
                # 'data_sources': self.extract_data_sources(template_data),
                'conditions': conditions,
                # 'conditions': self.extract_conditions(template_data),
                'resources': resources,
                'outputs': outputs,
            }

            return parsed_data
            
        except Exception as e:
            # print(f"Template parsing error: {str(e)}")
            # NOTE: Only use below line of code during evaluation.
            raise Exception(f"There is an error when parsing the TF template: {str(e)}")  
            return {}


    def _register_names_to_ids(self, template_data: Dict[str, Any], block_type: str, name_prefix: str = "") -> None:
        """
        Generic function to register names and generate IDs for various Terraform blocks.
        
        Args:
            blocks: List of blocks (e.g., locals_blocks, data_blocks, etc.)
            block_type: Type of block ('locals', 'data', 'resource', 'variable')
            name_mapping: Dictionary to store the name-to-ID mapping
            name_prefix: Optional prefix for the name (e.g., 'local.', 'data.', 'var.')
        """
        blocks = template_data.get(block_type)
        if not blocks:
            return

        for block in blocks:
            if block_type == 'locals':
                # For locals: block is a dict with local_name -> local_value
                for local_name in block.keys():
                    local_id = str(uuid.uuid4())
                    self.local_name_to_id[f"{name_prefix}{local_name}"] = local_id
                    self.para_name_to_id[f"{name_prefix}{local_name}"] = local_id
                    
            elif block_type == 'data':
                # For data: block is a dict with data_type -> data_instances
                for data_type, data_instances in block.items():
                    for data_name in data_instances.keys():
                        data_id = str(uuid.uuid4())
                        self.data_name_to_id[f"{name_prefix}{data_type}.{data_name}"] = data_id
                        self.para_name_to_id[f"{name_prefix}{data_type}.{data_name}"] = data_id
                        
            elif block_type == 'resource':
                # For resources: block is a dict with resource_type -> resource_instances
                for resource_type, resource_instances in block.items():
                    for resource_name in resource_instances.keys():
                        resource_id = str(uuid.uuid4())
                        self.resource_name_to_id[f"{resource_type}.{resource_name}"] = resource_id
                        
            elif block_type == 'module':
                for module_name in block.keys():
                    module_id = str(uuid.uuid4())
                    self.resource_name_to_id[f"{name_prefix}{module_name}"] = module_id
                    self.module_name_to_id[f"{name_prefix}{module_name}"] = module_id
                        
            elif block_type == 'variable':
                # For variables: block is a dict with var_name -> var_data
                for var_name, var_data in block.items():
                    var_id = str(uuid.uuid4())
                    self.var_name_to_id[f"{name_prefix}{var_name}"] = var_id
                    self.para_name_to_id[f"{name_prefix}{var_name}"] = var_id

    
    def extract_metadata(self, template_data: Dict[str, Any], file_name: str) -> Dict[str, Any]:
        """Extract metadata information."""
        additional_info = self._extract_metadata_helper(template_data)
        provider_info = self.extract_provider(template_data)
        if provider_info:
            additional_info['provider'] = provider_info
        
        return {
            'template_id': str(uuid.uuid4()),
            'template_type': 'Terraform',
            'cloud_service_provider': TERRAFORM_PROVIDERS_RESOURCE_NAME.get(self.provider, "No Cloud Service Provider"),
            'file_name': file_name,
            'description': "NA",
            'additional_info':  additional_info if additional_info else "NA"
        }

    
    def extract_provider(self, template_data: Dict[str, Any]) -> Dict[str, Any]:
        """Extract provider information."""
        provider = template_data.get('provider')   # A list of dictionaries
        if not provider:
            return {}
        provider_info = {}
        all_provider_depend_params = []  # Collect all parameter dependencies from all providers
        
        for provider_block in provider:   # For each provider block
            provider_name = "provider_default"
            provider_data_dict = {}
            provider_depend_params = []  # Parameter dependencies for this provider
            
            for provider_platform, provider_data in provider_block.items():   # Get the provider data
                for provider_data_name, provider_data_value in provider_data.items():   # Iterate through the provider data
                    if provider_data_name == 'version':
                        pass
                    elif provider_data_name == 'alias':
                        provider_name = f"provider_alias_{provider_data_value}"
                    else:
                        provider_data_dict[provider_data_name] = provider_data_value
                        # Extract parameter references from provider data values
                        references = self._extract_refs_helper(provider_data_value)
                        depend_params, depend_locals, depend_resources, depend_data = self._extract_dependency_helper(references)
                        # Collect parameter IDs (including locals and data as they're in parameters)
                        param_ids = []
                        param_ids.extend(depend_params)
                        param_ids.extend(depend_locals)
                        param_ids.extend(depend_data)
                        provider_depend_params.extend(param_ids)
            
            # Store provider data with dependencies
            provider_info[provider_name] = provider_data_dict
            all_provider_depend_params.extend(provider_depend_params)
        
        # Remove duplicates and store in provider_info
        if all_provider_depend_params:
            provider_info['depend_parameter'] = list(set(all_provider_depend_params))
        else:
            provider_info['depend_parameter'] = "NA"
        
        return provider_info

        
    def _extract_metadata_helper(self, template_data: Dict[str, Any]) -> Dict[str, Any]:
        """Help to extract metadata section information as mentioned in the documentation."""
        if not template_data.get('terraform'):
            return {}
        terraform_data = template_data.get('terraform')[0]

        additional_info = {}

        for key, value in terraform_data.items():
            if key == 'provider_meta':
                pass
            elif key == 'required_providers':
                if isinstance(value, dict):
                    provider_info = value
                else:
                    provider_info = value[0]
                temp_additional_info = {}
                for provider_name, provider_data in provider_info.items():
                    if provider_name in TERRAFORM_PROVIDERS_RESOURCE_NAME.keys():
                        self.provider = provider_name
                        self.handle_provider_data(provider_data, additional_info)
                    else:
                        temp_additional_info = {'provider_name': provider_name}
                        self.handle_provider_data(provider_data, temp_additional_info)
                additional_info['non_cloud_service_provider'] = temp_additional_info
            else:
                additional_info[key] = value

        return additional_info


    def handle_provider_data(self, provider_data: Any, additional_info: Dict[str, Any]):
        """Handle the provider data."""
        if isinstance(provider_data, str):
            # When the only provider data is a string, it is the version of the provider
            additional_info['required_version'] = provider_data
        elif isinstance(provider_data, dict):
            for k, v in provider_data.items():
                additional_info[k] = v
        else:
            raise ValueError(f"Unsupported provider data type: {type(provider_data)}")
        return additional_info


    def extract_parameters(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """
        Handle parameters section of the intermediate representation.
        In Terraform, there are many types of parameters, such as variables, locals, pseudo-parameters, and mapping parameters.
        """
        parameters = []
        
        # Extract Terraform variables
        parameters.extend(self.extract_variables(template_data))

        # Extract locals to parameters
        parameters.extend(self.extract_locals(template_data))
        
        # Extract data sources to parameters
        parameters.extend(self.extract_data_sources(template_data))

        # # Extract pseudo-parameters
        # parameters.extend(self.extract_pseudo_parameters(template_data))
        
        # # Extract mapping parameters
        # parameters.extend(self.extract_mapping_parameters(template_data))

        return parameters


    def extract_variables(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract variables section from Terraform template."""
        variables = []
        var_blocks = template_data.get('variable', [])
        
        # Handle each variable
        for var_block in var_blocks:
            for var_name, var_data in var_block.items():
                var_id = self.para_name_to_id[f"var.{var_name}"]

                # NOTE: SMT Conversion at here
                try:
                    type, default, constraints, description = self._extract_variable_data_helper(var_data, var_name)
                except Exception as e:
                    # print(f"Error extracting variable data: {e}")
                    type = 'NA'
                    default = 'NA'
                    constraints = {}
                    description = 'NA'
                
                # Extract variable information
                var_info = {
                    'id': var_id,
                    'name': var_name,
                    'type': type,
                    'param_type': 'variable',
                    'default': default,
                    'constraints': constraints,
                    'description': description,
                    'depend_parameter': 'NA',
                    'depend_resource': 'NA',
                    'depend_condition': 'NA'
                }
                variables.append(var_info)
        
        return variables


    def _extract_variable_data_helper(self, var_datas: Dict[str, Any], var_name: str):
        """Extract variable data from Terraform variable block."""
        type = 'NA'
        default = 'NA'
        constraints = {}
        description = 'NA'
        null_constraint = 'NA'
        
        for var_data_name, var_data_value in var_datas.items():
            if var_data_name == 'type':
               type = self.convert_variable_type(var_data_value)
            elif var_data_name == 'default':
                if type == 'NA':
                    type = self.define_variable_type(var_data_value)
                if var_data_value is None:
                    default = None  # Store as None, will be converted to SMT format later
                else:
                    default = var_data_value  # Store raw value, will be converted to SMT format later
            elif var_data_name == 'description':
                description = var_data_value
            elif var_data_name == 'validation':
                #TODO: Handle the validation if necessary in later version
                # self._handle_variable_validation(var_data_value)
                for validation_name, validation_value in var_data_value[0].items():
                        constraints[validation_name] = validation_value
            elif var_data_name == 'nullable':
                constraints[var_data_name] = var_data_value
                if not var_data_value:   # Must have a value
                    null_constraint = f"(assert (not (= {var_name} \"null\")))"
            else:
                constraints[var_data_name] = var_data_value
        
        # TODO: Handle tuple type in later version
        constraints['expressions'] = []
        if type != 'Tuple':
            constraints['expressions'] = [f"(declare-const {var_name} {type})"]
            if null_constraint != "NA":
                constraints['expressions'].append(null_constraint)

            # Do not add default value into constraints as it could be changed during user input
            # if default != 'NA':
            #     # Convert default value to SMT format (quote strings, handle null, etc.)
            #     default_smt = self._value_to_smt_format(default)
            #     constraints['expressions'].append(f"(assert (= {var_name} {default_smt}))")

        return type, default, constraints, description


    def convert_variable_type(self, var_type: str) -> str:
        """Convert Terraform type to SMT-LIB2 type."""
        var_type = self._clean_string_value(var_type)
        type_lower = var_type.lower()
        
        if type_lower == 'string':
            return 'String'
        elif type_lower == 'number':
            return 'Int'  # SMT-LIB2 uses Int, not Number
        elif type_lower == 'bool':
            return 'Bool'
        # TODO: Handle Map, List, Tuple, Set as str/int when use in condition expression.
        elif type_lower.startswith('list('):
            inner_type = var_type.split('(')[1].split(')')[0]
            inner_smt = self.convert_variable_type(inner_type)
            return f'(List {inner_smt})'
        elif type_lower.startswith('list'):   #TODO: Handle list when its inner type is undefined
            return '(List String)'
        elif type_lower.startswith('map'):
            return 'Map'   # Handle map like string/int in smt conversion when condition uses it
        elif type_lower.startswith('set('):   # Set is like list but with unique elements
            inner_type = var_type.split('(')[1].split(')')[0]
            inner_smt = self.convert_variable_type(inner_type)
            return f'(List {inner_smt})'  # SMT doesn't have Set, use List
        elif type_lower.startswith('set'):   #TODO: Handle set when its inner type is undefined
            return '(List String)'
        elif type_lower.startswith('tuple'):
            return 'Tuple'   # Handle tuple like string/int in smt conversion when condition uses it
        else:
            return 'NA'  # NoneType
            

    def define_variable_type(self, var_data_value: Any):
        """Define the variable type."""
        if isinstance(var_data_value, str):
            return 'String'
        elif isinstance(var_data_value, bool):   # NOTE: Bool type is a subclass of int in Python
            return 'Bool'
        elif isinstance(var_data_value, int) or isinstance(var_data_value, float):
            return 'Int'
        elif isinstance(var_data_value, list):
            item_type = "NA"
            for item in var_data_value:
                if item_type == "NA":
                    item_type = type(item)
                elif item_type != "NA" and type(item) != item_type:
                    return "Tuple"
            return f'(List {item_type})'
        elif isinstance(var_data_value, tuple):
            # In Terraform, tuple is a list of values but each element can have different types.
            raise ValueError(f"Tuple should be converted to list in Terraform")
        elif isinstance(var_data_value, dict):
            if not var_data_value:
                return 'Map'
            for key, value in var_data_value.items():
                key_type = self.define_variable_type(key)
                value_type = self.define_variable_type(value)
            return f'Map {key_type} {value_type}'
        elif isinstance(var_data_value, set):   # This will never be identified
            # In Terraform, set is a list with unique elements.
            raise ValueError("Set type should not be presented in Terraform template")
        elif var_data_value is None:   
            # In terraform condition, null is a placeholder for an empty value.
            # In condition expression, it will normally write as var.x = null which we can treat it as a string.
            return 'String'
        else:
            raise ValueError(f"Unsupported variable type with value: {var_data_value}")


    def extract_locals(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract locals section from Terraform template."""
        locals_list = []
        temp_locals_blocks = template_data.get('locals', [])
        locals_blocks = {}
        
        if not temp_locals_blocks:
            return locals_list

        # Save all locals into a single dictionary
        for local_block in temp_locals_blocks:
            for local_name, local_value in local_block.items():
                locals_blocks[local_name] = local_value

        # Process each local
        for local_name, local_value in locals_blocks.items():
            local_id = self.local_name_to_id[f"local.{local_name}"]
            
            # Handle conditional expressions
            processed_value, depend_conditions = self._handle_condition_value(local_value, local_name, True)
            
            # Extract dependencies
            references = self._extract_refs_helper(processed_value)
            # print(references)
            depend_params, depend_locals, depend_resources, depend_data = self._extract_dependency_helper(references)

            depend_parameter = []
            depend_parameter.extend(depend_params)
            depend_parameter.extend(depend_locals)   # Can be removed in later version
            depend_parameter.extend(depend_data)   # Can be removed in later version
            depend_parameter = list(set(depend_parameter))   # Remove duplicates

            # print(depend_params)
            # print(depend_locals)
            # print(depend_resources)
            # print(depend_data)
            # Determine value type
            
            # Create local element
            local_info = {
                'id': local_id,
                'name': local_name,
                'type': 'NA',    # Can be string, number, boolean, list, map, function call
                'param_type': 'locals',
                'default': processed_value,
                'constraints': {},
                'description': 'NA',
                'depend_parameter': depend_parameter if depend_parameter else "NA",
                'depend_resource': depend_resources if depend_resources else "NA",
                'depend_condition': depend_conditions if depend_conditions else "NA",
            }
            
            locals_list.append(local_info)
        
        return locals_list


    def _detect_and_extract_condition_value(self, local_value: Any, local_name: str) -> Any:
        """
        Detect if the local value is a condition value and extract the condition value.
        1. If the local value is a string
        2. If the local value contains the following operators:
            [&&, ||, !, ==, !=, <=, >=, <, >]
        3. Else, if the local value contains the following functions:
            [contains, alltrue, anytrue, can]
        4. Else, if the local value contains the following value:
            [true, false]
        For the 1~4 cases, return the condition value, otherwise, return the original local value
        """
        # TODO: Handle local.a = true and local.b = !local.a. Currently local.b is assumed to be present.
        if isinstance(local_value, str):
            # Clean the string value first
            cleaned_value = self._clean_string_value(local_value)
            
            # Check for logical operators (case 2)
            logical_operators = [r'&&', r'\|\|', r'!', r'==', r'!=', r'<=', r'>=', r'<', r'>']
            for operator in logical_operators:
                if re.search(operator, cleaned_value):
                    # Extract condition references and create condition element
                    condition_id = self._extract_condition_refs_from_string(cleaned_value, [], local_name)
                    if condition_id != "NA":
                        self.local_name_to_condition_id[f"local.{local_name}"] = condition_id
                    return cleaned_value
            
            # Check for Terraform condition functions (case 3)
            condition_functions = [r'\bcontains\s*\(', r'\balltrue\s*\(', r'\banytrue\s*\(', r'\bcan\s*\(']
            for func_pattern in condition_functions:
                if re.search(func_pattern, cleaned_value):
                    # Extract condition references and create condition element
                    condition_id = self._extract_condition_refs_from_string(cleaned_value, [], local_name)
                    if condition_id != "NA":
                        self.local_name_to_condition_id[f"local.{local_name}"] = condition_id
                    return cleaned_value
            
            # Check for boolean values (case 4)
            boolean_pattern = r'\b(true|false)\b'
            if re.search(boolean_pattern, cleaned_value):
                # Extract condition references and create condition element
                condition_id = self._extract_condition_refs_from_string(cleaned_value, [], local_name)
                if condition_id != "NA":
                    self.local_name_to_condition_id[f"local.{local_name}"] = condition_id
                return cleaned_value
            
            # If none of the above patterns match, return the original value
            return local_value
        else:
            return local_value


    def _handle_condition_value(self, attribute_value: Any, attribute_name: str, is_local: bool = False) -> Tuple[Any, List[str]]:
        """
        Handle conditional expressions in local values.
        Either the use of conditional expressions (_detect_and_extract_condition_value) or condition functions.

        Args:
            attribute_value: The value of the attribute, which can be a string, a boolean, a dictionary, or a list
            attribute_name: The name of the attribute
            How it presents in the template: (attribute_name: attribute_value)
        Returns:
            Tuple[Any, List[str]]: The processed value and the list of dependencies
        """
        depend_conditions = []
        
        def process_conditional_recursive(obj):
            if isinstance(obj, str):
                obj = self._clean_string_value(obj)
                # Check for Terraform conditional expressions
                # Pattern: condition ? true_value : false_value
                pattern = r'^(.+?)\s*\?\s*(.+?)\s*:\s*(.+)$'
                match = re.match(pattern, obj)
                if not match:
                    if not is_local:
                        return obj
                    else:
                        # TODO: Handle local SMT conversion in later version
                        pass
                        return obj
                        # return self._detect_and_extract_condition_value(obj, attribute_name)
                condition, true_value, false_value = match.groups()
                # TODO: Support nested conditional expressions extraction in later version
                used_conditions = []

                # TODO: Handle case when the condition of the condition function refer to another local that is not yet processed
                # TODO: Handle below logic in later version
                if condition in self.local_name_to_condition_id:   # When the condition is a local reference (i.e., local.a = true)
                    condition_id = self.local_name_to_condition_id[condition]
                    if condition_id != "NA":
                        depend_conditions.append(condition_id)
                else:
                    condition_id = self._extract_condition_refs_from_string(condition, used_conditions, attribute_name)
                    if condition_id != "NA":
                        depend_conditions.append(condition_id)
                
                # TODO: Handle the return value of conditional expressions in later version (such as replace the condition string with the condition name)
                # return true_value if true_value else false_value
                return obj
            elif isinstance(obj, bool) and is_local:
                # NOTE: Skip for now as resource properties can be true or false while local value is boolean does not mean it is a condition.
                # condition_id = self._extract_condition_refs_from_string(str(obj), [], f"local.{attribute_name}")
                # self.local_name_to_condition_id[f"local.{attribute_name}"] = condition_id
                return str(obj)
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

    
    def _clean_string_value(self, value: str) -> str:
        """Clean the string value."""
        # Handle when value is not a string
        if isinstance(value, list):
            return [self._clean_string_value(item) for item in value]
        elif isinstance(value, dict):
            return {key: self._clean_string_value(value[key]) for key in value}
        elif isinstance(value, bool):
            return str(value)
        elif isinstance(value, int):
            return str(value)
        elif value is None:
            return "Null"
        else:
            pass

        # Case 1: "${xxx}"
        if value.startswith('${') and value.endswith('}'):
            value = value[2:-1]
        # Case 2: "(xxx)"
        if value.startswith('(') and value.endswith(')'):
            value = value[1:-1]
        # Case 3: "xxx"
        if value.startswith('"') and value.endswith('"'):
            value = value[1:-1]
        # Case 4: 'xxx'
        if value.startswith("'") and value.endswith("'"):
            value = value[1:-1]
        return value


    def _extract_condition_refs_from_string(self, condition_str: str, depend_conditions: List[str] = [], local_name: Optional[str] = None) -> List[str]:
        """Convert the string condition into condition expression and create a condition element"""
        # TODO: Handle if the condition_str is just reference to a condition / parameter / local

        # TODO: Convert the condition string into condition expression
        condition_str = condition_str
        # Ignore item-scoped iterator conditions from for_each/dynamic contexts
        # for now. These are dynamic per-element predicates and should not create
        # global condition nodes in the current analyzer.
        # Examples:
        # - each.value.xxx
        # - each.key
        # - part.value.xxx            (dynamic "part" { ... })
        # - public_network_source.value.xxx
        # - count.index
        # - fileexists(...)
        if isinstance(condition_str, str) and (
            re.search(r'\beach\.(value|key)\b', condition_str)
            or re.search(r'\b(?!var\b|local\b|module\b|data\b|path\b|self\b|count\b)[a-zA-Z_][a-zA-Z0-9_]*\.(value|key)\b', condition_str)
            or re.search(r'\bcount\.index\b', condition_str)
            or re.search(r'\bfileexists\s*\(', condition_str, re.IGNORECASE)
        ):
            return "NA"

        # Register terraform.workspace as a synthetic parameter when used in condition.
        if isinstance(condition_str, str) and re.search(r'\bterraform\.workspace\b', condition_str):
            self._ensure_terraform_workspace_parameter()
        condition_key = self._normalize_condition_key(condition_str)

        # Reuse existing condition when the normalized expression is the same.
        if condition_key in self.condition_name_to_id:
            existing_id = self.condition_name_to_id[condition_key]
            # Merge dependencies if the existing condition is reused in a new context.
            if depend_conditions:
                for condition in self.conditions:
                    if condition.get('id') == existing_id:
                        existing_depend_cond = condition.get('depend_cond')
                        if existing_depend_cond == "NA" or not existing_depend_cond:
                            condition['depend_cond'] = list(set(depend_conditions))
                        else:
                            condition['depend_cond'] = list(set(existing_depend_cond + depend_conditions))
                        break
            return existing_id

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
            # 'source_local': local_name
        }

        self.conditions.append(condition_element)
        self.condition_name_to_id[condition_key] = condition_element['id']
        
        return condition_element['id']


    def _ensure_terraform_workspace_parameter(self) -> None:
        """
        Ensure terraform.workspace is tracked as a parameter dependency in conditions.
        """
        if self.terraform_workspace_ref in self.para_name_to_id:
            return

        workspace_id = str(uuid.uuid4())
        self.para_name_to_id[self.terraform_workspace_ref] = workspace_id
        self.var_name_to_id[self.terraform_workspace_ref] = workspace_id

        workspace_parameter = {
            'id': workspace_id,
            'name': self.terraform_workspace_symbol,
            'type': 'String',
            'param_type': 'variable',
            'default': 'NA',
            'constraints': {'expressions': [f"(declare-const {self.terraform_workspace_symbol} String)"]},
            'description': 'Terraform workspace pseudo variable',
            'depend_parameter': 'NA',
            'depend_resource': 'NA',
            'depend_condition': 'NA'
        }
        self.parameters.append(workspace_parameter)


    def _normalize_condition_key(self, condition_str: str) -> str:
        """Normalize condition text for stable de-duplication."""
        cleaned = self._clean_string_value(condition_str)
        if not isinstance(cleaned, str):
            cleaned = str(cleaned)
        # Normalize whitespace so semantically identical conditions map to one key.
        return re.sub(r'\s+', ' ', cleaned).strip()


    def _extract_refs_helper(self, obj: Dict[str, Any]) -> List[str]:
        """
        Helper function to extract variable/local/resource/data references.
        Args:
            obj: The object to extract references from, which can be a string, a dictionary, or a list
        Returns:
            List[str]: The list of potential references
        Note:
            The function may return elements that is not dependency such as "yourdomain.com" from "*.yourdomain.com"
        """
        refs = []
        # NOTE: This function may return elements that is not dependency such as "yourdomain.com" from "*.yourdomain.com"
        
        def extract_dependencies_recursive(obj):
            if isinstance(obj, str):
                matches = re.findall(r'\$\{[^}]*\}', obj)   # Find potential reference pairs in the string
                # Only unwrap interpolation when the entire string is exactly one "${...}".
                # If the string has additional content (e.g., function arguments around an inner
                # interpolation), keep it intact so references outside "${...}" are not lost.
                if len(matches) == 1 and re.fullmatch(r'\s*\$\{[^}]*\}\s*', obj):
                    obj = self._clean_string_value(matches[0])
                elif len(matches) > 1:
                    for match in matches:
                        extract_dependencies_recursive(match)

                # pattern = r'([a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*(?:\.[a-zA-Z_-][a-zA-Z0-9_-]*)*)'
                pattern = r'([a-zA-Z_][a-zA-Z0-9_-]*\.[a-zA-Z_][a-zA-Z0-9_-]*(?:\.[a-zA-Z_-][a-zA-Z0-9_-]*)*)'
                all_matches = re.findall(pattern, obj)   # Find references in the string
                # print(all_matches)
                for match in all_matches:
                    parts = match.split(".")
                    if len(parts) >= 3:
                        if parts[0] == "data":
                            # data.type.name -> data.type.name
                            match = ".".join(parts[:3])
                        elif parts[0] == "module":
                            # module.name.attribute -> module.name
                            match = ".".join(parts[:2])
                        else:
                            # resource.type.name.attribute -> resource.type.name
                            match = ".".join(parts[:2])
                        refs.append(match)
                    else:
                        refs.append(match)

            elif isinstance(obj, dict):
                for value in obj.values():
                    extract_dependencies_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    extract_dependencies_recursive(item)
        
        extract_dependencies_recursive(obj)
        return refs

    
    def _extract_dependency_helper(self, references: List[str]) -> Tuple[List[str], List[str], List[str], List[str]]:
        """Helper function to extract dependencies from references."""
        depend_params = []
        depend_locals = []
        depend_resources = []
        depend_data = []
        if not references:
            return [], [], [], []
        
        # TODO: Remove the local and data in later version as they are already included in the parameters
        for reference in references:
            if reference in self.para_name_to_id:
                depend_params.append(self.para_name_to_id[reference])
            elif reference in self.local_name_to_id:
                depend_locals.append(self.local_name_to_id[reference])
            elif reference in self.resource_name_to_id:
                depend_resources.append(self.resource_name_to_id[reference])
            elif reference in self.data_name_to_id:
                depend_data.append(self.data_name_to_id[reference])
        
        return depend_params, depend_locals, depend_resources, depend_data


    def _extract_condition_refs_from_property(self, prop_value: Any) -> List[str]:
        """Extract condition references from a property value."""
        condition_refs = []
        
        def extract_conditions_recursive(obj):
            if isinstance(obj, str):
                # Look for conditional expressions
                conditional_pattern = r'(\$\{[^}]*\})\s*\?\s*(\$\{[^}]*\})\s*:\s*(\$\{[^}]*\})'
                matches = re.findall(conditional_pattern, obj)
                
                for match in matches:
                    condition, true_val, false_val = match
                    cond_refs = self._extract_condition_refs_from_string(condition)
                    condition_refs.extend(cond_refs)
            
            elif isinstance(obj, dict):
                for value in obj.values():
                    extract_conditions_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    extract_conditions_recursive(item)
        
        extract_conditions_recursive(prop_value)
        return condition_refs


    def extract_data_sources(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:  
        """Extract data sources section"""
        data_sources = []
        data_sources_blocks = template_data.get('data', [])
        if not data_sources_blocks:
            return []
        
        for data_block in data_sources_blocks:
            for data_type, data_instance in data_block.items():
                for data_name, data_values in data_instance.items():
                    constraints = {}

                    references = self._extract_refs_helper(data_values)
                    depend_params, depend_locals, depend_resources, depend_data = self._extract_dependency_helper(references)
                    depend_parameters = []
                    depend_parameters.extend(depend_params)
                    depend_parameters.extend(depend_locals)
                    depend_parameters.extend(depend_data)

                    # The value specified in data source block, besides the arguments, are all constraints for the search query instead of the default value
                    # In Terraform, there is no default value for data source block.
                    custom_constraints = {}
                    for data_value_name, data_value_value in data_values.items():
                        if data_value_name == "count":
                            # processed_value, depend_conditions, true_value, false_value = self._handle_count_argument(data_value_value)   # TODO
                            constraints[data_value_name] = data_value_value
                        elif data_value_name == "for_each":
                            pass   # TODO
                            constraints[data_value_name] = data_value_value
                        elif data_value_name in ARGUMENT_MAPPINGS['terraform'].keys():   # Directly store the rest arguments in the constraints
                            constraints[data_value_name] = data_value_value
                        else:   # For the custom constraints
                            custom_constraints[data_value_name] = data_value_value
                    constraints['custom_constraints'] = custom_constraints if custom_constraints else "NA"

                    data_source_info = {
                        'id': self.data_name_to_id[f"data.{data_type}.{data_name}"],
                        'name': data_name,
                        'type': data_type,
                        'param_type': 'data',
                        'default': "NA",
                        'constraints': constraints if constraints else {},  
                        'description': "NA",
                        'depend_parameter': list(set(depend_parameters)) if depend_parameters else "NA",
                        'depend_resource': list(set(depend_resources)) if depend_resources else "NA",
                        'depend_condition': "NA",   # TODO: Handle
                    }
                    data_sources.append(data_source_info)
        return data_sources

    
    def handle_resource_properties(self, resource_attribute: str, resource_value: Any):
        """
        Handle the resource properties.
        Args:
            resource_attribute: The name of the resource attribute
            resource_value: The value of the resource attribute
            How it presents in the template: (resource_attribute: resource_value like "name: example")
        Returns:
            Dict[str, Any]: The property unit
        """
        if not resource_attribute:  
            return "NA"

        references = self._extract_refs_helper(resource_value)
        depend_params, depend_locals, depend_resources, depend_data = self._extract_dependency_helper(references)

        processed_value, depend_conditions = self._handle_condition_value(resource_value, resource_attribute)

        property_unit = {
            'name': resource_attribute,
            'value': processed_value,
            'resource_refs': depend_resources if depend_resources else "NA",
            'parameter_refs': depend_params if depend_params else "NA",
            'depend_conditions': depend_conditions if depend_conditions else "NA"
        }
        
        return property_unit
    

    def _handle_count_argument(self, attribute_value: Any) -> Tuple[Any, List[str]]:
        # depend_conditions = []
        condition_id, argument_name, argument_value = "NA", "NA", "NA"

        def process_conditional_recursive(value):
            # print(type(value), value)
            if isinstance(value, str):   
                # Check for Terraform conditional expressions
                value = self._clean_string_value(value)
                
                # Pattern: condition ? true_value : false_value
                pattern = r'^(.+?)\s*\?\s*(.+?)\s*:\s*(.+)$'
                match = re.match(pattern, value)
                if not match:   # Value is a function call
                    return "NA", "NA", "NA"   # TODO: Handle the function call in later version
                
                argument_name = "condition"
                condition, true_value, false_value = match.groups()
                # TODO: Support nested conditional expressions extraction in later version
                # TODO: Handle case when the condition of the condition function refer to another local that is not yet processed
                
                condition_id = self._extract_condition_refs_from_string(condition)
                argument_value = {"condition_id": condition_id, "true_value": true_value, "false_value": false_value}
                # depend_conditions.append(condition_id)

                return condition_id, argument_name, argument_value
            elif isinstance(value, int):
                return "NA", "NA", "NA"
            else:
                raise ValueError(f"Count value should be a number or a conditional expression, instead of {value}")
        
        condition_id, argument_name, argument_value = process_conditional_recursive(attribute_value)
        return condition_id, argument_name, argument_value


    def _handle_arguments(self, arguments):
        # print(arguments)
        arguments_info = {}
        for key, value in arguments.items():
            argument_element_to_value = {}
            references = self._extract_refs_helper(value)
            depend_params, depend_locals, depend_resources, depend_data = self._extract_dependency_helper(references)

            if key == "count":
                # print(arguments)
                depend_condition, argument_name, argument_value = self._handle_count_argument(value)
                if depend_condition != "NA" and argument_name == "condition":
                    arguments_info[argument_name] = argument_value
                    # continue   # Condition argument is already handled, skip the rest
            elif key == "for_each":
                # TODO: Handle the for_each argument in later version
                pass
            elif key == "depends_on":
                depend_resources = []
                for res in value:   # value is a list of strings
                    res = res[2:-1]   # remove the quotes which generated from the terraform loader
                    if res in self.resource_name_to_id:  
                        depend_resources.append(res)
                key = ARGUMENT_MAPPINGS['terraform'][key]
            elif key in ARGUMENT_MAPPINGS['terraform']:
                key = ARGUMENT_MAPPINGS['terraform'][key]
            
            # Save the argument value
            argument_element_to_value["value"] = value
            argument_element_to_value["resource_refs"] = depend_resources if depend_resources else "NA"
            argument_element_to_value["parameter_refs"] = depend_params if depend_params else "NA"
            arguments_info[key] = argument_element_to_value if argument_element_to_value else "NA"
        return arguments_info if arguments_info else "NA"

    
    def extract_resources(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract resources section"""
        resources = []
        resource_blocks = template_data.get('resource', []) 
        
        # Handle both list and dict formats
        if isinstance(resource_blocks, dict):
            resource_blocks = [resource_blocks]
        
        if resource_blocks:
            for resource_block in resource_blocks:
                for resource_type, resource_instance in resource_block.items():
                    for resource_name, resource_data in resource_instance.items():
                        resource_key = f"{resource_type}.{resource_name}"
                        arguments = {}
                        properties = []

                         # TODO: Handle the terraform native resources in later version
                        # if resource_type.startswith(self.provider):
                        if True:
                            for resource_attribute, resource_value in resource_data.items():
                                if resource_attribute in ARGUMENT_MAPPINGS['terraform'].keys():   # Collect all the arguments
                                    arguments[ARGUMENT_MAPPINGS['terraform'][resource_attribute]] = resource_value
                                else:
                                    properties.append(self.handle_resource_properties(resource_attribute, resource_value))
                            
                            # Process all arguments at once
                            arguments = self._handle_arguments(arguments)

                            resource_info = {
                                'id': self.resource_name_to_id[resource_key],
                                'name': f"{resource_type}.{resource_name}",
                                'type': resource_type,
                                'properties': properties if properties else "NA",
                                'arguments': arguments if arguments else "NA",
                            }
                            resources.append(resource_info)
                        else:
                            pass
                            # TODO: Handle the terraform native resources in later version
                            # This is a terraform native resource
                            # resource_info = {
                            #     'id': self.resource_name_to_id[resource_key],
                            #     'name': resource_name,
                            #     'type': f"tf_native.{resource_type}",
                            #     'properties': resource_data,
                            #     'arguments': "NA",
                            # }
                            # resources.append(resource_info)
        
        # Extract modules (always extract modules, even if no regular resources)
        modules = self.extract_modules(template_data)
        resources.extend(modules)
        return resources


    def extract_modules(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract modules section"""
        modules = []
        module_blocks = template_data.get('module', [])
        if not module_blocks:
            return modules
        
        # Handle both list and dict formats (hcl2 returns list of dicts)
        if isinstance(module_blocks, dict):
            module_blocks = [module_blocks]
        
        for module_block in module_blocks:
            for module_name, module_contents in module_block.items():
                module_key = f"module.{module_name}"
                
                # Ensure module is registered (in case registration failed)
                if module_key not in self.resource_name_to_id:
                    module_id = str(uuid.uuid4())
                    self.resource_name_to_id[module_key] = module_id
                    self.module_name_to_id[module_key] = module_id
                
                arguments = {}
                properties = []

                for module_argument, module_argument_value in module_contents.items():
                    if module_argument in ARGUMENT_MAPPINGS['terraform']:
                        arguments[ARGUMENT_MAPPINGS['terraform'][module_argument]] = module_argument_value
                    else:
                        properties.append(self.handle_resource_properties(module_argument, module_argument_value))

                arguments = self._handle_arguments(arguments)
                        
                module_info = {
                    'id': self.resource_name_to_id[module_key],
                    'name': module_name,
                    'type': "module",
                    'properties': properties if properties else "NA",
                    'arguments': arguments if arguments else "NA",
                }
                modules.append(module_info)

        return modules


    def extract_outputs(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract outputs section"""
        outputs = []
        output_blocks = template_data.get('output', {})
        if not output_blocks:
            return outputs
        
        for output_block in output_blocks:
            for output_name, output_data in output_block.items():
                references = self._extract_refs_helper(output_data)
                depend_params, depend_locals, depend_resources, depend_data = self._extract_dependency_helper(references)

                value = self._clean_string_value(output_data.get('value', 'NA'))

                output_info = {
                    'id': str(uuid.uuid4()),  
                    'name': f"{OUTPUT_PREFIX}{output_name}",
                    'description': output_data.get('description', 'NA'),
                    'value': {'value': value, 'depend_conditions': "NA"},
                    'source_resource': depend_resources if depend_resources else "NA",
                    'source_parameter': depend_params if depend_params else "NA",
                    'export_name': {'name': output_name, 'depend_parameter': "NA", 'depend_resource': "NA", 'depend_conditions': "NA"},
                    'depend_conditions': "NA"
                }
                outputs.append(output_info)
        
        return outputs

    
    # Below functions are used to handle conditions and convert them to SMT-LIB2 format.
    def process_conditions(self) -> List[Dict[str, Any]]:
        """
        Process conditions and convert them to SMT-LIB2 format.
        Similar to CloudFormation's extract_conditions_helper.
        """
        processed_conditions = []
        
        for condition in self.conditions:
            condition_str = condition.get('condition', '')   # The condition expression are temporarily stored in the 'condition' field
            
            # Get condition dependencies
            depend_cond = condition.get('depend_cond', [])
            if depend_cond == "NA":
                depend_cond = []
            
            # Convert condition to SMT-LIB2 format
            # NOTE: SMT Conversion at here
            try:
                smt_expressions = self.convert_terraform_condition_to_smt(condition_str, self.parameters, depend_cond)
            except Exception as e:
                # print(f"Error converting condition to SMT-LIB2 format: {e}")
                smt_expressions = None

            # Update the condition field with the SMT-LIB2 format
            condition['condition'] = smt_expressions if smt_expressions else "NA"
            
            processed_conditions.append(condition)
        
        return processed_conditions


    def convert_terraform_condition_to_smt(self, condition_str: str, parameters: List[Dict[str, Any]], depend_cond: List[str] = None) -> List[str]:
        """
        Convert Terraform condition expression to SMT-LIB2 format.
        
        Handles:
        - Comparison operators: ==, !=, <, >, <=, >=
        - Logical operators: &&, ||, !
        - Boolean variables: var.x, local.x
        - Null checks: var.x == null, var.x != null
        - Condition dependencies: references to other conditions
        
        Args:
            condition_str: The condition expression string
            parameters: List of all parameters (variables, locals, data)
            depend_cond: List of condition IDs that this condition depends on
        
        Returns:
            List of SMT-LIB2 expression strings
        """
        if not condition_str:
            return []
        
        condition_str = self._clean_string_value(condition_str)
        depend_params = set()
        condition_deps = depend_cond if depend_cond else []
        
        # Convert the condition to SMT format
        smt_condition = self._convert_condition_expression_to_smt(condition_str, depend_params, parameters, condition_deps)
        
        if not smt_condition:
            return []
        
        # Build SMT expressions list
        smt_expressions = []
        
        # Add parameter declarations
        for param_name in depend_params:
            # Clean the parameter name (remove prefix)
            clean_name = self._clean_parameter_name(param_name)
            param_info = self._find_parameter_info(clean_name, parameters)
            if param_info:
                # Get SMT type
                smt_type = self._get_smt_type_for_parameter(clean_name, param_info)
                smt_expressions.append(f"(declare-const {clean_name} {smt_type})")
            else:
                # If not found, default to String
                smt_expressions.append(f"(declare-const {clean_name} String)")
        
        # Add dependent condition declarations (if any)
        # TODO: Handle condition dependencies in SMT format
        
        # Add the condition assertion
        if smt_condition:
            smt_expressions.append(f"(assert {smt_condition})")
        
        return smt_expressions if smt_expressions else []


    def _convert_condition_expression_to_smt(self, condition_str: str, depend_params: set, parameters: List[Dict[str, Any]], condition_deps: List[str] = None) -> str:
        """
        Convert a Terraform condition expression string to SMT-LIB2 format.
        
        Handles:
        - var.x == "value"
        - var.x != null
        - var.x && var.y
        - var.x || var.y
        - !var.x
        - local.x (when used in conditions)
        """
        condition_str = condition_str.strip()
        
        # Handle boolean variable reference (e.g., var.x, local.x)
        if re.match(r'^(var\.|local\.)[a-zA-Z_][a-zA-Z0-9_]*$', condition_str):
            param_name = self._clean_parameter_name(condition_str)
            depend_params.add(param_name)
            return param_name
        
        # Handle negation: !condition
        if condition_str.startswith('!'):
            inner = condition_str[1:].strip()
            inner_smt = self._convert_condition_expression_to_smt(inner, depend_params, parameters, condition_deps)
            if inner_smt:
                return f"(not {inner_smt})"
        
        # Handle logical AND: condition1 && condition2
        if '&&' in condition_str:
            parts = self._split_logical_expression(condition_str, '&&')
            if len(parts) >= 2:
                smt_parts = []
                for part in parts:
                    part_smt = self._convert_condition_expression_to_smt(part.strip(), depend_params, parameters, condition_deps)
                    if part_smt:
                        smt_parts.append(part_smt)
                if smt_parts:
                    return f"(and {' '.join(smt_parts)})"
        
        # Handle logical OR: condition1 || condition2
        if '||' in condition_str:
            parts = self._split_logical_expression(condition_str, '||')
            if len(parts) >= 2:
                smt_parts = []
                for part in parts:
                    part_smt = self._convert_condition_expression_to_smt(part.strip(), depend_params, parameters, condition_deps)
                    if part_smt:
                        smt_parts.append(part_smt)
                if smt_parts:
                    return f"(or {' '.join(smt_parts)})"
        
        # Handle comparison operators first: ==, !=, <, >, <=, >=
        # Function calls in operands will be handled by _convert_operand_to_smt
        for op, smt_op in [('==', '='), ('!=', 'not'), ('<=', '<='), ('>=', '>='), ('<', '<'), ('>', '>')]:
            if op in condition_str:
                parts = self._split_comparison_expression(condition_str, op)
                if len(parts) == 2:
                    left = parts[0].strip()
                    right = parts[1].strip()
                    
                    left_smt = self._convert_operand_to_smt(left, depend_params, parameters)
                    right_smt = self._convert_operand_to_smt(right, depend_params, parameters)
                    
                    if op == '!=':
                        return f"(not (= {left_smt} {right_smt}))"
                    else:
                        return f"({smt_op} {left_smt} {right_smt})"
        
        # Handle function calls (only if no comparison operators found)
        # This handles cases where the entire condition is a function call (e.g., can(regex(...)))
        function_call_match = self._parse_function_call(condition_str)
        if function_call_match:
            func_name, func_args = function_call_match
            return self._convert_function_to_smt(func_name, func_args, depend_params, parameters, condition_deps)
        
        # If we can't parse the condition, return empty string
        # TODO: Add logging for unparseable conditions
        return ""


    def _clean_parameter_name(self, param_name: str) -> str:
        """
        Clean parameter name by removing prefixes (var., local., data.).
        
        Args:
            param_name: Parameter name with or without prefix
        
        Returns:
            Clean parameter name without prefix
        """
        if param_name == self.terraform_workspace_ref:
            return self.terraform_workspace_symbol
        return param_name.replace('var.', '').replace('local.', '').replace('data.', '')
    
    def _parse_function_call(self, expr: str) -> Optional[Tuple[str, List[str]]]:
        """
        Parse a function call from an expression.
        Returns (function_name, list_of_arguments) or None if not a function call.
        
        Examples:
        - "can(regex(\"pattern\", var.x))" -> ("can", ["regex(\"pattern\", var.x)"])
        - "length(var.list)" -> ("length", ["var.list"])
        - "substr(var.x, 0, 1)" -> ("substr", ["var.x", "0", "1"])
        """
        expr = expr.strip()
        
        # Match function call pattern: function_name(arg1, arg2, ...)
        # Function names: can, try, contains, substr, length, regex, alltrue, anytrue, lower, upper
        func_pattern = r'^(can|try|contains|substr|length|regex|alltrue|anytrue|lower|upper)\s*\('
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
                    args = self._parse_function_arguments(args_str)
                    return (func_name, args)
            i += 1
        
        return None


    def _parse_function_arguments(self, args_str: str) -> List[str]:
        """
        Parse function arguments, handling nested parentheses and quotes.
        
        Example: "var.x, \"value\", 123" -> ["var.x", "\"value\"", "123"]
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


    def _convert_function_to_smt(self, func_name: str, func_args: List[str], depend_params: set, 
                                  parameters: List[Dict[str, Any]], condition_deps: List[str] = None) -> str:
        """
        Convert a Terraform function call to SMT-LIB2 format.
        
        Supported functions:
        - can(expr): Returns true if expr can be evaluated
        - try(expr, fallback, ...): Returns first non-error expression
        - contains(list, value): Returns true if list contains value
        - substr(str, offset, length): Returns substring
        - length(value): Returns length
        - regex(pattern, str): Returns true if pattern matches
        - alltrue(list): Returns true if all values are true
        - anytrue(list): Returns true if any value is true
        """
        if func_name == 'can':
            # can(expr) - Returns true if expr can be evaluated
            # For SMT, we treat can() as evaluating the inner expression
            if len(func_args) == 1:
                inner_expr = func_args[0]
                # Recursively convert the inner expression
                return self._convert_condition_expression_to_smt(inner_expr, depend_params, parameters, condition_deps)
            return ""

        elif func_name == 'try':
            # try(expr, fallback, ...) - unwrap and evaluate the first expression.
            # This preserves referenced vars/locals for dependency extraction.
            if len(func_args) >= 1:
                primary_expr = func_args[0].strip()
                smt_expr = self._convert_condition_expression_to_smt(
                    primary_expr, depend_params, parameters, condition_deps
                )
                if smt_expr:
                    return smt_expr
                return self._convert_operand_to_smt(primary_expr, depend_params, parameters)
            return ""
        
        elif func_name == 'length':
            # length(value) - Returns length of string/list/map
            # For conditions, we typically compare: length(var.x) > 0
            # We create a variable for the length result
            if len(func_args) == 1:
                value_expr = func_args[0].strip()
                # Extract parameter name if it's a variable reference
                if value_expr.startswith('var.') or value_expr.startswith('local.'):
                    param_name = self._clean_parameter_name(value_expr)
                    depend_params.add(param_name)
                    # Create a length variable
                    length_var = f"{param_name}_length"
                    depend_params.add(length_var)
                    return length_var
                # For other expressions, create a generic length variable
                length_var = f"length_{hash(value_expr) % 10000}"
                depend_params.add(length_var)
                return length_var
            return ""
        
        elif func_name == 'substr':
            # substr(str, offset, length) - Returns substring
            # For conditions, we typically compare: substr(var.x, 0, 1) != "/"
            # We create a variable for the substring result
            if len(func_args) >= 2:
                str_expr = func_args[0].strip()
                offset = func_args[1].strip()
                length = func_args[2].strip() if len(func_args) > 2 else "1"
                
                # Extract parameter name if it's a variable reference
                if str_expr.startswith('var.') or str_expr.startswith('local.'):
                    param_name = self._clean_parameter_name(str_expr)
                    depend_params.add(param_name)
                    # Create a substring variable
                    substr_var = f"{param_name}_substr_{offset}_{length}"
                    depend_params.add(substr_var)
                    return substr_var
                # For other expressions, create a generic substring variable
                substr_var = f"substr_{hash(str_expr) % 10000}"
                depend_params.add(substr_var)
                return substr_var
            return ""
        
        elif func_name == 'contains':
            # contains(list, value) - Returns true if list contains value
            # For SMT, this is complex. We'll create a boolean variable.
            if len(func_args) == 2:
                list_expr = func_args[0].strip()
                value_expr = func_args[1].strip()
                
                # Extract parameter names
                if list_expr.startswith('var.') or list_expr.startswith('local.'):
                    list_param = self._clean_parameter_name(list_expr)
                    depend_params.add(list_param)
                
                # Create a contains variable
                contains_var = f"contains_{hash(f'{list_expr}_{value_expr}') % 10000}"
                depend_params.add(contains_var)
                return contains_var
            return ""
        
        elif func_name == 'regex':
            # regex(pattern, str) - Returns true if pattern matches
            # For SMT, we create a boolean variable
            if len(func_args) == 2:
                pattern = func_args[0].strip()
                str_expr = func_args[1].strip()
                
                # Extract parameter name if it's a variable reference
                if str_expr.startswith('var.') or str_expr.startswith('local.'):
                    param_name = self._clean_parameter_name(str_expr)
                    depend_params.add(param_name)
                
                # Create a regex match variable
                regex_var = f"regex_{hash(f'{pattern}_{str_expr}') % 10000}"
                depend_params.add(regex_var)
                return regex_var
            return ""
        
        elif func_name == 'alltrue':
            # alltrue(list) - Returns true if all values in list are true
            # For SMT, this is an AND operation
            if len(func_args) == 1:
                list_expr = func_args[0].strip()
                # Parse the list and convert each element
                # For now, create a variable (full list parsing is complex)
                alltrue_var = f"alltrue_{hash(list_expr) % 10000}"
                depend_params.add(alltrue_var)
                return alltrue_var
            return ""
        
        elif func_name == 'anytrue':
            # anytrue(list) - Returns true if any value in list is true
            # For SMT, this is an OR operation
            if len(func_args) == 1:
                list_expr = func_args[0].strip()
                # Parse the list and convert each element
                # For now, create a variable (full list parsing is complex)
                anytrue_var = f"anytrue_{hash(list_expr) % 10000}"
                depend_params.add(anytrue_var)
                return anytrue_var
            return ""

        elif func_name == 'lower':
            # lower(str) - Treat lower(var.x) in comparisons as var.x.
            # Example: lower(var.os_type) == "linux" -> os_type == "linux"
            if len(func_args) == 1:
                value_expr = func_args[0].strip()
                if value_expr.startswith('var.') or value_expr.startswith('local.'):
                    param_name = self._clean_parameter_name(value_expr)
                    depend_params.add(param_name)
                    return param_name
                if (value_expr.startswith('"') and value_expr.endswith('"')) or (value_expr.startswith("'") and value_expr.endswith("'")):
                    return f'"{value_expr[1:-1].lower()}"'
                return self._convert_operand_to_smt(value_expr, depend_params, parameters)
            return ""

        elif func_name == 'upper':
            # Keep symmetric behavior with lower() to avoid literal fallback.
            if len(func_args) == 1:
                value_expr = func_args[0].strip()
                if value_expr.startswith('var.') or value_expr.startswith('local.'):
                    param_name = self._clean_parameter_name(value_expr)
                    depend_params.add(param_name)
                    return param_name
                if (value_expr.startswith('"') and value_expr.endswith('"')) or (value_expr.startswith("'") and value_expr.endswith("'")):
                    return f'"{value_expr[1:-1].upper()}"'
                return self._convert_operand_to_smt(value_expr, depend_params, parameters)
            return ""

        return ""


    def _split_expression_by_operator(self, expr: str, operator: str, require_exact: bool = False) -> List[str]:
        """
        Split an expression by operator, handling parentheses and quotes.
        
        Args:
            expr: Expression string to split
            operator: Operator to split by (e.g., '&&', '==', '!=')
            require_exact: If True, require exactly 2 parts (for comparisons). 
                          If False, allow 2+ parts (for logical operators).
        
        Returns:
            List of expression parts, or empty list/fallback based on require_exact
        """
        parts = []
        depth = 0
        in_quotes = False
        quote_char = None
        current = ""
        
        i = 0
        while i < len(expr):
            if not in_quotes and (expr[i] == '"' or expr[i] == "'"):
                in_quotes = True
                quote_char = expr[i]
                current += expr[i]
            elif in_quotes and expr[i] == quote_char:
                in_quotes = False
                quote_char = None
                current += expr[i]
            elif not in_quotes and expr[i] == '(':
                depth += 1
                current += expr[i]
            elif not in_quotes and expr[i] == ')':
                depth -= 1
                current += expr[i]
            elif not in_quotes and depth == 0 and expr[i:i+len(operator)] == operator:
                if current.strip():
                    parts.append(current.strip())
                current = ""
                i += len(operator) - 1
            else:
                current += expr[i]
            i += 1
        
        if current.strip():
            parts.append(current.strip())
        
        # Return based on requirements
        if require_exact:
            return parts if len(parts) == 2 else []
        else:
            return parts if len(parts) >= 2 else [expr]
    
    def _split_logical_expression(self, expr: str, operator: str) -> List[str]:
        """Split a logical expression by operator, handling parentheses and quotes."""
        return self._split_expression_by_operator(expr, operator, require_exact=False)

    def _split_comparison_expression(self, expr: str, operator: str) -> List[str]:
        """Split a comparison expression by operator, handling quotes and parentheses."""
        return self._split_expression_by_operator(expr, operator, require_exact=True)


    def _convert_operand_to_smt(self, operand: str, depend_params: set, parameters: List[Dict[str, Any]]) -> str:
        """
        Convert an operand (left or right side of comparison) to SMT expression.
        Handles:
        - Parameter references: var.x, local.x
        - Literal strings: "value"
        - Literal numbers: 123
        - null
        - Boolean values: true, false
        - Function calls: length(var.x), substr(var.x, 0, 1), etc.
        """
        operand = operand.strip()
        
        # Handle null - keep as null in SMT format
        if operand == 'null':
            return '"null"'
        
        # Handle boolean literals
        if operand.lower() == 'true':
            return 'true'
        if operand.lower() == 'false':
            return 'false'
        
        # Handle function calls in operands (e.g., length(var.x), substr(var.x, 0, 1))
        function_call_match = self._parse_function_call(operand)
        if function_call_match:
            func_name, func_args = function_call_match
            return self._convert_function_to_smt(func_name, func_args, depend_params, parameters)

        # Handle terraform workspace pseudo variable.
        if operand == self.terraform_workspace_ref:
            self._ensure_terraform_workspace_parameter()
            depend_params.add(self.terraform_workspace_symbol)
            return self.terraform_workspace_symbol
        
        # Handle parameter references: var.x, local.x
        if operand.startswith('var.') or operand.startswith('local.'):
            param_name = self._clean_parameter_name(operand)
            depend_params.add(param_name)  # Store without prefix for lookup
            return param_name  # Return without prefix for SMT
        
        # Handle data references: data.type.name (extract only when used in conditions)
        if operand.startswith('data.'):
            # For data sources in conditions, we treat them as parameters
            # Extract the data name
            parts = operand.split('.')
            if len(parts) >= 3:
                data_name = parts[2]  # data.type.name -> name
                depend_params.add(data_name)
                return data_name
        
        # Handle map/list/tuple/set access in conditions
        # Pattern: var.map_name["key"] or var.list_name[0] or var.map_name[var.key]
        map_list_pattern = r'^(var\.|local\.)([a-zA-Z_][a-zA-Z0-9_]*)\[([^\]]+)\]$'
        match = re.match(map_list_pattern, operand)
        if match:
            prefix = match.group(1)
            param_name = match.group(2)
            key_or_index_str = match.group(3).strip('"\'')
            
            # Try to extract the actual value from the variable definition
            extracted_value = self._extract_value_from_map_list(param_name, key_or_index_str, prefix, parameters)
            
            if extracted_value is not None:
                # We found the value, convert it to SMT format
                return self._value_to_smt_format(extracted_value)
            else:
                # Value not found or key is dynamic, create a variable for the accessed value
                # This handles cases where the key is another variable (e.g., var.map[var.key])
                if key_or_index_str.startswith('var.') or key_or_index_str.startswith('local.'):
                    # Dynamic key - treat as a separate variable
                    key_var_name = self._clean_parameter_name(key_or_index_str)
                    depend_params.add(key_var_name)
                access_var_name = f"{param_name}_{key_or_index_str}"
                depend_params.add(access_var_name)
                return access_var_name
        
        # Handle quoted strings
        if (operand.startswith('"') and operand.endswith('"')) or (operand.startswith("'") and operand.endswith("'")):
            value = operand[1:-1]
            # If empty string, convert to null in SMT format
            if value == '':
                return '"null"'
            # SMT-LIB2 requires strings to be quoted
            return f'"{value}"'
        
        # Handle numbers
        try:
            num = int(operand)
            return str(num)
        except ValueError:
            try:
                num = float(operand)
                return str(num)
            except ValueError:
                pass
        
        # Default: treat as string literal (must be quoted for SMT-LIB2)
        return f'"{operand}"'


    def _find_parameter_info(self, param_name: str, parameters: List[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
        """
        Find parameter information by name.
        param_name can be just the name (e.g., 'x') or with prefix (e.g., 'var.x', 'local.x').
        """
        # Remove prefix if present
        clean_name = self._clean_parameter_name(param_name)
        
        for param in parameters:
            if param.get('name') == clean_name:
                return param
        
        return None


    def _get_smt_type_for_parameter(self, param_name: str, param_info: Dict[str, Any]) -> str:
        """
        Get SMT-LIB2 type for a parameter.
        Checks variable type from parameter info, or defaults to String.
        """
        if param_info:
            param_type = param_info.get('type', 'String')
            if param_type != 'NA':
                # Convert Terraform type to SMT type
                smt_type = self.convert_variable_type(param_type)
                return smt_type if smt_type != 'NA' else 'String'
        
        # If param_info not provided, try to find in parameters list
        if hasattr(self, 'parameters') and self.parameters:
            for param in self.parameters:
                if param.get('name') == param_name:
                    param_type = param.get('type', 'String')
                    param_type_ir = param.get('param_type', '')
                    
                    # Handle locals - default to Bool for conditions
                    if param_type_ir == 'locals':
                        return 'Bool'
                    
                    # Handle variables and data
                    if param_type != 'NA':
                        smt_type = self.convert_variable_type(param_type)
                        return smt_type if smt_type != 'NA' else 'String'
        
        # Default to String
        return 'String'


    def _extract_value_from_map_list(self, param_name: str, key_or_index: str, prefix: str, parameters: List[Dict[str, Any]]) -> Optional[Any]:
        """
        Extract a value from a map/list/tuple/set variable when used in a condition.
        Similar to CloudFormation's FindInMap value extraction.
        
        Args:
            param_name: Name of the parameter (without prefix)
            key_or_index: The key (for maps) or index (for lists) being accessed
            prefix: Either 'var.' or 'local.'
            parameters: List of all parameters
        
        Returns:
            The extracted value, or None if not found or if key is dynamic
        """
        # Find the parameter
        param_info = self._find_parameter_info(param_name, parameters)
        if not param_info:
            return None
        
        # Check if it's the right prefix
        if prefix == 'var.' and param_info.get('param_type') != 'variable':
            return None
        if prefix == 'local.' and param_info.get('param_type') != 'locals':
            return None
        
        # Get the default value
        default_value = param_info.get('default', 'NA')
        if default_value == 'NA' or not isinstance(default_value, (dict, list)):
            return None
        
        # Try to convert key_or_index to appropriate type
        try:
            # Try as integer index first (for lists)
            index = int(key_or_index)
            if isinstance(default_value, list) and 0 <= index < len(default_value):
                return default_value[index]
        except (ValueError, IndexError):
            pass
        
        # Try as string key (for maps)
        if isinstance(default_value, dict):
            # Try direct key lookup
            if key_or_index in default_value:
                return default_value[key_or_index]
            # Try with quotes stripped
            key_clean = key_or_index.strip('"\'')
            if key_clean in default_value:
                return default_value[key_clean]
        
        return None


    def _value_to_smt_format(self, value: Any) -> str:
        """Convert a Python value to SMT-LIB2 format."""
        if isinstance(value, str):
            # If empty string, convert to null in SMT format
            if value == '':
                return '"null"'
            # SMT-LIB2 requires strings to be quoted
            return f'"{value}"'
        elif isinstance(value, bool):
            return 'true' if value else 'false'
        elif isinstance(value, (int, float)):
            return str(value)
        elif value is None:
            return '"null"'  # Represent null as null in SMT format
        else:
            str_value = str(value)
            # If empty string representation, convert to null
            if str_value == '':
                return '"null"'
            # SMT-LIB2 requires strings to be quoted
            return f'"{str_value}"'

    # def _separate_properties_and_meta_arguments(self, resource_data: Dict[str, Any]) -> Tuple[Dict[str, Any], Dict[str, Any]]:
    #     """
    #     Separate Terraform resource data into properties and meta-arguments.
        
    #     Args:
    #         resource_data: The raw resource data from Terraform
            
    #     Returns:
    #         Tuple of (properties_dict, meta_arguments_dict)
    #     """
    #     properties = {}
    #     meta_arguments = {}
        
    #     # Get Terraform meta-argument keys from config
    #     terraform_meta_args = ARGUMENT_MAPPINGS['terraform'].keys()
        
    #     for name, value in resource_data.items():
    #         if name in terraform_meta_args:   # This is a meta-argument
    #             meta_arguments[name] = value
    #         else:   # This is a property
    #             properties[name] = value
        
    #     return properties, meta_arguments

        
    # def extract_resource_properties(self, properties_data: Dict[str, Any]) -> List[Dict[str, Any]]:
    #     """
    #     Extract individual properties from resource properties data.
    #     Each property becomes a separate unit with its own dependencies.
    #     """
    #     property_units = []
        
    #     for prop_name, prop_value in properties_data.items():
    #         # Find references in this specific property
    #         resource_refs, parameter_refs = self.find_references({prop_name: prop_value})
            
    #         # Check for condition dependencies in this property
    #         depend_conditions = self._extract_condition_refs_from_property(prop_value)
    #         depend_conditions = [self.condition_name_to_id[cond] for cond in depend_conditions if cond in self.condition_name_to_id] if depend_conditions else "NA"

    #         property_unit = {
    #             'name': prop_name,
    #             'value': prop_value,
    #             'resource_refs': resource_refs if resource_refs else "NA",
    #             'parameter_refs': parameter_refs if parameter_refs else "NA",
    #             'depend_conditions': depend_conditions
    #         }
    #         property_units.append(property_unit)
        
    #     return property_units


    # def find_references(self, data: Dict[str, Any]) -> Tuple[List[str], List[str]]:
    #     """
    #     Find resources that reference this resource with comprehensive reference detection.
    #     """
    #     resource_refs = []
    #     parameter_refs = []
        
    #     for prop_name, prop_value in data.items():
    #         references = self._extract_refs_from_value(prop_value)

    #         # Get the resource / parameter ids
    #         for reference in references:
    #             if self.resource_name_to_id.get(reference):
    #                 resource_refs.append(self.resource_name_to_id[reference])
    #             elif self.para_name_to_id.get(reference):
    #                 parameter_refs.append(self.para_name_to_id[reference])
        
    #     return resource_refs, parameter_refs

    
    # def _extract_refs_from_value(self, prop_value: Dict[str, Any]) -> List[str]:
    #     """
    #     Helper function to extract parameter/resource references from normal or nested dictionaries (dictionary is like {'Ref': 'name'}).
    #     The choice of recursive is because the parameter can be nested in a dictionary which loaded from intrinsic functions.
    #     """
    #     resource_refs = []
    #     parameter_refs = []
        
    #     def extract_references_recursive(obj):
    #         if isinstance(obj, str):
    #             # Look for Terraform interpolation syntax
    #             # var.variable_name, local.local_name, resource_type.resource_name.attribute
    #             var_matches = re.findall(r'\$\{var\.([^}]+)\}|var\.([a-zA-Z_][a-zA-Z0-9_]*)', obj)
    #             local_matches = re.findall(r'\$\{local\.([^}]+)\}|local\.([a-zA-Z_][a-zA-Z0-9_]*)', obj)
    #             resource_matches = re.findall(r'\$\{([a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*)', obj)
    #             data_matches = re.findall(r'\$\{data\.([^}]+)\}|data\.([a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*)', obj)
                
    #             # Add variable references
    #             for match in var_matches:
    #                 var_name = match[0] or match[1]
    #                 var_ref = f"var.{var_name}"
    #                 if var_ref in self.para_name_to_id:
    #                     parameter_refs.append(self.para_name_to_id[var_ref])
                
    #             # Add local references
    #             for match in local_matches:
    #                 local_name = match[0] or match[1]
    #                 local_ref = f"local.{local_name}"
    #                 if local_ref in self.para_name_to_id:
    #                     parameter_refs.append(self.para_name_to_id[local_ref])
                
    #             # Add resource references
    #             for match in resource_matches:
    #                 resource_name = match
    #                 if resource_name in self.resource_name_to_id:
    #                     resource_refs.append(self.resource_name_to_id[resource_name])
                
    #             # Add data source references
    #             for match in data_matches:
    #                 data_name = match[0] or match[1]
    #                 data_ref = f"data.{data_name}"
    #                 if data_ref in self.resource_name_to_id:
    #                     resource_refs.append(self.resource_name_to_id[data_ref])
                        
    #         elif isinstance(obj, dict):
    #             for value in obj.values():
    #                 extract_references_recursive(value)
    #         elif isinstance(obj, list):
    #             for item in obj:
    #                 extract_references_recursive(item)
        
    #     extract_references_recursive(prop_value)
    #     return list(set(resource_refs)), list(set(parameter_refs))
        

    # def extract_resource_arguments(self, meta_arguments: Dict[str, Any]) -> Dict[str, Any]:
    #     """Extract the resource meta-arguments (arguments)"""
    #     arguments = {}
    #     for key, value in meta_arguments.items():
    #         if key in ARGUMENT_MAPPINGS['terraform']:
    #             arguments[key] = value
    #     return arguments if arguments else "NA"



    # def extract_locals(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
    #     """Extract locals section from Terraform template."""
    #     locals_params = []
    #     locals_blocks = template_data.get('locals', [])
        
    #     # Register all local names and IDs first
    #     for locals_block in locals_blocks:
    #         for local_name, local_data in locals_block.items():
    #             local_id = str(uuid.uuid4())
    #             self.para_name_to_id[f"local.{local_name}"] = local_id
        
    #     # Handle each local
    #     for locals_block in locals_blocks:
    #         for local_name, local_data in locals_block.items():
    #             local_id = self.para_name_to_id[f"local.{local_name}"]
                
    #             # Find references in local values
    #             resource_refs, parameter_refs = self.find_references({local_name: local_data})
                
    #             local_info = {
    #                 'id': local_id,
    #                 'name': f"local.{local_name}",
    #                 'type': 'local',
    #                 'default': local_data,
    #                 'constraints': 'NA',
    #                 'description': 'NA'
    #             }
    #             locals_params.append(local_info)
        
    #     return locals_params


    # def extract_pseudo_parameters(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
    #     """Extract pseudo-parameters from Terraform template."""
    #     # This method can be implemented to extract Terraform-specific pseudo-parameters
    #     # For now, returning empty list as Terraform doesn't have AWS-style pseudo-parameters
    #     return []


    # def extract_mapping_parameters(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
    #     """Extract mapping parameters from Terraform template."""
    #     # Terraform doesn't have CloudFormation-style mappings, but could have data sources
    #     # This method can be implemented if needed
    #     return []