data "aws_organizations_policy" "pike" {
  policy_id = aws_organizations_policy.example.id
}

data "aws_iam_policy_document" "example" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_organizations_policy" "example" {
  name    = "example"
  content = data.aws_iam_policy_document.example.json
}
