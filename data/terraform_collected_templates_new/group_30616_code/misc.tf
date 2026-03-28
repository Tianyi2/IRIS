data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

resource "random_string" "random" {
  length           = 6
  special          = false
  upper            = false
  override_special = "/@£$"
}

# Doesn't use special characters to avoid issues with DMS
resource "random_password" "password" {
  length      = 10
  special     = false
  min_numeric = 2
  min_upper   = 1
  min_lower   = 2
}