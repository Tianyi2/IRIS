# main.tf (Project Entry Point)

# --- TERRAFORM AND PROVIDER CONFIGURATION ---
# This single block defines the backend, required providers,
# and other core settings for Terraform.
terraform {
  # --- BACKEND CONFIGURATION ---
  # This tells Terraform to store its state file in the S3 bucket
  # and use the DynamoDB table for locking.
  backend "s3" {
    bucket         = "gg-analyzer-terraform-state-younis" # <-- Use the same unique name from backend.tf
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gganalyzer-terraform-state-lock"
    encrypt        = true
  }

  # --- PROVIDER REQUIREMENTS ---
  # Specifies the providers needed for this project.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/random"
    }
    http = {
      source = "hashicorp/http"
    }
  }
}

# --- DEFAULT AWS PROVIDER CONFIGURATION ---
# Configures the AWS provider, setting the default region for all resources.
provider "aws" {
  region = "us-east-1"
}