## Folder Structure

- `search_queries.py`: reproducible query definitions and validation rules.
- `*_collected_templates_new/`: collected templates grouped by IaC language.
  - `dataset_metadata.csv`: the complete dataset after collection, without filtering applied.
  - `*_dataset_filtered.csv`: the dataset used for evaluation with filtering applied.
  - `*_dataset_valdiation_result.csv`: the dataset with filtering information record.
  - `*_dataset_valdiation_result_summary.csv`: the summary for the dataset filtering result.
- `oracle/`: the oracle dataset for the four IaC languages
  - `oracle_dataset_*.csv`: the oracle dataset for each IaC language.
  - `ground_truth/`: the folder to store the ground_truth information for each IaC language.
- `dataset_construction.py`: end-to-end GitHub collection pipeline.
- `search_queries.py`: the search queries used.
- `dataset_filtering.ipynb`: dataset filtering pipeline.

