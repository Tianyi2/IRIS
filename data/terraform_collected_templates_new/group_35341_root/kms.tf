resource "aws_iam_role_policy" "kms_decrypt" {
  name   = "kms_decrypt"
  count  = var.kms_decrypt && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.kms_decrypt[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "kms_decrypt" {
  count = var.kms_decrypt && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = split(",", var.kms_decrypt_arns)

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:ReEncryptFrom",
    ]
  }
}

resource "aws_iam_role_policy" "kms_encrypt" {
  name   = "kms_encrypt"
  count  = var.kms_encrypt && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.kms_encrypt[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "kms_encrypt" {
  count = var.kms_encrypt && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = split(",", var.kms_encrypt_arns)

    actions = [
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:ReEncryptTo",
    ]
  }
}
