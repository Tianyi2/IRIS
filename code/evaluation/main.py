"""
Main file for the evaluation module (evaluating the performance of the program).
"""

import sys
import os
# Add the project root directory to Python path
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, project_root)
import yaml
import csv
import time
import pandas as pd
from typing import Dict, Any, List, Optional
from parsers.cloudformation_parser import CloudFormationParser
from parsers.terraform_parser import TerraformParser
from parsers.arm_parser import ARMParser
from analysis.dependency_graph import DependencyGraph
from parsers.bicep_parser import BicepParser
from parsers.bicep_pycep_parser import BicepPycepParser

INPUT_CSV_ENCODING = 'latin-1'
OUTPUT_CSV_ENCODING = 'utf-8-sig'



def evaluate_dependency_graph_analysis(input_csv_path: str, output_csv_path: str = "results/dependency_graph_analysis_results.csv", start_row=0, end_row=None):
    """
    Evaluate the performance of the dependency graph analysis.
    
    Args:
        input_csv_path: Path to the input CSV file containing template information
        output_csv_path: Path to the output CSV file for results
        start_row: Starting row to process (default 0)
        end_row: Ending row to process (default None, processes all rows)
    
    Note: this function will output the results into a csv file.
    Note: the csv file will include the following columns:
        - template_name
        - template_path
        - template_language
        - parse_time
        - dependency_graph_build_time
        - dependency_graph_analysis_time
        - dependency_graph_analysis_result
        - error_message
    """
    # Check if input CSV exists
    if not os.path.exists(input_csv_path):
        print(f"Error: Input CSV file '{input_csv_path}' not found.")
        return

    # Read input CSV using pandas
    try:
        df = pd.read_csv(input_csv_path, encoding=INPUT_CSV_ENCODING)
    except Exception as e:
        print(f"Error reading input CSV file: {str(e)}")
        return       

    # Validate and adjust row ranges
    end_row = len(df) if end_row is None else min(end_row, len(df))
    if start_row >= end_row:
        raise ValueError(f"Invalid row range: start_row ({start_row}) must be less than end_row ({end_row})")

    # Check if this is a grouped template CSV (has 'file_paths' column)
    is_grouped = 'file_paths' in df.columns
    
    total_to_process = end_row - start_row

    if os.path.exists(output_csv_path):
        out_df = pd.read_csv(output_csv_path, encoding=OUTPUT_CSV_ENCODING)
        start_row = len(df)
    
    def _maybe_save_progress(results: list, total: int, path: str) -> None:
        """Print progress and save to CSV every 1000 templates."""
        if len(results) % 100 == 0:
            print(f"{len(results)}/{total} templates processed")
            try:
                pd.DataFrame(results).to_csv(path, index=False, encoding=OUTPUT_CSV_ENCODING)
            except Exception as e:
                print(f"Error writing output CSV file (incremental save): {str(e)}")
    
    # Process each template
    results = []
    for index, row in df.iloc[start_row:end_row].iterrows():
        # print(index)
        template_name = row.get('template_name', '')
        template_language = row.get('template_language', '').lower()
        
        # Handle grouped templates (multiple files) vs single file templates
        if is_grouped:
            # For grouped templates, use file_paths (pipe-separated)
            template_path = row.get('file_paths', '')
            file_paths = [path.strip() for path in template_path.split('|')] if template_path else []
        else:
            # For single file templates, use template_path
            template_path = row.get('template_path', '')
            file_paths = [template_path] if template_path else []
        
        # Initialize result row
        result_row = {
            'template_name': template_name,
            'template_path': template_path if not is_grouped else '|'.join(file_paths),
            'template_language': template_language,
            'parse_time': '',
            'dependency_graph_build_time': '',
            'dependency_graph_analysis_time': '',
            'dependency_graph_analysis_result': '',
            'error_message': ''
        }
        
        # Check if template file(s) exist
        missing_files = [path for path in file_paths if not os.path.exists(path)]
        if missing_files:
            result_row['error_message'] = f"Template file(s) not found: {', '.join(missing_files)}"
            results.append(result_row)
            _maybe_save_progress(results, total_to_process, output_csv_path)
            continue
        
        if not file_paths:
            result_row['error_message'] = "No template file paths specified"
            results.append(result_row)
            _maybe_save_progress(results, total_to_process, output_csv_path)
            continue
        
        # Parse template based on language
        template_info = None
        parse_error = None
        
        parse_start_time = time.time()
        try:
            if template_language in ['cloudformation', 'cfn']:
                # CloudFormation doesn't support multiple files
                parser = CloudFormationParser(file_paths[0])
                template_info = parser.parse()
            elif template_language in ['terraform', 'tf', 'hcl']:
                # Terraform parser supports multiple files (pipe-separated paths)
                if is_grouped and len(file_paths) > 1:
                    # Pass pipe-separated paths for grouped templates
                    combined_paths = '|'.join(file_paths)
                    parser = TerraformParser(combined_paths)
                else:
                    # Single file
                    parser = TerraformParser(file_paths[0])
                template_info = parser.parse()
            elif template_language in ['arm', 'azure']:
                parser = ARMParser(file_paths[0])
                template_info = parser.parse()
            elif template_language in ['bicep', 'bicep_template']:
                parser = BicepPycepParser(file_paths[0])
                # parser = BicepParser(file_paths[0])
                template_info = parser.parse()
            else:
                parse_error = f"Unsupported template language: {template_language}"
        except yaml.YAMLError as e:
            parse_error = f"YAML parsing error: {str(e)}"
        except Exception as e:
            parse_error = f"Parser error: {str(e)}"

        parse_end_time = time.time()
        parse_time = parse_end_time - parse_start_time
        result_row['parse_time'] = str(parse_time)
        
        if parse_error:
            result_row['error_message'] = parse_error
            results.append(result_row)
            _maybe_save_progress(results, total_to_process, output_csv_path)
            continue
        
        # if template_info is None:
        #     result_row['error_message'] = "Parser returned None - template parsing failed"
        #     results.append(result_row)
        #     continue
        
        # Perform dependency graph analysis
        analysis_error = None
        analysis_time = 0
        analysis_result = ""
        
        try:
            # Build dependency graph
            build_graph_start_time = time.time()
            analysis = DependencyGraph(template_info)
            analysis.build_graph()
            build_graph_end_time = time.time()
            build_graph_time = build_graph_end_time - build_graph_start_time
            result_row['dependency_graph_build_time'] = str(build_graph_time)

            # Analyze dependency graph
            analysis_start_time = time.time()
            analysis.analyze()
            analysis_end_time = time.time()
            analysis_time = analysis_end_time - analysis_start_time
            result_row['dependency_graph_analysis_time'] = str(analysis_time)
                
            # Get analysis results
            if analysis.analysis_results:
                # Convert analysis results to string representation
                analysis_result = str(analysis.analysis_results)
            else:
                analysis_result = ""   # Empty string means no analysis results
            result_row['dependency_graph_analysis_result'] = analysis_result
                
            
        except Exception as e:
            analysis_error = f"Dependency graph analysis error: {str(e)}"
            result_row['error_message'] = analysis_error
        
        results.append(result_row)
        _maybe_save_progress(results, total_to_process, output_csv_path)
    
    # Convert results to DataFrame and save to CSV
    try:
        results_df = pd.DataFrame(results)
        results_df.to_csv(output_csv_path, index=False, encoding=OUTPUT_CSV_ENCODING)
        
        print(f"\n[INFO] Evaluation completed!")
        print(f"[INFO] Results saved to: {output_csv_path}")
        print(f"[INFO] Total templates processed: {len(results)}")
        
        # Print summary statistics
        successful_analyses = len(results_df[results_df['error_message'] == ''])
        failed_analyses = len(results_df[results_df['error_message'] != ''])
        
        print(f"[INFO] Successful analyses: {successful_analyses}")
        print(f"[INFO] Failed analyses: {failed_analyses}")
        print(f"[INFO] Success rate: {(successful_analyses/len(results)*100):.1f}%")
        
        # Display summary of errors if any
        # if failed_analyses > 0:
        #     print(f"\n🔍 Error Summary:")
        #     error_summary = results_df[results_df['error_message'] != '']['error_message'].value_counts()
        #     for error_type, count in error_summary.items():
        #         print(f"  • {error_type}: {count} occurrences")
        
    except Exception as e:
        print(f"Error writing output CSV file: {str(e)}")


def evaluate_compile_only(
    input_csv_path: str,
    output_csv_path: str = "evaluation/compile_only_results.csv",
    start_row: int = 0,
    end_row: Optional[int] = None,
    run_ir_syntax_check: bool = False,
) -> None:
    """
    Evaluate IR compilation (source → IR) only: no dependency graph, no downstream analyses.
    Use this to measure the percentage of templates that compile to IR successfully.
    Failures are expected only for invalid source syntax; parser/IR bugs should be fixed.

    Args:
        input_csv_path: Path to the input CSV with template_name, template_path (or file_paths), template_language
        output_csv_path: Path for the output CSV
        start_row: First row to process (default 0)
        end_row: Last row to process (default None = all)
        run_ir_syntax_check: If True, run ir_syntax_check on each successful IR and add issue counts/summary

    Output columns:
        template_name, template_path, template_language, compile_success, parse_time, error_message
        [, ir_nested_issues_count, ir_issues_by_section] when run_ir_syntax_check is True
    """
    if not os.path.exists(input_csv_path):
        print(f"Error: Input CSV file '{input_csv_path}' not found.")
        return

    try:
        df = pd.read_csv(input_csv_path, encoding=INPUT_CSV_ENCODING)
    except Exception as e:
        print(f"Error reading input CSV file: {str(e)}")
        return

    end_row = len(df) if end_row is None else min(end_row, len(df))
    if start_row >= end_row:
        raise ValueError(f"Invalid row range: start_row ({start_row}) must be less than end_row ({end_row})")

    is_grouped = "file_paths" in df.columns   # For Terraform Dataset
    results = []

    for index, row in df.iloc[start_row:end_row].iterrows():
        if index % 100 == 0:
            print(f"Processing template {index} of {end_row}")
        template_name = row.get("template_name", "")
        template_language = (row.get("template_language", "") or "").lower()

        if is_grouped:
            template_path = row.get("file_paths", "")
            file_paths = [p.strip() for p in (template_path or "").split("|")]
        else:
            template_path = row.get("template_path", "")
            file_paths = [template_path] if template_path else []

        result_row = {
            "template_name": template_name,
            "template_path": template_path if not is_grouped else "|".join(file_paths),
            "template_language": template_language,
            "compile_success": False,
            "parse_time": "",
            "error_message": "",
        }
        if run_ir_syntax_check:
            result_row["ir_nested_issues_count"] = ""
            result_row["ir_issues_by_section"] = ""

        missing = [p for p in file_paths if not os.path.exists(p)]
        if missing:
            result_row["error_message"] = f"Template file(s) not found: {', '.join(missing)}"
            results.append(result_row)
            continue
        if not file_paths:
            result_row["error_message"] = "No template file paths specified"
            results.append(result_row)
            continue

        template_info = None
        parse_error = None
        parse_start = time.time()
        try:
            if template_language in ("cloudformation", "cfn"):
                parser = CloudFormationParser(file_paths[0])
                template_info = parser.parse()
            elif template_language in ("terraform", "tf", "hcl"):
                combined = "|".join(file_paths) if (is_grouped and len(file_paths) > 1) else file_paths[0]
                parser = TerraformParser(combined)
                template_info = parser.parse()
            elif template_language in ("arm", "azure"):
                parser = ARMParser(file_paths[0])
                template_info = parser.parse()
            elif template_language in ("bicep", "bicep_template"):
                parser = BicepParser(file_paths[0])
                template_info = parser.parse()
            else:
                parse_error = f"Unsupported template language: {template_language}"
        except Exception as e:
            parse_error = str(e)

        result_row["parse_time"] = str(round(time.time() - parse_start, 6))

        if parse_error:
            result_row["error_message"] = " ".join(parse_error.split())
            results.append(result_row)
            continue

        if template_info is None:
            result_row["error_message"] = "Parser returned None"
            results.append(result_row)
            continue

        result_row["compile_success"] = True

        if run_ir_syntax_check:
            try:
                from evaluation.ir_syntax_check import (
                    collect_nested_value_issues,
                    summarize_issues_by_section,
                )
                issues = collect_nested_value_issues(template_info)
                result_row["ir_nested_issues_count"] = str(len(issues))
                result_row["ir_issues_by_section"] = str(summarize_issues_by_section(issues))
            except Exception as e:
                result_row["ir_nested_issues_count"] = ""
                result_row["ir_issues_by_section"] = f"check_error: {e}"

        results.append(result_row)

    out_df = pd.DataFrame(results)
    try:
        out_df.to_csv(output_csv_path, index=False, encoding=OUTPUT_CSV_ENCODING)
        print(f"\n[INFO] Compile-only evaluation completed!")
        print(f"[INFO] Results saved to: {output_csv_path}")
        print(f"[INFO] Total templates processed: {len(results)}")
        success = (out_df["compile_success"] == True).sum()
        failed = len(results) - success
        print(f"[INFO] Compile success: {success}")
        print(f"[INFO] Compile failure: {failed}")
        print(f"[INFO] Compile success rate: {(success / len(results) * 100):.2f}%")
    except Exception as e:
        print(f"Error writing output CSV: {str(e)}")


def main():
    # input_csv_path = "data/terraform_eval.csv"   # IaC-Eval dataset
    # input_csv_path = "data/terraform_dataset_metadata.csv"   # Terraform collected dataset
    # input_csv_path = "data/condition_dataset.csv"   # 28 CFN condition templates dataset
    # input_csv_path = "data/DPIaC_Eval.csv"   # DPIaC-Eval dataset
    # input_csv_path = "data/iac-model-evaluation.csv"   # 56 CFN templates from AWS iac-model-evaluation dataset
    # input_csv_path = "data/aws-cloudformation-templates.csv"   # 149 CFN sample templates from AWS official repo
    # input_csv_path = "data/dataset_metadata.csv"   # dataset_metadata dataset
    # input_csv_path = "data/tf_dataset_grouped.csv"   # tf_dataset_grouped dataset
    # input_csv_path = "data/arm_dataset_metadata.csv"   # arm dataset
    # input_csv_path = "data/bicep_dataset_metadata_filtered.csv"   # bicep dataset
    # input_csv_path = "data/bicep_dataset_metadata_from_repo_filtered.csv"
    # New Dataset
    input_csv_path = "data/cloudformation_collected_templates_new/cfn_dataset_filtered.csv"   # CFN dataset that contain all valid templates
    # input_csv_path = "data/arm_collected_templates_new/arm_dataset_filtered.csv"   # ARM dataset that contain all valid templates
    # input_csv_path = "data/bicep_collected_templates_new/bicep_dataset_filtered.csv"   # Bicep dataset that contain all valid templates
    # input_csv_path = "data/bicep_collected_templates_new_module/bicep_dataset_filtered.csv"
    # input_csv_path = "data/terraform_collected_templates_new/terraform_dataset_filtered.csv"   # Terraform dataset that contain all valid templates
    # input_csv_path = "evaluation/cloudformation_fail_validation/output.csv"   # The parse failure dataset
    output_csv_path = "evaluation/dependency_graph_analysis_results_cfn_check.csv"
    # evaluate_dependency_graph_analysis(input_csv_path=input_csv_path, output_csv_path=output_csv_path)

    input_csv_path = "data/bicep_collected_templates_new/bicep_dataset_filtered.csv"   # Bicep dataset that contain all valid templates
    output_csv_path = "evaluation/dependency_graph_analysis_results_bicep_check.csv"
    evaluate_dependency_graph_analysis(input_csv_path=input_csv_path, output_csv_path=output_csv_path)

    input_csv_path = "data/arm_collected_templates_new/arm_dataset_filtered.csv"   # ARM dataset that contain all valid templates
    output_csv_path = "evaluation/dependency_graph_analysis_results_arm_check.csv"
    evaluate_dependency_graph_analysis(input_csv_path=input_csv_path, output_csv_path=output_csv_path)


    # input_csv_path = "data/terraform_collected_templates_new/terraform_dataset_filtered.csv"   # Terraform dataset that contain all valid templates
    # output_csv_path = "evaluation/dependency_graph_analysis_results_terraform_check.csv"
    # evaluate_dependency_graph_analysis(input_csv_path=input_csv_path, output_csv_path=output_csv_path)


    # Evaluate IR compilation only (source → IR)
    # input_csv_path = "D:/Personal Storage/1 - PhD/0_Projects/1_IR/code/evaluation/evaluation_methods/conversion_coverage/cfn_compile_failed_templates.csv"   # dataset_metadata dataset
    # evaluate_compile_only(input_csv_path=input_csv_path, run_ir_syntax_check=False, start_row=50, end_row=100)


if __name__ == "__main__":
    main()