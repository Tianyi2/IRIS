# networking.tf (Network Data Sources)

# -----------------------------------------------------------------------------
# --- VPC AND REGION DATA ---
# These data sources fetch information about the existing AWS environment
# rather than creating new resources.
# -----------------------------------------------------------------------------

# Finds the default VPC in the AWS account to be used by other resources if needed.
data "aws_vpc" "default" {
  default = true
}

# Gets the current AWS region.
data "aws_region" "current" {}