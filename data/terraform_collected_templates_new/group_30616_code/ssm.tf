resource "aws_ssm_parameter" "glue_config" {
  data_type   = "text"
  description = "This parameter stores the curated bucket name to be used by the Glue job"
  name        = "glue-config"
  tier        = "Standard"
  type        = "String"
  value = templatefile("resources/configs/glue_config.tpl",
    {
      raw_bucket        = module.s3_bucket["raw_bucket"].s3_bucket_id
      raw_bucket_prefix = local.raw_bucket_prefix
      staging_bucket    = module.s3_bucket["staging_bucket"].s3_bucket_id
      reporting_bucket  = module.s3_bucket["reporting_bucket"].s3_bucket_id
      warehouse_url     = "s3://${module.s3_bucket["glueassets_bucket"].s3_bucket_id}/warehouse"
  })
}

resource "aws_ssm_parameter" "glue_tables" {
  data_type   = "text"
  description = "This parameter stores the warehouse path to be used by Glue job"
  name        = "glue-tables"
  tier        = "Standard"
  type        = "String"
  value       = file("resources/configs/glue_tables.json")
}