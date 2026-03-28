# athena.tf (Amazon Athena Resources)

# -----------------------------------------------------------------------------
# --- ATHENA WORKGROUP ---
# Sets up a workgroup for running Athena queries. This isolates our queries
# and specifies where to store query results in S3.
# -----------------------------------------------------------------------------
resource "aws_athena_workgroup" "primary" {
  name = "gganalyzer_workgroup"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.gg_analyzer_data.id}/query-results/"
    }
  }
}