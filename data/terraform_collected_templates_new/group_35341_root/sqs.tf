resource "aws_iam_role_policy" "sqs_allowall" {
  name   = "sqs_allowall"
  count  = var.sqs_allowall && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.sqs_allowall[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "sqs_allowall" {
  count = var.sqs_allowall && var.enabled ? 1 : 0

  statement {
    actions   = ["sqs:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}
