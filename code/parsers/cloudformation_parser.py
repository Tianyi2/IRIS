import yaml
import json
import os
import re
import subprocess
import uuid
from typing import Dict, Any, List, Optional, Tuple
from yaml.resolver import BaseResolver
from helper.save_file_loaded_result import save_file_loaded_result
from helper.safe_loading import load_json_content_safely

# Top-level section keys that must not be duplicated in a CFN template
CFN_TOP_LEVEL_SECTIONS = ('Parameters', 'Conditions', 'Resources', 'Outputs')
from config.config import CFN_TAGS, AWS_PSEUDO_PARAMETERS, SUBSTITUTION_PATTERN, AWS_PSEUDO_PARAMETERS_PATTERN, ARGUMENT_MAPPINGS, CFN_CONDITION_PREFIX, OUTPUT_PREFIX


class CloudFormationParser:
    def __init__(self, template_path: str, use_aws_cli_validation: bool = True):
        self.template_path = template_path
        self.template_content = None
        self.para_name_to_id = {}
        self.condition_name_to_id = {}
        self.resource_name_to_id = {}
        self.use_aws_cli_validation = use_aws_cli_validation

    def parse(self) -> Optional[Dict[str, Any]]:
        """
        Parse CloudFormation template and return structured information.
        """
        # 1. Read the template file
        try:
            if not self.read_template():   # content will be stored in self.template_content
                return None
            
        except Exception as e:
            # print(f"Error parsing template: {str(e)}")
            return None

        # 2. Optionally validate template with AWS CLI validate-template before parsing
        # if self.use_aws_cli_validation:
        #     self._validate_template_with_aws_cli()

        # 3. Parse the template file
        parsed_data = self.parse_template()
            
        # 4. Return the parsed template
        return parsed_data

    def _validate_template_with_aws_cli(self) -> None:
        """
        Validate the template using AWS CLI: aws cloudformation validate-template.
        Raises yaml.YAMLError if validation fails (e.g. invalid template, CLI error).
        Uses file:// URL so the CLI reads the template from disk; requires template to be read first.
        """
        abs_path = os.path.abspath(self.template_path)
        path_fwd = abs_path.replace("\\", "/")
        template_uri = "file://" + path_fwd
        try:
            # Use region; if env has an AZ (e.g. us-east-1a), use only the region part (us-east-1)
            region = os.environ.get("AWS_DEFAULT_REGION", "us-east-1")
            if len(region) > 1 and region[-1].isalpha() and region[-2].isdigit():
                region = region[:-1]
            result = subprocess.run(
                [
                    "aws", "cloudformation", "validate-template",
                    "--template-body", template_uri,
                    "--region", region,
                ],
                capture_output=True,
                text=True,
                timeout=30,
            )
        except FileNotFoundError:
            raise yaml.YAMLError(
                "There is an error when loading the CFN template: AWS CLI (aws) not found. "
                "Install AWS CLI or disable use_aws_cli_validation."
            )
        except subprocess.TimeoutExpired:
            raise yaml.YAMLError(
                "There is an error when loading the CFN template: AWS CLI validate-template timed out."
            )
        if result.returncode != 0:
            err = (result.stderr or result.stdout or "Unknown error").strip()
            if "Could not connect to the endpoint URL" in err and ".amazonaws.com/" in err:
                hint = " (Use a region name, e.g. us-east-1, not an availability zone, e.g. us-east-1a. Set AWS_DEFAULT_REGION or pass --region us-east-1.)"
                err = err + hint
            raise yaml.YAMLError(
                f"There is an error when loading the CFN template: AWS CLI validate-template failed: {err}"
            )

    def read_template(self) -> bool:
        """Read the template file content."""
        try:
            with open(self.template_path, 'r', encoding='utf-8-sig') as file:
                self.template_content = file.read().replace('\t', '  ')
            return True
        except Exception as e:
            print(f"Error reading template file: {str(e)}")
            return False

    def _load_cfn_template(self, content: str) -> dict:
        """
        Load a CloudFormation template from string content.
        Uses the same strategy as the CloudFormation parser:
        - JSON loader if the content starts with '{'.
        - Custom YAML loader with CFN intrinsic-function tag constructors otherwise.
        """
        import yaml

        if content.lstrip().startswith('{'):
            return json.loads(content)

        class _CfnLoader(yaml.SafeLoader):
            pass

        def _construct_cfn_tag(loader, node):
            tag_name = node.tag[1:]
            if isinstance(node, yaml.ScalarNode):
                return {tag_name: node.value}
            elif isinstance(node, yaml.SequenceNode):
                return {tag_name: loader.construct_sequence(node)}
            elif isinstance(node, yaml.MappingNode):
                return {tag_name: loader.construct_mapping(node)}

        for tag in CFN_TAGS:
            _CfnLoader.add_constructor(tag, _construct_cfn_tag)

        return yaml.load(content, Loader=_CfnLoader)

    def parse_template(self) -> Dict[str, Any]:
        """Parse the YAML/JSON template content."""
        try:
            if self.template_content.startswith('{'):
                template_data = load_json_content_safely(self.template_content, "CFN")
            else:
                # Parse YAML content using custom loader
                template_data = self._load_cfn_template(self.template_content)

            # Print the loaded template data
            # print(template_data)
            save_file_loaded_result(template_data)  # Save the loaded template data

            # Check if the template is invalid.
            if isinstance(template_data.get('Resources', {}), list):
                raise yaml.YAMLError(f"There is an error when loading the CFN template: The template is invalid. The Resources section is a list instead of a dictionary.")   
       
            # Extract file information
            file_name = os.path.basename(self.template_path)

            self.parameters = self.extract_parameters(template_data)
            
            # Build the parsed structure according to IR format
            parsed_data = {
                'metadata': self.extract_metadata(template_data, file_name),
                'parameters': self.parameters,
                'conditions': self.extract_conditions(template_data),
                'resources': self.extract_resources(template_data),
                'outputs': self.extract_outputs(template_data),
                # 'dependency_graph': self.build_dependency_graph(template_data)
            }
            
            return parsed_data
            
        except yaml.YAMLError as e:
            # print(f"YAML parsing error: {str(e)}")
            # NOTE: Only use below line of code during evaluation.
            raise yaml.YAMLError(f"There is an error when loading the CFN template: {str(e)}")   
            return {}
        except Exception as e:  
            # print(f"Template parsing error: {str(e)}")
            # NOTE: Only use below line of code during evaluation.
            raise Exception(f"There is an error when parsing the CFN template: {str(e)}")   
            return {}
        

    def extract_metadata(self, template_data: Dict[str, Any], file_name: str) -> Dict[str, Any]:
        """Extract metadata information."""
        aws_version = template_data.get('AWSTemplateFormatVersion')
        # if aws_version is None:
        #     return {}
        cloud_provider = f"AWS_{aws_version}" if aws_version else "AWS"
        additional_info = self._extract_metadata_helper(template_data)
        
        return {
            'template_id': str(uuid.uuid4()),
            'template_type': 'CloudFormation',
            'cloud_service_provider': cloud_provider,
            'file_name': file_name,
            'description': template_data.get('Description', 'NA'),
            'additional_info':  additional_info if additional_info else "NA"
        }
        

    def _extract_metadata_helper(self, template_data: Dict[str, Any]) -> Dict[str, Any]:
        """Help to extract metadata section information as mentioned in the documentation."""
        metadata = template_data.get('Metadata', {})
        additional_info = {}

        for key, value in metadata.items():
            if key == 'AWS::CloudFormation::Interface':
                pass
            elif key == 'AWS::CloudFormation::Designer':
                pass
            else:
                additional_info[key] = value

        return additional_info


    def extract_parameters(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract parameters section."""
        parameters = []
        params = template_data.get('Parameters', {})
        if params is None:
            return parameters
        
        for param_name, param_data in params.items():
            # Handle default value for CommaDelimitedList to be a list
            type = param_data.get('Type', 'NA')
            if type == 'NA':   # NOTE: Type information is compulsory to be present in CloudFormation template.
                raise Exception("Invalid CloudFormation template: Type information is compulsory to be present in CloudFormation template.")

            if type == 'CommaDelimitedList':
                default = param_data.get('Default', 'NA').split(',')
            else:
                default = param_data.get('Default', 'NA')
                
            try:
                constraints = self.extract_constraints_helper(param_data, type, param_name)
            except Exception as e:
                # print(f"Error extracting constraints: {e}")
                constraints = {}

            param_info = {
                'id': str(uuid.uuid4()),
                'name': param_name,
                'type': type,
                'default': default,
                'constraints': constraints,
                'description': param_data.get('Description', 'NA')
            }
            self.para_name_to_id[param_name] = param_info['id']   # Store the name to id mapping for later referencing
            parameters.append(param_info)

        # Extract pseudo-parameters
        parameters.extend(self.extract_pseudo_parameters(template_data))
        
        # Extract mapping parameters
        parameters.extend(self.extract_mapping_parameters(template_data))

        return parameters


    def get_pseudo_parameters_search_scope(self, template_data: Dict[str, Any]) -> str:
        """Get the search scope for pseudo-parameters."""\
        # Extract pseudo parameters only from specific sections
        sections_to_search = []
        
        # 1. Parameters section (for default values, constraints, etc.)
        if 'Parameters' in template_data:
            sections_to_search.append(str(template_data['Parameters']))
        
        # 2. Conditions section
        if 'Conditions' in template_data:
            sections_to_search.append(str(template_data['Conditions']))
        
        # 3. Resources Properties sections only
        if 'Resources' in template_data:
            for resource_name, resource_data in template_data['Resources'].items():
                if isinstance(resource_data, dict) and 'Properties' in resource_data:
                    sections_to_search.append(str(resource_data['Properties']))
        
        # 4. Outputs section
        if 'Outputs' in template_data:
            sections_to_search.append(str(template_data['Outputs']))

        if 'Rules' in template_data:
            sections_to_search.append(str(template_data['Rules']))
        
        return sections_to_search

    
    def extract_pseudo_parameters(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """
        Extract pseudo-parameters (${AWS::XXX} format) from the entire template.
        These are CloudFormation built-in parameters that don't need to be defined in Parameters section.
        """
        pseudo_params = []
        pseudo_param_names = set()
        
        # Convert template to string to search for ${xxx} patterns
        template_str = self.get_pseudo_parameters_search_scope(template_data)
        
        # Find all ${xxx} patterns
        # matches = re.findall(SUBSTITUTION_PATTERN, template_str)
        matches = re.findall(AWS_PSEUDO_PARAMETERS_PATTERN, "\n".join(template_str))
        # matches.extend(ref_matches)
        
        for match in matches:
            if match in AWS_PSEUDO_PARAMETERS and match not in pseudo_param_names:
                pseudo_param_names.add(match)
                
                param_info = {
                    'id': str(uuid.uuid4()),
                    'name': match,
                    'type': 'pseudo-parameter',
                    'default': 'NA',
                    'constraints': {'expressions': [f'(declare-const {match.replace("::", "_")} String)']},
                    'description': "NA"
                }
                self.para_name_to_id[match] = param_info['id']
                pseudo_params.append(param_info)
        
        return pseudo_params
    

    def extract_mapping_parameters(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract mapping parameters."""
        mappings = template_data.get('Mappings', {})
        mapping_parameters = []

        for mapping_name, mapping_data in mappings.items():
            default = {mapping_name: mapping_data} if mapping_data else "NA"
                      
            param_info = {
                'id': str(uuid.uuid4()),
                'name': mapping_name,
                'type': 'mapping',
                'default': default,
                'constraints': "NA",
                'description': "NA"
            }
            self.para_name_to_id[mapping_name] = param_info['id'] 
            mapping_parameters.append(param_info)

        return mapping_parameters


    def extract_constraints_helper(self, param_data: Dict[str, Any], type: str, param_name: str) -> Dict[str, Any]:
        """Extract parameter constraints."""
        # NOTE: SMT Conversion at here
        constraints = {}
        # Modify type to String in case they are AWS-specific parameter types or Systems Manager parameter types or CommaDelimitedList type
        if type != "String" and type != "Number" and type != "List<Number>":
            type = "String"
        if type == "List<Number>":
            type = "(List Int)"
        if type == "Number":
            type = "Int"

        expressions = [f"(declare-const {param_name} {type})"]

        if 'AllowedValues' in param_data:
            temp_values = param_data['AllowedValues']
            if not temp_values:
                raise Exception(f"Invalid CloudFormation template: AllowedValues is empty for parameter {param_name}.")
            
            values = []
            for value in temp_values:   # Convert boolean values to string
                if (isinstance(value, bool) or isinstance(value, str)) and (value == True or value == "True"):
                    value = "true"
                elif (isinstance(value, bool) or isinstance(value, str)) and (value == False or value == "False"):
                    value = "false"
                values.append(value)

            if type != "Int":
                values.append("")   # Add empty string to the allowed values
            if len(values) == 1:
                if type == "Int":
                    expressions.append(f'(assert (= {param_name} {values[0]}))')
                else:
                    expressions.append(f'(assert (= {param_name} "{values[0]}"))')
            else:
                if type == "Int":
                    or_conditions = " ".join([f'(= {param_name} {val})' for val in values])
                else:
                    or_conditions = " ".join([f'(= {param_name} "{val}")' for val in values])
                expressions.append(f'(assert (or {or_conditions}))')
            constraints['allowed_values'] = values
        
        if 'MinValue' in param_data:
            if type != 'Int':
                raise Exception(f"Invalid CloudFormation template: MinValue is only supported for Number type parameters.")
            min_val = param_data['MinValue']
            expressions.append(f'(assert (>= {param_name} {min_val}))')
            constraints['min_value'] = param_data['MinValue']

        if 'MaxValue' in param_data:
            if type != 'Int':
                raise Exception(f"Invalid CloudFormation template: MaxValue is only supported for Number type parameters.")
            max_val = param_data['MaxValue']
            expressions.append(f'(assert (<= {param_name} {max_val}))')
            constraints['max_value'] = param_data['MaxValue']
        
        if 'AllowedPattern' in param_data:
            constraints['allowed_pattern'] = param_data['AllowedPattern']

        if 'MinLength' in param_data:
            constraints['min_length'] = param_data['MinLength']
        
        if 'MaxLength' in param_data:
            constraints['max_length'] = param_data['MaxLength']
        
        if 'NoEcho' in param_data:
            constraints['no_echo'] = param_data['NoEcho']
        
        constraints['expressions'] = expressions
        return "NA" if not constraints else constraints
    

    def extract_conditions(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract conditions section."""
        output = []
        rules = template_data.get('Rules', {})
        conditions = template_data.get('Conditions', {})
        output = self.extract_rules_helper(output, rules)
        output = self.extract_conditions_helper(output, conditions)
        return output


    def extract_rules_helper(self, outputs: List, rules: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract the Rules section in the CloudFormation template into the conditions section in the IR."""
        if rules is None:
            return rules
        for rule_name, rule_data in rules.items():
            rule_name = f"{CFN_CONDITION_PREFIX}{rule_name}"
            # TODO: Handle the intrinsic function in the rule condition
            rule_condition = rule_data.get('RuleCondition', True)
            
            assertions = rule_data.get('Assertions', [])
            
            # Handle multiple assertions - constraint becomes an array
            constraints = []
            descriptions = []
            ruled_para = []
            depend_para = []
            
            for assertion in assertions:
                # Extract Assert and AssertDescription from each assertion
                assert_value = assertion.get('Assert', "NA")
                assert_desc = assertion.get('AssertDescription', "NA")
                
                constraints.append(assert_value)
                descriptions.append(assert_desc)
                
                # Extract parameters from constraint if it is a dictionary (Intrinsic Function)
                if isinstance(assert_value, dict):
                    ruled_para.extend(self._extract_refs_from_dict(assert_value))
            
            # Extract parameters from RuleCondition
            if isinstance(rule_condition, dict):
                depend_para.extend(self._extract_refs_from_dict(rule_condition))
            
            ruled_para = [self.para_name_to_id[para] for para in set(ruled_para)] if ruled_para else "NA"
            depend_para = [self.para_name_to_id[para] for para in set(depend_para)] if depend_para else "NA"

            rule_info = {
                'id': str(uuid.uuid4()),
                'name': rule_name,
                'condition': rule_condition,
                'ruled_para': ruled_para,
                'constraint': constraints if constraints else "NA",
                'description': descriptions if descriptions else "NA",
                'depend_para': depend_para,
                'depend_cond': "NA"
            }
            outputs.append(rule_info)
        return outputs


    def extract_conditions_helper(self, outputs: List, conditions: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract the Conditions section in the CloudFormation template into the conditions section in the IR."""
        if conditions is None:
            return conditions
        # Register the condition name to id mapping in case the condition is not listed in sequence.
        for condition_name, condition_data in conditions.items():
            condition_name = f"{CFN_CONDITION_PREFIX}{condition_name}"
            self.condition_name_to_id[condition_name] = str(uuid.uuid4())
        
        # Build dictionary {condition_name: condition_expression} for reference resolution 
        # This is to avoid the condition sequence is not sequential in IaC template.
        all_conditions_dict = {}
        for condition_name, condition_data in conditions.items():
            condition_name_with_prefix = f"{CFN_CONDITION_PREFIX}{condition_name}"
            all_conditions_dict[condition_name_with_prefix] = condition_data
        
        # Convert to SMT format
        # NOTE: SMT Conversion at here
        for condition_name, condition_data in conditions.items():
            condition_name = f"{CFN_CONDITION_PREFIX}{condition_name}"
            
            # Extract parameters from Condition
            depend_para = []
            if isinstance(condition_data, dict):
                depend_para.extend(self._extract_refs_from_dict(condition_data))
            depend_para = [self.para_name_to_id[para] for para in set(depend_para)] if depend_para else "NA"   # NOTE: We are assuming the parameter used is inside the template.
            # depend_para = [self.para_name_to_id[para] for para in set(depend_para) if para in self.para_name_to_id] if depend_para else "NA"
            
            # Extract condition dependencies
            depend_cond = []
            if isinstance(condition_data, dict):
                depend_cond = self._extract_condition_refs_from_dict(condition_data)
            depend_cond = [self.condition_name_to_id[cond] for cond in depend_cond if cond in self.condition_name_to_id] if depend_cond else "NA"
            
            # Convert to SMT format
            try:
                self.condition_depend_parameter = set()   # Initialize/clear the set of dependent parameters
                smt_condition = self.convert_condition_to_smt(condition_data, all_conditions_dict)
                smt_condition[0] = smt_condition[0].replace("AWS::", "AWS_")
                smt_condition[0] = smt_condition[0].replace("True", "true")
                smt_condition[0] = smt_condition[0].replace("False", "false")
                temp_smt_condition = f"(assert {smt_condition[0]})" if smt_condition else "NA"
                smt_condition = []
                
                for param in self.parameters:   # Add parameter declaration to the condition
                    if param['name'] in self.condition_depend_parameter:
                        smt_condition.append(param.get('constraints', {}).get('expressions', [])[0])   
                smt_condition.append(temp_smt_condition)
            except Exception as e:
                # print(f"Error converting condition to SMT-LIB2 format: {e}")
                smt_condition = []

            condition_info = {
                'id': self.condition_name_to_id[condition_name],
                'name': condition_name,
                'condition': smt_condition,  # SMT format
                'ruled_para': "NA",
                'constraint': "NA",
                'description': "NA",
                'depend_para': depend_para,
                'depend_cond': depend_cond
            }
            outputs.append(condition_info)
        
        return outputs

    
    def convert_condition_to_smt(self, condition_data: Dict[str, Any], all_conditions_dict: Dict[str, Dict[str, Any]] = None) -> List[str]:
        """
        Convert CloudFormation condition expression to SMT-LIB2 format.
        Recursive function that handles nested conditions.
        
        Args:
            condition_data: Dictionary with one key: 'Equals', 'Not', 'And', or 'Or'
            all_conditions_dict: Dictionary for resolving Condition references
        
        Returns:
            List containing one SMT2 string
        """
        if not isinstance(condition_data, dict) or len(condition_data) != 1:
            raise Exception(f"Invalid CloudFormation template: Condition data is not a dictionary or has {len(condition_data)} keys, but should have 1.")
        
        key = list(condition_data.keys())[0]
        value = condition_data[key]
        
        if key in ['Equals', 'Fn::Equals']:
            if len(value) != 2:   # Validation as Equals condition has two operands
                raise Exception(f"Invalid CloudFormation template: Equals condition has {len(value)} operands, but should have 2.")
            if isinstance(value[0], dict) and ('Ref' in value[0].keys() or 'Fn::Ref' in value[0].keys()):   # left operand is a parameter reference
                left = self._convert_operand_to_smt(value[0], all_conditions_dict)
                for param in self.parameters:
                    if param['name'] == left:
                        param_type = param['type']
                        break
                right = self._convert_operand_to_smt(value[1], all_conditions_dict, param_type)
            elif isinstance(value[1], dict) and ('Ref' in value[1].keys() or 'Fn::Ref' in value[1].keys()):   # right operand is a parameter reference
                right = self._convert_operand_to_smt(value[1], all_conditions_dict)
                for param in self.parameters:
                    if param['name'] == right:
                        param_type = param['type']
                        break
                left = self._convert_operand_to_smt(value[0], all_conditions_dict, param_type)
            else:
                left = self._convert_operand_to_smt(value[0], all_conditions_dict)
                right = self._convert_operand_to_smt(value[1], all_conditions_dict)
            return [f'(= {left} {right})']
        
        elif key in ['Not', 'Fn::Not']:
            if len(value) != 1:
                raise Exception(f"Invalid CloudFormation template: Not condition has {len(value)} operands, but should have 1.")
            inner = self.convert_condition_to_smt(value[0], all_conditions_dict)
            if not inner:
                raise Exception(f"Invalid CloudFormation template: Not condition has invalid inner condition.")
            return [f'(not {inner[0]})']
        
        elif key in ['And', 'Fn::And']:
            if len(value) < 2 or len(value) > 10:
                raise Exception(f"Invalid CloudFormation template: And condition has {len(value)} operands, but should be between 2 and 10.")
            expressions = []
            for cond in value:
                cond_smt = self.convert_condition_to_smt(cond, all_conditions_dict)
                if cond_smt:
                    expressions.append(cond_smt[0])
            if expressions:
                return [f'(and {" ".join(expressions)})']
            return []
        
        elif key in ['Or', 'Fn::Or']:
            if len(value) < 2 or len(value) > 10:
                raise Exception(f"Invalid CloudFormation template: Or condition has {len(value)} operands, but should be between 2 and 10.")
            expressions = []
            for cond in value:
                cond_smt = self.convert_condition_to_smt(cond, all_conditions_dict)
                if cond_smt:
                    expressions.append(cond_smt[0])
            if expressions:
                return [f'(or {" ".join(expressions)})']
            return []
        
        elif key in ['Condition', 'Fn::Condition']:
            condition_name = f"{CFN_CONDITION_PREFIX}{value}"
            
            # Find referenced condition
            if all_conditions_dict and condition_name in all_conditions_dict:
                referenced_data = all_conditions_dict[condition_name]
                if referenced_data:
                    return self.convert_condition_to_smt(referenced_data, all_conditions_dict)
        
        return []


    def _convert_operand_to_smt(self, operand: Any, all_conditions_dict: Dict = None, type: str = 'NA'):
        """
        Convert an operand (left or right side of Equals) to SMT expression string.
        Note: The operand is the left or right side of the Equals condition.
        Type: The type of the operand, e.g. Number, String, etc.
        Handles Ref, Select references, and literals.
        """
        if isinstance(operand, dict):
            if 'Ref' in operand.keys() or 'Fn::Ref' in operand.keys():   # The Ref will only be used with Equals condition
                # Parameter reference
                param_name = operand.get('Ref') or operand.get('Fn::Ref')
                self.condition_depend_parameter.add(param_name)
                return param_name
            elif 'Select' in operand.keys() or 'Fn::Select' in operand.keys():   # The Select will only be used with Equals condition
                select_items = operand.get('Select') or operand.get('Fn::Select')
                select_index = select_items[0]
                select_list = select_items[1]
                if isinstance(select_list, dict):
                    raise Exception(f"Unsupport condition value: The condition request a list value from parameter that is not inputed.")
                return f'"{select_list[select_index]}"'
            elif 'FindInMap' in operand.keys() or 'Fn::FindInMap' in operand.keys():
                value = operand.get('FindInMap') or operand.get('Fn::FindInMap')
                if len(value) != 3:
                    raise Exception(f"Invalid CloudFormation template: FindInMap condition has {len(value)} operands, but should have 3.")
                map_name = value[0]
                top_level_key = value[1]
                second_level_key = value[2]
                
                # Recursively resolve keys (they might be nested FindInMap or Ref)
                top_key_smt, top_key_is_dynamic = self._resolve_map_key_to_smt(top_level_key, all_conditions_dict)
                second_key_smt, second_key_is_dynamic = self._resolve_map_key_to_smt(second_level_key, all_conditions_dict)
                
                # Get mapping data from parameters
                mapping_data = self._get_mapping_data(map_name)
                
                if not mapping_data:
                    # Mapping not found - return unconstrained variable
                    var_name = f"findinmap_{map_name}_{hash(str(operand)) % 10000}"
                    return var_name
                
                # Build SMT-LIB2 ite expression
                return self._build_findinmap_ite_expression(
                    mapping_data, 
                    top_key_smt, 
                    top_key_is_dynamic,
                    second_key_smt, 
                    second_key_is_dynamic,
                    all_conditions_dict
                )
            elif 'Join' in operand.keys() or 'Fn::Join' in operand.keys():
                value = operand.get('Join') or operand.get('Fn::Join')
                if len(value) != 2:
                    raise Exception(f"Invalid CloudFormation template: Join condition has {len(value)} operands, but should have 2.")
                join_items = value[1]
                if isinstance(join_items, list):
                    for item in join_items:
                        # TODO: Handle Join 
                        if isinstance(item, dict):   # In case of !Ref, ignore the item.
                            return self._convert_operand_to_smt(item, all_conditions_dict)
                elif isinstance(join_items, dict):
                    return self._convert_operand_to_smt(join_items, all_conditions_dict)
                return join_items.join(value[0])
            # elif 'Condition' in operand or 'Fn::Condition' in operand:   # The Condition will not be used with Equals condition
            #     # Condition reference in operand (shouldn't happen in Equals, but handle it)
            #     cond_name = operand.get('Condition') or operand.get('Fn::Condition')
            #     if not cond_name.startswith(CFN_CONDITION_PREFIX):
            #         cond_name = f"{CFN_CONDITION_PREFIX}{cond_name}"
            #     # Resolve and convert
            #     if all_conditions_dict and cond_name in all_conditions_dict:
            #         referenced_data = all_conditions_dict[cond_name]
            #         if referenced_data:
            #             cond_smt = self.convert_condition_to_smt(referenced_data, all_conditions_dict)
            #             if cond_smt:
            #                 return cond_smt[0]
            #     return cond_name
            # else:
            #     # # The nested condition expression will not be used with Equals condition
            #     cond_smt = self.convert_condition_to_smt(operand, all_conditions_dict)
            #     if cond_smt:
            #         return cond_smt[0]
            #     return str(operand)
        elif isinstance(operand, str) and operand.isdigit() and type == 'Number':
            return int(operand)
        elif isinstance(operand, bool):   # In case of PermissionBoundariesCondition: !Equals [ !Ref UsePermissionBoundaries, True ] 
            return f'"{str(operand).lower()}"'
        elif isinstance(operand, str):
            return f'"{operand}"'
        elif isinstance(operand, (int, float)) and type == 'Number':
            return operand
        else:
            return f'"{operand}"'


    def _resolve_map_key_to_smt(self, key: Any, all_conditions_dict: Dict = None) -> Tuple[str, bool]:
        """
        Resolve a map key to SMT expression.
        The key can be:
        - A literal string/number
        - A parameter reference (Ref)
        - A nested FindInMap expression
        
        Returns:
            Tuple of (SMT expression string, is_dynamic)
            is_dynamic: True if key depends on parameters (can't be statically resolved)
        """
        if isinstance(key, dict):
            if 'Ref' in key.keys() or 'Fn::Ref' in key.keys():
                # Parameter reference - return parameter name
                param_name = key.get('Ref') or key.get('Fn::Ref')
                self.condition_depend_parameter.add(param_name)
                return param_name, True
            
            elif 'FindInMap' in key.keys() or 'Fn::FindInMap' in key.keys():
                # Nested FindInMap - recursively resolve
                nested_result = self._convert_operand_to_smt(key, all_conditions_dict)
                return nested_result, True
            
            else:
                # Unknown dict structure - treat as dynamic
                return f'"{str(key)}"', True
        
        elif isinstance(key, str):
            # Literal string key
            return f'"{key}"', False

        elif isinstance(key, bool):   # In case of PermissionBoundaries'Condition': !Equals [ !Ref UsePermissionBoundaries, True ] 
            return f'"{str(key).lower()}"', False
        
        elif isinstance(key, (int, float)):
            # Literal number key
            return str(key), False

        else:
            # Unknown type - treat as dynamic
            return f'"{str(key)}"', True
        

    def _get_mapping_data(self, map_name: str) -> Optional[Dict]:
        """
        Get mapping data from parameters list.
        Returns the mapping dictionary or None if not found.
        """
        for param in self.parameters:
            if param['name'] == map_name and param['type'] == 'mapping':
                default = param.get('default', {})
                if isinstance(default, dict) and map_name in default:
                    return default[map_name]
                elif isinstance(default, dict):
                    return default
        return None


    def _build_findinmap_ite_expression(
        self, 
        mapping_data: Dict, 
        top_key_smt: str, 
        top_key_is_dynamic: bool,
        second_key_smt: str, 
        second_key_is_dynamic: bool,
        all_conditions_dict: Dict = None
    ) -> str:
        """
        Build SMT-LIB2 ite (if-then-else) expression for FindInMap lookup.
        
        Args:
            mapping_data: The mapping dictionary
            top_key_smt: SMT expression for top-level key (just the expression, not tuple)
            top_key_is_dynamic: Whether top key is dynamic
            second_key_smt: SMT expression for second-level key (just the expression, not tuple)
            second_key_is_dynamic: Whether second key is dynamic
            all_conditions_dict: Dictionary for resolving conditions
        
        Returns:
            SMT-LIB2 expression string
        """
        # Case 1: Both keys are static - simple lookup
        if not top_key_is_dynamic and not second_key_is_dynamic:
            top_key = top_key_smt.strip('"')
            second_key = second_key_smt.strip('"')
            
            if top_key in mapping_data and isinstance(mapping_data[top_key], dict):
                if second_key in mapping_data[top_key]:
                    value = mapping_data[top_key][second_key]
                    return self._value_to_smt(value)
            
            # Key not found - return default
            return '""'
        
        # Case 2: Top key is dynamic, second key is static
        # This is the most common case: FindInMap [MapName, !Ref Param, "static_key"]
        if top_key_is_dynamic and not second_key_is_dynamic:
            second_key = second_key_smt.strip('"')  # Extract the literal string
            ite_chain = None
            default_value = '""'
            
            # Build ite chain: (ite (= top_key "key1") value1 (ite (= top_key "key2") value2 ...))
            # Only extract the specific second_key value for each top-level key
            for top_key, second_level_dict in reversed(list(mapping_data.items())):
                if isinstance(second_level_dict, dict) and second_key in second_level_dict:
                    value = second_level_dict[second_key]  # Get the specific value we're looking for
                    smt_value = self._value_to_smt(value)
                    
                    if ite_chain is None:
                        ite_chain = f'(ite (= {top_key_smt} "{top_key}") {smt_value} {default_value})'
                    else:
                        ite_chain = f'(ite (= {top_key_smt} "{top_key}") {smt_value} {ite_chain})'
            
            return ite_chain if ite_chain else default_value
        
        # Case 3: Second key is dynamic, top key is static
        if not top_key_is_dynamic and second_key_is_dynamic:
            top_key = top_key_smt.strip('"')
            
            if top_key not in mapping_data or not isinstance(mapping_data[top_key], dict):
                return '""'
            
            second_level_dict = mapping_data[top_key]
            ite_chain = None
            default_value = '""'
            
            # Build ite chain for second-level keys
            for second_key, value in reversed(list(second_level_dict.items())):
                smt_value = self._value_to_smt(value)
                
                if ite_chain is None:
                    ite_chain = f'(ite (= {second_key_smt} "{second_key}") {smt_value} {default_value})'
                else:
                    ite_chain = f'(ite (= {second_key_smt} "{second_key}") {smt_value} {ite_chain})'
            
            return ite_chain if ite_chain else default_value
        
        # Case 4: Both keys are dynamic - nested ite chains
        outer_ite_chain = None
        default_value = '""'
        
        for top_key, second_level_dict in reversed(list(mapping_data.items())):
            if not isinstance(second_level_dict, dict):
                continue
            
            # Build inner ite chain for second-level keys
            inner_ite_chain = None
            for second_key, value in reversed(list(second_level_dict.items())):
                smt_value = self._value_to_smt(value)
                
                if inner_ite_chain is None:
                    inner_ite_chain = f'(ite (= {second_key_smt} "{second_key}") {smt_value} {default_value})'
                else:
                    inner_ite_chain = f'(ite (= {second_key_smt} "{second_key}") {smt_value} {inner_ite_chain})'
            
            if inner_ite_chain is None:
                inner_ite_chain = default_value
            
            # Wrap in outer ite for top-level key
            if outer_ite_chain is None:
                outer_ite_chain = f'(ite (= {top_key_smt} "{top_key}") {inner_ite_chain} {default_value})'
            else:
                outer_ite_chain = f'(ite (= {top_key_smt} "{top_key}") {inner_ite_chain} {outer_ite_chain})'
        
        return outer_ite_chain if outer_ite_chain else default_value


    def _value_to_smt(self, value: Any) -> str:
        """
        Convert a Python value to SMT-LIB2 string format.
        """
        if isinstance(value, str):
            return f'"{value}"'
        elif isinstance(value, bool):
            return f'"{str(value).lower()}"'
        elif isinstance(value, (int, float)):
            return str(value)
        else:
            return f'"{str(value)}"'

            
    def _extract_condition_refs_from_dict(self, data: Dict[str, Any]) -> List[str]:
        """
        Helper function to extract condition references from condition data.
        Looks for 'Condition' key in dictionaries and extracts the condition names.
        """
        condition_refs = []
        
        def extract_condition_refs_recursive(obj):
            if isinstance(obj, dict):
                for key, value in obj.items():
                    if key == 'Condition':
                        value = f"{CFN_CONDITION_PREFIX}{value}"   # Add prefix to the condition name
                        # Extract the condition name
                        if isinstance(value, str):
                            condition_refs.append(value)
                        # elif isinstance(value, list):
                        #     # Handle cases where Condition might be a list
                        #     for item in value:
                        #         if isinstance(item, str):
                        #             condition_refs.append(item)
                    elif isinstance(value, (dict, list)):
                        extract_condition_refs_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    extract_condition_refs_recursive(item)
        
        extract_condition_refs_recursive(data)
        return condition_refs


    def _extract_refs_from_dict(self, data: Dict[str, Any]) -> List[str]:
        """
        Helper function to extract parameter/resource references from normal or nested dictionaries (dictionary is like {'Ref': 'name'}).
        The choice of recursive is because the parameter can be nested in a dictionary which loaded from intrinsic functions.
        """
        refs = []
        
        def extract_refs_recursive(obj):
            if isinstance(obj, dict):
                for key, value in obj.items():   # As !Ref: name will be loaded as a dictionary like {'Ref': 'name'}
                    if key == 'Ref' or key == 'Fn::Ref':
                        refs.append(value)
                    elif key == 'GetAtt' or key == 'Fn::GetAtt':
                        # GetAtt can be ['ResourceName', 'Attribute'] or 'ResourceName.Attribute'
                        if isinstance(value, list) and len(value) > 0:
                            refs.append(value[0])  # Extract just the resource name
                        elif isinstance(value, str):
                            refs.append(value.split('.')[0])  # Extract resource name before the dot
                    elif key == 'FindInMap' or key == 'Fn::FindInMap':
                        if isinstance(value, list) and len(value) > 0:
                            map_name = value[0]
                            if isinstance(map_name, dict):   # In case it is a nested FindInMap
                                extract_refs_recursive(map_name)
                            else:
                                refs.append(map_name)  # Extract just the MapName from [MapName, TopLevelKey, SecondLevelKey ]
                        for item in value[1:]:  # Handle case when pseudo-parameters are used in the key such as !FindInMap [RegionMap, !Ref "AWS::Region", AMI]
                            extract_refs_recursive(item)
                    elif key == 'Sub' or key == 'Fn::Sub':
                        if isinstance(value, list) and len(value) > 0:   # Note: We are assuming the IaC template follows the syntax of !Sub.
                            # Get all references name from the string
                            matches = re.findall(SUBSTITUTION_PATTERN, value[0])
                            # Handle case when the reference name is not the name of referencing element. Such as !Sub ["Hello ${id}", {"id": !Ref "parameter/resource name"}]
                            for key, value in value[1].items():
                                if key in matches:
                                    extract_refs_recursive(value)
                                    matches.remove(key)
                            # Handle case when the reference name does not present in the list. Such as !Sub ["Hello ${id} ${AWS::StackName}", {"id": !Ref "parameter/resource name"}]
                            for match in matches:
                                if len(match.split(".")) > 1:   # Handle the edge case of resource references ${MyInstance.PublicIp}
                                    match = match.split(".")[0]
                                refs.append(match)
                        # !Sub "Hello ${AWS::StackName}" or !Sub ["Hello ${AWS::StackName}", {...}]
                        elif isinstance(value, str):
                            # Extract parameter references from the string
                            matches = re.findall(SUBSTITUTION_PATTERN, value)
                            for match in matches:
                                if len(match.split(".")) > 1:   # Handle the edge case of resource references ${MyInstance.PublicIp}
                                    match = match.split(".")[0]
                                refs.append(match)
                    elif key == 'Join' or key == 'Fn::Join':
                        # !Join [",", ["Hello", !Ref MyParam]]
                        if isinstance(value, list) and len(value) > 1:
                            join_items = value[1]  # The second element contains the items to join
                            if isinstance(join_items, list):
                                for item in join_items:
                                    if isinstance(item, dict):
                                        # Check for Ref, GetAtt, etc.
                                        extract_refs_recursive(item)  # Remove assignment - function works by side effect
                                    elif isinstance(item, str):
                                        # Handle string literals in Join - they don't contain references
                                        pass
                            elif isinstance(join_items, dict):   # Handle case when the join items is a list type parameter
                                extract_refs_recursive(join_items)
                    elif isinstance(value, (dict, list, str)):
                        extract_refs_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    extract_refs_recursive(item)
            elif isinstance(obj, str):
                # Handle case of use of Pseudo-parameters in string
                matches = re.fullmatch(AWS_PSEUDO_PARAMETERS_PATTERN, obj)
                if matches:
                    refs.append(matches.group(0))
        
        extract_refs_recursive(data)
        return refs


    def filter_non_cfn_resources(self, template_data: Dict[str, Any]) -> Dict[str, Any]:
        """Filter out non-CloudFormation resources."""
        res = template_data.get('Resources', {})
        new_res = {}
        for resource_name, resource_data in res.items():
            if isinstance(resource_data, list):
                continue
            elif resource_data.get('Type', 'NA') == 'NA':   # If there is not type for the resource
                continue
            else:
                type = str(resource_data.get('Type'))
                if type.startswith('Rain::'):
                    continue
                new_res[resource_name] = resource_data
        return new_res


    def extract_resources(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract resources section"""
        resources = []
        res = template_data.get('Resources', {})
        if res is None:
            return res
        # Filter out non-CloudFormation resources such as Rain and For::Each
        # TODO: Handle the For::Each resources in later version
        res = self.filter_non_cfn_resources(template_data)
        if not res:
            return resources

        # Assign id before extracting resources
        for resource_name, resource_data in res.items():
            self.resource_name_to_id[resource_name] = str(uuid.uuid4())
        
        for resource_name, resource_data in res.items():
            # Extract individual properties
            properties_data = resource_data.get('Properties', {})
            arguments = self.extract_resource_arguments(resource_data)
            property_units = self.extract_resource_properties(properties_data)

            # Get overall resource references (for backward compatibility)
            # Note: This can be optimized by extracting references from properties_data instead of resource_data
            # resource_refs, parameter_refs = self.find_references(resource_data.get('Properties', {}))

            # Extract condition dependencies
            # depend_conditions = []
            # if resource_data.get('Condition'):
            #     depend_conditions.append(self.condition_name_to_id[resource_data.get('Condition')]) 
            # for property in property_units:
            #     temp_conditions = property.get('depend_conditions')
            #     if temp_conditions != "NA":
            #         depend_conditions.extend(temp_conditions)

            # If dependencies are manually specified, add it to the depend_conditions
            # if resource_data.get('DependsOn'):
                # Note the value can be a list or string
                # pass

            # print(resource_data)
            resource_info = {
                'id': self.resource_name_to_id[resource_name],
                'name': resource_name,
                'type': resource_data.get('Type', 'NA'),
                'properties': property_units,
                'arguments': arguments,
                # 'resource_refs': resource_refs if resource_refs else "NA",
                # 'parameter_refs': parameter_refs if parameter_refs else "NA",
                # 'depend_conditions': depend_conditions
            }
            resources.append(resource_info)
        return resources


    def extract_resource_arguments(self, resource_data: Dict[str, Any]) -> Dict[str, Any]:
        """Extract the resource attributes (arguments)"""
        if not resource_data:
            return "NA"
        arguments = {}
        for key, value in resource_data.items():
            if key in ARGUMENT_MAPPINGS['cloudformation']:   # Update the key to the name in the IR
                key = ARGUMENT_MAPPINGS['cloudformation'][key]
            if key == 'condition':
                condition_id = self.condition_name_to_id.get(f"{CFN_CONDITION_PREFIX}{value}", "NA")
                if condition_id == "NA":   # Cases where the condition is not defined in the template
                    continue
                arguments[key] = {
                    'condition_id': condition_id,
                    'true_value': "1",
                    'false_value': "0"
                }
            elif key == 'depends_on':
                if isinstance(value, dict):
                    raise Exception(f"CloudFormation Syntax Error: The depends_on value {value} is a dictionary, which is not supported.")
                for item in value:
                    if isinstance(item, dict):
                        raise Exception(f"CloudFormation Syntax Error: The depends_on value {item} is a dictionary, which is not supported.")
                arguments[key] = {
                    'value': value,
                    'resource_refs': value,
                    'parameter_refs': "NA"
                }
            elif key in ARGUMENT_MAPPINGS['cloudformation']:
                key = ARGUMENT_MAPPINGS['cloudformation'][key]
                arguments[key] = {
                    'value': value,
                    'resource_refs': "NA",
                    'parameter_refs': "NA"
                }
        return arguments if arguments else "NA"
    

    def extract_resource_properties(self, properties_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """
        Extract individual properties from resource properties data.
        Each property becomes a separate unit with its own dependencies.
        """
        property_units = []
        
        if not properties_data or not isinstance(properties_data, dict):   # If properties_data is not a dictionary or is an empty dictionary
            return "NA"
        
        for prop_name, prop_value in properties_data.items():
            # Find references in this specific property
            resource_refs, parameter_refs = self.find_references({prop_name: prop_value})
            
            # Check for condition dependencies in this property
            depend_conditions = self._extract_condition_refs_from_property(prop_value)
            depend_conditions = [self.condition_name_to_id[cond] for cond in depend_conditions if cond in self.condition_name_to_id] if depend_conditions else "NA"

            property_unit = {
                'name': prop_name,
                'value': prop_value,
                'resource_refs': resource_refs if resource_refs else "NA",
                'parameter_refs': parameter_refs if parameter_refs else "NA",
                'depend_conditions': depend_conditions
            }
            property_units.append(property_unit)
        
        return property_units


    def _extract_condition_refs_from_property(self, prop_value: Any) -> List[str]:
        """
        Extract condition references from a property value.
        Looks for !If, !Condition, and other condition-related intrinsic functions.
        """
        condition_refs = []
        
        def extract_conditions_recursive(obj):
            if isinstance(obj, dict):
                for key, value in obj.items():
                    if key == 'If' or key == 'Fn::If':
                        # !If [condition, true_value, false_value]
                        if isinstance(value, list) and len(value) > 0:
                            condition_name = value[0]
                            if isinstance(condition_name, str):
                                condition_refs.append(f"{CFN_CONDITION_PREFIX}{condition_name}")
                            if len(value) > 1 and value[1]:
                                extract_conditions_recursive(value[1])
                            if len(value) > 2 and value[2]:
                                extract_conditions_recursive(value[2])
                    elif isinstance(value, (dict, list)):   # TODO: Not sure if the list is needed for all this type of functions.
                        extract_conditions_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    extract_conditions_recursive(item)
        
        extract_conditions_recursive(prop_value)
        return condition_refs


    def find_references(self, data: Dict[str, Any]) -> Tuple[List[str], List[str]]:
        """
        Find resources that reference this resource with comprehensive reference detection.
        """
        resource_refs = []
        parameter_refs = []
        
        for data_name, data_value in data.items():
            if isinstance(data_value, (dict, list)):
                references = self._extract_refs_from_dict(data_value)
            elif isinstance(data_value, str):
                # Handle case of use of Pseudo-parameters in string
                matches = re.findall(AWS_PSEUDO_PARAMETERS_PATTERN, data_value)
                if matches:
                    references = matches
                else:
                    continue
            else:
                continue
            
            temp_resource_refs, temp_parameter_refs = self._extract_parameter_and_resource_refs(references)
            resource_refs.extend(temp_resource_refs)
            parameter_refs.extend(temp_parameter_refs)

        return resource_refs, parameter_refs


    def extract_outputs(self, template_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Extract outputs section"""
        outputs = []
        out = template_data.get('Outputs', {})
        if out is None:
            return out
        
        for output_name, output_data in out.items():
            # TODO: Handle the Fn::ForEach outputs in later version
            if output_name.startswith('Fn::ForEach::'):
                continue
            output_pure_data = {k:v for k,v in output_data.items()}
            # output_pure_data = {k:v for k,v in output_data.items() if k != "Export"}
            source_resource, source_parameter = self.find_references(output_pure_data)
            # Remove the duplications in the source_resource and source_parameter
            source_resource = list(set(source_resource))
            source_parameter = list(set(source_parameter))

            export_name_info = self._extract_export_name_helper(output_data.get('Export', "NA"))
            
            depend_condition = []
            direct_condition = output_data.get('Condition', '')   # If the condition is not specified, it will be an empty string to avoid trigger the if statement
            if direct_condition:
                direct_condition = f"{CFN_CONDITION_PREFIX}{direct_condition}"
                depend_condition.append(self.condition_name_to_id[direct_condition])   # Change the condition name to id
            
            # Fomulate the value of the output
            value = {}
            value['value'] = output_data.get('Value', "NA")
            value['depend_conditions'] = "NA"
            if_depend_conditions = self._extract_condition_refs_from_property(output_data.get('Value', "NA"))
            if if_depend_conditions:
                value['depend_conditions'] = [self.condition_name_to_id[cond] for cond in if_depend_conditions if cond in self.condition_name_to_id]
            
            output_info = {
                'id': str(uuid.uuid4()),  
                'name': f"{OUTPUT_PREFIX}{output_name}",
                'description': output_data.get('Description', 'NA'),
                'value': value,
                'source_resource': source_resource if source_resource else "NA",
                'source_parameter': source_parameter if source_parameter else "NA",
                'export_name': export_name_info,
                'depend_conditions': depend_condition if depend_condition else "NA"
            }
            outputs.append(output_info)
        
        return outputs
    

    def _extract_export_name_helper(self, data: Dict[str, Any]):
        """
        Extract export name dependencies for Sub and Join intrinsic functions.
        Returns a dictionary with 'value' and 'depend_para' keys.
        This function is actually also handling the Sub and Join intrinsic functions.
        """
        if data == 'NA':
            return "NA"
        
        depend_elements = []      
        depend_conditions = []
        
        for export_element in data.values():    
            depend_elements.extend(self._extract_refs_from_dict(export_element))
            depend_conditions.extend(self._extract_condition_refs_from_property(export_element))

        depend_resource, depend_para = self._extract_parameter_and_resource_refs(depend_elements)
        
        depend_conditions = [self.condition_name_to_id[cond] for cond in depend_conditions if cond in self.condition_name_to_id] if depend_conditions else "NA"
        return {
            'name': data.get('Name', 'NA'),
            'depend_para': depend_para,
            'depend_resource': depend_resource if depend_resource else "NA",
            'depend_conditions': depend_conditions
        }


    def _extract_parameter_and_resource_refs(self, references: Any):
        parameter_refs = []
        resource_refs = []
        for reference in references:
            if isinstance(reference, list):
                raise Exception(f"The reference {reference} is a list, which is not supported.")
            if self.resource_name_to_id.get(reference):
                resource_refs.append(self.resource_name_to_id[reference])
            elif self.para_name_to_id.get(reference):
                parameter_refs.append(self.para_name_to_id[reference])

        return resource_refs, parameter_refs
    

    # def contains_reference(self, resource: Dict[str, Any], target: str) -> bool:
    #     """Check if a resource contains a reference to the target"""
    #     import json
    #     resource_str = json.dumps(resource)
    #     return f'"{target}"' in resource_str or f"'{target}'" in resource_str
    

    # def find_parameter_refs(self, resource_data: Dict[str, Any]) -> List[str]:
    #     """Find parameter references in resource properties"""
    #     import json
    #     resource_str = json.dumps(resource_data)
    #     # Simple parameter reference detection - could be enhanced
    #     # This is a basic implementation that looks for Ref patterns
    #     return []
    

    # def build_dependency_graph(self, template_data: Dict[str, Any]) -> Dict[str, Any]:
    #     """Build dependency graph between resources"""
    #     # TODO: Implement dependency graph building
    #     # This would analyze DependsOn, Ref, GetAtt, etc.
    #     return {
    #         'nodes': [],
    #         'edges': [],
    #         'metadata': 'Dependency graph not yet implemented'
    #     }