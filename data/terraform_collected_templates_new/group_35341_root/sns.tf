resource "aws_iam_role_policy" "sns_allowall" {
  name   = "sns_allowall"
  count  = var.sns_allowall && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.sns_allowall[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "sns_allowall" {
  count = var.sns_allowall && var.enabled ? 1 : 0

  statement {
    actions   = ["sns:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}
