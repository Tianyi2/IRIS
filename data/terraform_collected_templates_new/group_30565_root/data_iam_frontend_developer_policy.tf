data "aws_iam_policy_document" "frontend_developer" {

  statement {

    effect = "Allow"
    actions = [
        "acm:*",
        "s3:*",
        "sns:*",
        "ec2:*",
        "cloudfront:*",
        "route53:*",
        "cloudwatch:*",
        "logs:*",
        "elasticloadbalancing:*",
        "lambda:*",
        "sts:*",
        "ses:*",
        "kms:*",
        "waf:*",
        "xray:*"
    ]

    resources = [
		"*"
    ]
  }

  statement {
    effect = "Deny"
    actions = [
      "kms:RetireGrant",
      "kms:RevokeGrant",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:DisableKey",
      "kms:Delete*"
    ]
    resources = [
      "*"
    ]

  }

  statement {

    effect = "Deny"
    actions = [
      "route53:DeleteHealthCheck",
      "route53:DeleteHostedZone",
      "route53:DeleteTrafficPolicy"
    ]
    resources = [
      "*"
    ]
  }

  statement {

    effect = "Deny"
    actions = [
      "lambda:DeleteFunction"
    ]
    resources = [
      "*"
    ]
    }

  statement {

    effect = "Deny"
    actions = [
      "ec2:StopInstances",
      "ec2:TerminateInstances"
    ]
    resources = [
      "*"
    ]
  }

  statement {

    effect = "Deny"
    actions = [
      "cloudfront:DeleteDistribution"
    ]
    resources = [
      "*"
    ]
  }

  statement {

    effect = "Deny"
    actions = [
      "s3:DeleteBucket"
    ]
    resources = [
      "*"
    ]
  }
}
