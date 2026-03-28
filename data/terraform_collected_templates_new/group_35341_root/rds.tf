resource "aws_iam_role_policy" "rds_readonly" {
  name   = "rds_readonly"
  count  = var.rds_readonly && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.rds_readonly[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "rds_readonly" {
  count = var.rds_readonly && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "rds:Describe*",
      "rds:List*",
    ]
  }
}
