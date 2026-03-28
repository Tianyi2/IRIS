locals {
  raw_bucket           = "raw-${random_string.random.result}"
  staging_bucket       = "staging-${random_string.random.result}"
  reporting_bucket     = "reporting-${random_string.random.result}"
  athenaresults_bucket = "athenaresults-${random_string.random.result}"
  glueassets_bucket    = "glueassets-${random_string.random.result}"
  airflow_bucket       = "airflow-${random_string.random.result}"
  dbt_bucket           = "dbt-${random_string.random.result}"
  account_id           = data.aws_caller_identity.current.account_id
  azs                  = slice(data.aws_availability_zones.available.names, 0, 3)
  raw_bucket_prefix    = var.postgres_db

  # The following variables adjust the resources based on the chosen tpch_db_size
  postgres_allocated_storage = (
    var.tpch_db_size == "100GB" ? 250 :
    var.tpch_db_size == "3TB" ? 4500 :
    var.tpch_db_size == "10TB" ? 13000 : 100
  )
  # From 3TB on it needs instances without 30mn burst https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html
  postgres_db_instance = (
    var.tpch_db_size == "100GB" ? "db.m6g.xlarge" :
    var.tpch_db_size == "3TB" ? "db.m6g.4xlarge" :
    var.tpch_db_size == "10TB" ? "db.m6g.8xlarge" : "db.t3.small"
  )
  dms_max_capacity_units = (
    var.tpch_db_size == "100GB" ? 32 :
    var.tpch_db_size == "3TB" ? 64 :
    var.tpch_db_size == "10TB" ? 128 : 16
  )
  dms_instance = (
    var.tpch_db_size == "100GB" ? "dms.c4.xlarge" :
    var.tpch_db_size == "3TB" ? "dms.c4.2xlarge" :
    var.tpch_db_size == "10TB" ? "dms.c4.4xlarge" : "dms.t3.large"
  )
  glue_number_of_workers = (
    var.tpch_db_size == "100GB" ? 32 :
    var.tpch_db_size == "3TB" ? 64 :
    var.tpch_db_size == "10TB" ? 128 : 10
  )
  glue_worker_type = (
    var.tpch_db_size == "100GB" ? "G.2X" :
    var.tpch_db_size == "3TB" ? "G.4X" :
    var.tpch_db_size == "10TB" ? "G.8X" : "G.1X"
  )
  postgres_max_parallel = (
    var.tpch_db_size == "100GB" ? 16 :
    var.tpch_db_size == "3TB" ? 32 :
    var.tpch_db_size == "10TB" ? 64 : 8
  )
  postgres_storage_throughput = (
    var.tpch_db_size == "100GB" ? null :
    var.tpch_db_size == "3TB" ? 800 :
    var.tpch_db_size == "10TB" ? 1600 : null
  )
  postgres_iops = (
    var.tpch_db_size == "100GB" ? null :
    var.tpch_db_size == "3TB" ? 12000 :
    var.tpch_db_size == "10TB" ? 24000 : null
  )
}