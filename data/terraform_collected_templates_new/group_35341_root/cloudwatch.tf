resource "aws_iam_role_policy" "cloudwatch_readonly" {
  name   = "cloudwatch_readonly"
  count  = var.cw_readonly && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.cloudwatch_readonly[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "cloudwatch_readonly" {
  count = var.cw_readonly && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudwatch:Get*",
      "cloudwatch:List*",
    ]
  }
}

resource "aws_iam_role_policy" "cloudwatch_update" {
  name   = "cloudwatch_update"
  count  = var.cw_update && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.cloudwatch_update[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "cloudwatch_update" {
  count = var.cw_update && var.enabled ? 1 : 0

  statement {
    actions = [
      "cloudwatch:Put*",
      "cloudwatch:DeleteAlarms"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "cloudwatch_logs_update" {
  name   = "cloudwatch_logs_update"
  count  = var.cw_logs_update && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.cloudwatch_logs_update[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "cloudwatch_logs_update" {
  count = var.cw_logs_update && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudwatch:PutMetricData",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
    ]
  }
}
