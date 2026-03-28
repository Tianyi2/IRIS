resource "aws_iam_role_policy" "redshift_read" {
  name   = "redshift_read"
  count  = var.redshift_read && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.redshift_read[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "redshift_read" {
  count = var.redshift_read && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "redshift:Describe*",
      "redshift:ViewQueriesInConsole",
      "sns:Get*",
      "sns:List*",
    ]
  }
}
