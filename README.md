# IRIS

`IRIS` is a Unified **IR** for **I**aC code **S**mell detection across multiple IaC languages (CloudFormation, Terraform, Azure Resource Manager, and Bicep).  
This repository contains the code for the IRIS analysis pipeline and IaC datasets for the four IaC languages.

The project focuses on two main goals:

- constructing a reproducible multi-language IaC dataset from GitHub (CloudFormation, ARM, Bicep, and Terraform), and
- parsing templates into an intermediate representation (IR) and running static analyses (for example dependency, condition, and security analyses).

## What This Project Does

- **Template parsing**: parses IaC templates into a normalized representation that can be analyzed across languages.
- **Static analysis**: builds dependency graphs and runs analyses such as dead resources, circular dependencies, no-sourced outputs/conditions, and secret-related checks.
- **Dataset construction**: collects repositories/templates via GitHub APIs, applies filtering rules, and exports reproducible CSV metadata.
- **Evaluation artifacts**: includes scripts and result files used to evaluate parser/analysis behavior on collected templates.

## Repository Structure

- `code/`: core implementation of parsing, analysis, and evaluation.
  - `code/parsers/`: language-specific parsers (`cloudformation`, `terraform`, `arm`, `bicep`).
  - `code/analysis/`: dependency graph builder and static analysis modules.
  - `code/evaluation/`: evaluation scripts, ontology files, and result outputs.
  - `code/config/`: configuration modules (for example sensitive settings/constants).
  - `code/results/`: generated analysis artifacts (JSON/CSV outputs).
- `data/`: dataset creation scripts and collected template corpora.
  - `data/dataset_construction.py`: end-to-end GitHub collection/filtering pipeline.
  - `data/search_queries.py`: reproducible query definitions and validation rules.
  - `data/*_collected_templates_new/`: collected templates grouped by IaC language.
- `figure/`: sample IaC templates used as motivation for the project (`.tf` and CloudFormation `.yaml`).
- `requirement.txt`: Python dependency list used by the scripts in this package.
- `README.md`: top-level project documentation.

## Getting Started

1. Create and activate a Python environment (recommended).
2. Install dependencies:
  `pip install -r requirement.txt`
3. Add any required credentials (for example GitHub token/API keys) in your local config files or environment variables.
4. Run scripts from `data/` for dataset collection and from `code/evaluation/` for analysis/evaluation workflows.

## Note
- Please use a new virtual environment for running evaluation on other static analysis tools. Checkov depends on some libraries that conflict with the IR parser.

## License

This project is released under Apache License 2.0. For commercial collaborations, enterprise use, or licensing inquiries, please contact `tianyi2332@163.com`.

## Contribution

Submit a PR if you want to contribute to the project.

If you find bugs, issues, or have suggestions, please share them via GitHub Issues.

## Acknowledgments

- [GLITCH](https://github.com/sr-lab/GLITCH): A tool for security smell for multiple-IaC languages (Ansible, Chef, Puppet, Docker, Terraform).

