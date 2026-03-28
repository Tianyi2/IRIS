resource "aws_iam_role_policy" "kinesis_streams" {
  name   = "kinesis_streams"
  count  = var.kinesis_streams && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.kinesis_streams[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "kinesis_streams" {
  count = var.kinesis_streams && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:PutRecord",
      "kinesis:PutRecords",
    ]
  }
}
