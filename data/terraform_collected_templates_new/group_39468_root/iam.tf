#-----------------------------------------------------------------------------------------------------------------------
# CodeBuild用IAMロール
#-----------------------------------------------------------------------------------------------------------------------
# Assume Role
data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

# IAM Role
resource "aws_iam_role" "codebuild_iam_role" {
  name               = local.codebuild_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json

  tags = {
    Name = "${local.codebuild_iam_role_name}"
  }
}

# IAM Policy
data "aws_iam_policy_document" "codebuild_iam_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${local.codebuild_log_group_name}",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${local.codebuild_log_group_name}:*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]
    resources = [
      "${aws_codebuild_project.codecommit_pages_proj.arn}",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      "${aws_s3_bucket.bucket.arn}",
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "codecommit:GitPull"
    ]
    resources = [
      "${aws_codecommit_repository.codecommit_pages.arn}",
    ]
  }
}

resource "aws_iam_policy" "codebuild_iam_policy" {
  name   = local.codebuild_iam_policy_name
  path   = "/"
  policy = data.aws_iam_policy_document.codebuild_iam_policy.json

  tags = {
    Name = "${local.codebuild_iam_policy_name}"
  }
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  for_each = {
    codebuild = "${aws_iam_policy.codebuild_iam_policy.arn}",
  }

  role       = aws_iam_role.codebuild_iam_role.name
  policy_arn = each.value
}

#-----------------------------------------------------------------------------------------------------------------------
# EventBridge用IAMロール
#-----------------------------------------------------------------------------------------------------------------------
# Assume Role
data "aws_iam_policy_document" "eventbridge_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

# IAM Role
resource "aws_iam_role" "eventbridge_iam_role" {
  name               = local.eventbridge_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_role_policy.json

  tags = {
    Name = "${local.eventbridge_iam_role_name}"
  }
}

# IAM Policy
data "aws_iam_policy_document" "eventbridge_iam_policy" {
  statement {
    effect = "Allow"
    actions = [
      "codebuild:StartBuild",
    ]
    resources = [
      "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:project/${local.codebuild_proj_name}",
    ]
  }
}

resource "aws_iam_policy" "eventbridge_iam_policy" {
  name   = local.eventbridge_iam_policy_name
  path   = "/"
  policy = data.aws_iam_policy_document.eventbridge_iam_policy.json

  tags = {
    Name = "${local.eventbridge_iam_policy_name}"
  }
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "eventbridge_policy_attachment" {
  for_each = {
    codebuild = "${aws_iam_policy.eventbridge_iam_policy.arn}",
  }

  role       = aws_iam_role.eventbridge_iam_role.name
  policy_arn = each.value
}
