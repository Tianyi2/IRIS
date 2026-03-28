resource "aws_iam_policy" "business_owner" {
  name        = "business_owner_group_policy"
  description = "An IAM group policy for Business owners"
  policy      = data.aws_iam_policy_document.business_owner.json
}

resource "aws_iam_policy" "budget_owner" {
  name        = "budget_owner_group_policy"
  description = "An IAM group policy for Budget owners"
  policy      = data.aws_iam_policy_document.budget_owner.json
}

resource "aws_iam_policy" "frontend_developer" {
  name        = "front_end_developer_group_policy"
  description = "An IAM group policy for Front End developers"
  policy      = data.aws_iam_policy_document.frontend_developer.json
}

resource "aws_iam_policy" "backend_developer" {
  name        = "backend_developer_group_policy"
  description = "An IAM group policy for Backend developers"
  policy      = data.aws_iam_policy_document.backend_developer.json
}

resource "aws_iam_policy" "oso_devops_engineer" {
  name        = "oso-devops-engineer-group-policy"
  description = "An IAM group policy for OSO DevOps Engineers"
  policy      = data.aws_iam_policy_document.oso_devops_engineer.json
}

resource "aws_iam_policy" "oso_devops_support" {
  name        = "oso-devops-support-group-policy"
  description = "An IAM group policy for the OSO Support Engineers"
  policy      = data.aws_iam_policy_document.oso_devops_support.json
}

resource "aws_iam_policy" "enforce_mfa" {
  name        = "enforce_mfa_group_policy"
  description = "An IAM group policy that enforces the use of MFA for all users"
  policy      = data.aws_iam_policy_document.iam_enforce_mfa.json
}

resource "aws_iam_policy" "no_access" {
  name        = "no-access-policy"
  description = "This user group have no access to AWS"
  policy      = data.aws_iam_policy_document.no_access.json
}