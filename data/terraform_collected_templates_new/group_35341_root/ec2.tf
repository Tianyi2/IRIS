resource "aws_iam_role_policy" "ec2_describe" {
  name   = "ec2_describe"
  count  = var.ec2_describe && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.ec2_describe[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ec2_describe" {
  count = var.ec2_describe && var.enabled ? 1 : 0

  statement {
    actions   = ["ec2:Describe*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "recover_volume" {
  count = var.recover_volume && var.enabled ? 1 : 0
  statement {
    actions = [
      "ec2:CreateVolume",
      "ec2:DescribeSnapshots",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeVolumes",
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:CreateTags"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "recover_volume" {
  name   = "recover_volume"
  count  = var.recover_volume && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.recover_volume[0].json

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy" "ec2_attach" {
  name   = "ec2_attach"
  count  = var.ec2_attach && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.ec2_attach[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ec2_attach" {
  count = var.ec2_attach && var.enabled ? 1 : 0

  statement {
    actions   = ["ec2:Attach*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ec2_ebs_attach" {
  name   = "ec2_ebs_attach"
  count  = var.ec2_ebs_attach && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.ec2_ebs_attach[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ec2_ebs_attach" {
  count = var.ec2_ebs_attach && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AttachVolume",
      "ec2:DescribeVolume",
    ]
  }
}

resource "aws_iam_role_policy" "ec2_eni_attach" {
  name   = "ec2_eni_attach"
  count  = var.ec2_eni_attach && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.ec2_eni_attach[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ec2_eni_attach" {
  count = var.ec2_eni_attach && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AttachNetworkInterface",
      "ec2:DescribeNetworkInterfaceAttribute",
      "ec2:DescribeNetworkInterfaces",
      "ec2:ModifyNetworkInterfaceAttribute",
    ]
  }
}

resource "aws_iam_role_policy" "ec2_write_tags" {
  name   = "ec2_write_tags"
  count  = var.ec2_write_tags && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.ec2_write_tags[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ec2_write_tags" {
  count = var.ec2_write_tags && var.enabled ? 1 : 0

  statement {
    actions   = ["ec2:CreateTags"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ec2_assign_private_ip" {
  name   = "ec2_assign_private_ip"
  count  = var.ec2_assign_private_ip && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.ec2_assign_private_ip[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ec2_assign_private_ip" {
  count = var.ec2_assign_private_ip && var.enabled ? 1 : 0

  statement {
    actions   = ["ec2:AssignPrivateIpAddresses"]
    effect    = "Allow"
    resources = ["*"]
  }
}
