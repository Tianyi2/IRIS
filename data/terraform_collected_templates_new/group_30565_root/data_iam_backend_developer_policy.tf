data "aws_iam_policy_document" "backend_developer" {

  statement {

    effect = "Allow"
    actions = [
        "s3:*",
        "sns:*",
        "sqs:*",
        "ssm:*",
        "cloudfront:*",
        "ec2:*",
        "lambda:*",
        "rds:*",
        "dynamodb:*",
        "cloudwatch:*",
        "es:*",
        "logs:*",
        "apigateway:*",
        "kms:*",
        "elasticloadbalancing:*",
        "acm:*",
        "autoscaling:*",
        "sts:*",
        "ses:*",
        "cognito:*",
        "kinesis:*",
        "firehose:*",
        "waf:*",
        "xray:*",
        "states:*",
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
      "s3:DeleteBucket"
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
       "rds:DeleteDBCluster",
       "rds:DeleteDBInstance"
    ]
    resources = [
      "*"
    ]
  }

  statement {

    effect = "Deny"
    actions = [
      "elasticloadbalancing:DeleteLoadBalancer"
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
      "cloudfront:DeleteDistribution"
    ]
    resources = [
      "*"
    ]
  }
}
