
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      project           = var.project_name
      terraform_managed = "true"
    }
  }
}

provider "awscc" {
  region = var.region
}

terraform {
  required_version = "= 1.8.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66"
    }
    http = {
      version = "~> 3.4.2"
    }
    null = {
      version = "~> 3.2.2"
    }
    random = {
      version = "~> 3.6.1"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "1.6.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.0"
    }
  }
}