resource "aws_iam_role_policy" "transcribe_fullaccess" {
  name   = "transcribe_fullaccess"
  count  = var.transcribe_fullaccess && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.transcribe_fullaccess[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "transcribe_fullaccess" {
  count = var.transcribe_fullaccess && var.enabled ? 1 : 0

  statement {
    actions   = ["transcribe:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}
