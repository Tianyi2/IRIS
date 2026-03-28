# glue.tf (AWS Glue Data Catalog Resources)

# -----------------------------------------------------------------------------
# --- GLUE DATABASE ---
# Creates a logical database in the AWS Glue Data Catalog to organize our tables.
# -----------------------------------------------------------------------------
resource "aws_glue_catalog_database" "game_data_db" {
  name = "gganalyzer_db"
}

# -----------------------------------------------------------------------------
# --- GLUE CRAWLER ---
# This crawler automatically scans the processed data in S3 and creates/updates
# a table schema in our Glue database, making the data queryable by Athena.
# -----------------------------------------------------------------------------
resource "aws_glue_crawler" "gganalyzer_crawler" {
  name          = "gganalyzer-crawler"
  role          = aws_iam_role.glue_crawler_role.arn # IAM role is in iam.tf
  database_name = aws_glue_catalog_database.game_data_db.name

  s3_target {
    path = "s3://${aws_s3_bucket.gg_analyzer_data.id}/processed-data/"
  }

  # This policy tells the crawler to update the table if new data adds new columns.
  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "LOG"
  }
}