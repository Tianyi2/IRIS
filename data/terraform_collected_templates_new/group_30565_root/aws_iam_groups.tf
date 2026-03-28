resource "aws_iam_group" "business_owner" {
  name = "Business_Owner"
}

resource "aws_iam_group" "budget_owner" {
  name = "Budget_Owner"
}

resource "aws_iam_group" "front_end_developer" {
  name = "FrontEnd_Developer"
}

resource "aws_iam_group" "backend_developer" {
  name = "BackEnd_Developer"
}

resource "aws_iam_group" "oso_devops_engineer" {
  name = "OSO_DevOps_Engineering"
}

resource "aws_iam_group" "oso_devops_support" {
  name = "OSO_DevOps_Support"
}

resource "aws_iam_group" "read_only" {
  name = "Read_Only_Users"
}

resource "aws_iam_group" "enforce_mfa" {
  name = "Enforce_MFA"
}

resource "aws_iam_group" "no_access" {
  name = "No_Access_Users"
}