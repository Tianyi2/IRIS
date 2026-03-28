resource "aws_iam_role_policy" "elasticache_readonly" {
  name   = "elasticache_readonly"
  count  = var.elasticache_readonly && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.elasticache_readonly[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "elasticache_readonly" {
  count = var.elasticache_readonly && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticache:Describe*",
      "elasticache:ListTagsForResource"
    ]
  }
}
