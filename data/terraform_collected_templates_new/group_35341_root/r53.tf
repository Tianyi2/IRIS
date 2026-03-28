resource "aws_iam_role_policy" "r53_update" {
  name   = "r53_update"
  count  = var.r53_update && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.r53_update[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "r53_update" {
  count = var.r53_update && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:Get*",
      "route53:List*",
    ]
  }
}
