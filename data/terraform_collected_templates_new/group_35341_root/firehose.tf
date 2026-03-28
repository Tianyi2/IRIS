resource "aws_iam_role_policy" "firehose_streams" {
  name   = "firehose_streams"
  count  = var.firehose_streams && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.firehose_streams[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "firehose_streams" {
  count = var.firehose_streams && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = var.firehose_stream_arns

    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]
  }
}
