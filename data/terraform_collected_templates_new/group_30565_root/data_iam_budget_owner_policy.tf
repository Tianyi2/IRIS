data "aws_iam_policy_document" "budget_owner" {

  statement {

    effect = "Allow"
    actions = [
      "trustedadvisor:*",
      "cloudtrail:Get*",
      "cloudtrail:LookupEvents",
      "cloudtrail:Describe*",
      "s3:Get*",
      "budgets:*",
      "aws-portal:*",
      "cur:*"
    ]

    resources = [
		"*"
    ]
  }

}
