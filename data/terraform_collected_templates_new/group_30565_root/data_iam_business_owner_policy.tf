data "aws_iam_policy_document" "business_owner" {

  statement {

    effect = "Allow"
    actions = [
      "*"
    ]
    resources = [
      "*"
    ]
  }
}
