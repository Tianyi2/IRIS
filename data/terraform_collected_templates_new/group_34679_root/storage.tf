# storage.tf

# --- S3 BUCKET FOR THE DATA LAKE ---
resource "aws_s3_bucket" "gg_analyzer_data" {
  bucket = var.bucket_name
}