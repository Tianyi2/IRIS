resource "aws_iam_role_policy" "es_allowall" {
  name   = "es_allowall"
  count  = var.es_allowall && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.es_allowall[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "es_allowall" {
  count = var.es_allowall && var.enabled ? 1 : 0

  statement {
    actions   = ["es:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "es_write" {
  name   = "es_write"
  count  = var.es_write && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.es_write[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "es_write" {
  count = var.es_write && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "es:ESHttpDelete",
      "es:ESHttpGet",
      "es:ESHttpHead",
      "es:ESHttpPost",
      "es:ESHttpPut",
    ]
  }
}
