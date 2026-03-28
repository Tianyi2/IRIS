resource "aws_iam_instance_profile" "instance_profile" {
  name  = "${var.name}-profile"
  count = var.enabled ? 1 : 0
  role  = aws_iam_role.default_role[0].name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "default_role" {
  name               = "${var.name}-default_role"
  count              = var.enabled ? 1 : 0
  assume_role_policy = data.aws_iam_policy_document.default_role_assume[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "default_role_assume" {
  count = var.enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = ["s3.amazonaws.com"]
      type        = "Service"
    }
    dynamic "principals" {
      for_each = length(var.list_aws_arns) > 0 ? [1] : []
      content {
        type        = "AWS"
        identifiers = var.list_aws_arns
      }
    }
  }

}

resource "aws_iam_role_policy_attachment" "aws_policies" {
  count      = var.enabled ? length(var.aws_policies) : 0
  role       = aws_iam_role.default_role[0].id
  policy_arn = "arn:aws:iam::aws:policy/${element(var.aws_policies, count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}
