# outputs.tf (Project Outputs)

# This file defines the values that will be displayed after a successful
# `terraform apply`. They are useful for accessing important resource IDs or names.

output "s3_bucket_name" {
  value       = aws_s3_bucket.gg_analyzer_data.id
  description = "The name of the S3 bucket where all data is stored."
}

output "athena_database_name" {
  value       = aws_glue_catalog_database.game_data_db.name
  description = "The name of the AWS Glue Data Catalog database for Athena."
}

output "athena_workgroup_name" {
  value       = aws_athena_workgroup.primary.name
  description = "The name of the Athena workgroup for running queries."
}

output "popsql_user_access_key_id" {
  value       = aws_iam_access_key.popsql_user_key.id
  description = "The Access Key ID for the PopSQL IAM user."
}

output "popsql_user_secret_access_key" {
  value       = aws_iam_access_key.popsql_user_key.secret
  description = "The Secret Access Key for the PopSQL IAM user."
  sensitive   = true
}

output "powerbi_user_access_key_id" {
  value       = aws_iam_access_key.powerbi_user_key.id
  description = "The Access Key ID for the Power BI user."
}

output "powerbi_user_secret_access_key" {
  value       = aws_iam_access_key.powerbi_user_key.secret
  description = "The Secret Access Key for the Power BI user. Store this securely."
  sensitive   = true
}