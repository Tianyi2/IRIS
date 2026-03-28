module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  for_each = {
    raw_bucket           = local.raw_bucket
    staging_bucket       = local.staging_bucket
    reporting_bucket     = local.reporting_bucket
    glueassets_bucket    = local.glueassets_bucket
    athenaresults_bucket = local.athenaresults_bucket
    airflow_bucket       = local.airflow_bucket
    dbt_bucket           = local.dbt_bucket
  }

  bucket        = each.value
  force_destroy = true
}