# backend.tf (S3 Bucket and DynamoDB Table for Terraform State)

# --- S3 BUCKET FOR TERRAFORM STATE ---
# This bucket will store the terraform.tfstate file remotely.
resource "aws_s3_bucket" "terraform_state" {
  bucket = "gg-analyzer-terraform-state-younis" # <-- Use the same unique name you chose

  # Prevents accidental deletion of the state file.
  lifecycle {
    prevent_destroy = true
  }
}

# --- BUCKET SETTINGS (APPLIED SEPARATELY) ---

# Enables versioning to keep a history of state files.
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Encrypts the state file at rest.
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_sse" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# --- DYNAMODB TABLE FOR STATE LOCKING ---
# This table prevents multiple people from running `terraform apply` at the same time.
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "gganalyzer-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}