resource "aws_iam_role_policy" "s3_readonly" {
  name   = var.s3_readonly_name
  count  = var.s3_readonly && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.s3_readonly[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "s3_readonly" {
  count = var.s3_readonly && var.enabled ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = flatten([
      formatlist("arn:aws:s3:::%v", var.s3_read_buckets),
      formatlist("arn:aws:s3:::%v/*", var.s3_read_buckets),
    ])
  }
}

resource "aws_iam_role_policy" "s3_write" {
  name   = var.s3_write_name
  count  = var.s3_write && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.s3_write[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "s3_write" {
  count = var.s3_write && var.enabled ? 1 : 0

  statement {
    actions = ["s3:*"]
    effect  = "Allow"

    resources = flatten([
      formatlist("arn:aws:s3:::%v", var.s3_write_buckets),
      formatlist("arn:aws:s3:::%v/*", var.s3_write_buckets),
    ])
  }
}

resource "aws_iam_role_policy" "s3_writeonly" {
  name   = var.s3_writeonly_name
  count  = var.s3_writeonly && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.s3_writeonly[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "s3_writeonly" {
  count = var.s3_writeonly && var.enabled ? 1 : 0

  statement {
    actions = ["s3:Put*"]
    effect  = "Allow"

    resources = flatten([
      formatlist("arn:aws:s3:::%v", var.s3_writeonly_buckets),
      formatlist("arn:aws:s3:::%v/*", var.s3_writeonly_buckets),
    ])
  }
}
