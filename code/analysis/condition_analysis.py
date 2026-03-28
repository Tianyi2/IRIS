from typing import Dict, Any
from analysis.base_analysis import BaseAnalysis
from z3.z3 import parse_smt2_string
from z3 import String, Int, ExprRef, Solver, String, Bool, And, Or, Not, sat, unsat
from config.config import CFN_CONDITION_PREFIX
# This class is used to analyze the conditions in the IR with SMT solver


class ConditionAnalyzer(BaseAnalysis):
    def __init__(self, ir: Dict[str, Any]):
        super().__init__(ir)
        self.language = self.get_metadata().get('template_type', 'NA')
        self.z3_vars = {}
        # self.z3_expressions = {}
        self.analysis_results = {}
        self.conditions = self.get_conditions()
        # Load necessary variables from the IR
        self.load_parameters()
        # self.load_conditions()


    def analyze(self):
        # call all analysis methods
        self.analyze_always_true_or_false_condition()
        self.analyze_dead_resources()
        
        return self.analysis_results


    def load_parameters(self):
        """Build Z3 variable map from parameters"""
        for param in self.get_parameters():
            param_id = param['id']
            param_name = param['name']
            # TODO: type can be omitted sometimes in IaC templates (Terraform)
            param_type = param['type']
            if param['constraints'] == 'NA':   
                continue
            
            param_constraints = param.get('constraints', {}).get('expressions', [])
            # param_constraints = param['constraints']['expressions']
            
            self.z3_vars[param_id] = {
                'name': param_name,
                'type': param_type,
                'constraints': param_constraints
            }
          

    def analyze_always_true_or_false_condition(self):
        """Check if condition is always true or false or invalid"""
        always_false_conditions = []
        always_true_conditions = []
        invalid_conditions = []

        for condition in self.conditions:
            try:
                if condition['ruled_para'] != 'NA' or isinstance(condition['condition'], bool):
                    continue
                # Get the constraints
                depend_parameters = condition['depend_para'] if condition['depend_para'] != 'NA' else []
                parameter_constraints = []
                condition_constraints = [] 

                # Register the parameter type for the dependent conditions
                if condition['depend_cond'] != 'NA':
                    for cond_id in condition['depend_cond']:
                        for cond in self.conditions:
                            if cond['id'] == cond_id:
                                depend_para = cond['depend_para']
                                if depend_para != 'NA':
                                    depend_parameters.extend(depend_para)   

                depend_parameters = list(set(depend_parameters))
                for param_id in depend_parameters:
                    expression = self.z3_vars.get(param_id, {}).get('constraints', [])
                    if expression:
                        parameter_constraints.extend(self.z3_vars[param_id]['constraints'])
                        # condition_constraints.append(self.z3_vars[param_id]['constraints'][0])   # Register the parameter type
                # print(parameter_constraints)
                parameter_constraints = "\n".join(parameter_constraints)   # Convert the constraints in list to string
                parameter_constraints = parse_smt2_string(parameter_constraints)   # Load the constraints into Z3 form
                # print(condition['name'])
                condition_constraints.extend(condition['condition'])   # Register the condition expression
                # print(condition_constraints)
                condition_constraints = "\n".join(condition_constraints)
                condition_constraints = parse_smt2_string(condition_constraints)
                condition_to_check = condition_constraints[-1]   # Get the condition expression to check

                # Test if condition can be False
                s_false = Solver()
                s_false.add(parameter_constraints)
                s_false.add(Not(condition_to_check))
                can_be_false = s_false.check() == sat

                # Test if condition can be True  
                s_true = Solver()
                s_true.add(parameter_constraints)
                s_true.add(condition_to_check)
                can_be_true = s_true.check() == sat

                # Determine the condition status
                if can_be_false and can_be_true:   # can be both true and false
                    # print(f"Condition {condition['name']} can be both true and false")
                    pass
                elif can_be_false and not can_be_true:   # can be false but not true - Always False
                    always_false_conditions.append({
                        'name': condition['name'],
                        'id': condition['id'],
                    })
                elif not can_be_false and can_be_true:   # can be true but not false - Always True
                    always_true_conditions.append({
                        'name': condition['name'],
                        'id': condition['id'],
                    })
                else:   # Invalid condition
                    invalid_conditions.append({
                        'name': condition['name'],
                        'id': condition['id'],
                    })
            except Exception as e:
                continue

        if always_false_conditions:
            self.analysis_results['always_false_conditions'] = always_false_conditions
        if always_true_conditions:
            self.analysis_results['always_true_conditions'] = always_true_conditions
        if invalid_conditions:
            self.analysis_results['invalid_conditions'] = invalid_conditions


    def analyze_dead_resources(self):
        """
        Detect dead resources - resources that will not be provisioned 
        due to always_false conditions being used in their arguments or properties.
        """
        # NOTE: This analysis can also done with dependency graph information instead of the pure IR..
        dead_resources = []
        
        always_false_conditions = self.analysis_results.get('always_false_conditions', [])
        if not always_false_conditions:
            return  # No always_false conditions, so no dead resources
        
        # Create a mapping of condition ID to condition name for quick lookup
        condition_id_to_name = {}
        condition_name_to_id = {}
        for condition in self.conditions:
            condition_id_to_name[condition['id']] = condition['name']
            condition_name_to_id[condition['name']] = condition['id']
        
        # Get set of always_false condition IDs and names
        always_false_condition_ids = [condition['id'] for condition in always_false_conditions]
        
        # Check each resource
        for resource in self.get_resources():
            resource_id = resource.get('id')
            resource_name = resource.get('name')
            resource_type = resource.get('type')
            
            # Check if condition is used in arguments
            arguments = resource.get('arguments', 'NA')
            if arguments != 'NA' and isinstance(arguments, dict):
                condition = arguments.get('condition', {})
                condition_id = condition.get('condition_id', 'NA')
                if condition_id != 'NA':
                    # Check if this condition name is in always_false_condition_ids
                    if condition_id in always_false_condition_ids:
                        # TODO: Add the affecting resource information in later version, possibly with the dependency graph information check CPF analysis.
                        # affecting_resource = self._get_affecting_resource(resource_name)
                        dead_resources.append({
                            'name': resource_name,
                            'id': resource_id,
                            'type': resource_type,
                            # 'affecting_resource': affecting_resource
                        })
        
        if dead_resources and self.language != 'ARM':   # TODO: Support ARM in later version, ARM does not support dead resources analysis
            self.analysis_results['dead_resources'] = dead_resources


    def analyze_always_opposite_condition(self, first_condition_name, second_condition_name):
        """
        Check if the first condition is always opposite to the second condition
        """
        # Get the conditions
        first_condition = next((condition for condition in self.conditions if condition['name'] == first_condition_name), None)
        second_condition = next((condition for condition in self.conditions if condition['name'] == second_condition_name), None)
        if not first_condition or not second_condition:
            return False
        first_condition_constraints = [] 
        second_condition_constraints = []

        # first_depend_parameters = first_condition['depend_para'] if first_condition['depend_para'] != 'NA' else []
        # for param_id in first_depend_parameters:
        #         first_condition_constraints.append(self.z3_vars[param_id]['constraints'][0])   # Register the parameter type
        first_condition_constraints = (first_condition['condition'])
        first_condition_constraints = "\n".join(first_condition_constraints)
        first_condition_constraints = parse_smt2_string(first_condition_constraints)
        first_condition_constraints = first_condition_constraints[-1]

        # second_depend_parameters = second_condition['depend_para'] if second_condition['depend_para'] != 'NA' else []
        # for param_id in second_depend_parameters:
        #     second_condition_constraints.append(self.z3_vars[param_id]['constraints'][0])   # Register the parameter type
        second_condition_constraints = (second_condition['condition'])
        # print(second_condition_constraints)
        second_condition_constraints = "\n".join(second_condition_constraints)
        second_condition_constraints = parse_smt2_string(second_condition_constraints)
        second_condition_constraints = second_condition_constraints[-1]

        solver = Solver()
        solver.add(second_condition_constraints)
        solver.add(Not(first_condition_constraints))
        result = solver.check()
        return result == sat


    def display_analysis_result(self):
        """Display the analysis result"""
        print(self.analysis_results)