resource "aws_iam_role_policy" "sts_assumerole" {
  count  = var.sts_assumerole && var.enabled ? 1 : 0
  name   = "sts_assumerole"
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.sts_assumerole[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "sts_assumerole" {
  count = var.sts_assumerole && var.enabled ? 1 : 0

  statement {
    actions   = ["sts:AssumeRole"]
    effect    = "Allow"
    resources = var.sts_assumeroles
  }
}
