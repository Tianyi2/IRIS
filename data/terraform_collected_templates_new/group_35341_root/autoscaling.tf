resource "aws_iam_role_policy" "autoscaling_describe" {
  name   = "autoscaling_describe"
  count  = var.autoscaling_describe && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.autoscaling_describe[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "autoscaling_describe" {
  count = var.autoscaling_describe && var.enabled ? 1 : 0

  statement {
    actions   = ["autoscaling:Describe*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "autoscaling_update" {
  name   = "autoscaling_update"
  count  = var.autoscaling_update && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.autoscaling_update[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "autoscaling_update" {
  count = var.autoscaling_update && var.enabled ? 1 : 0

  statement {
    actions   = ["autoscaling:UpdateAutoScalingGroup"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "autoscaling_suspend_resume" {
  name   = "autoscaling_suspend_resume"
  count  = var.autoscaling_suspend_resume && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.autoscaling_suspend_resume[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "autoscaling_suspend_resume" {
  count = var.autoscaling_suspend_resume && var.enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:ResumeProcesses",
      "autoscaling:SuspendProcesses",
    ]
  }
}

resource "aws_iam_role_policy" "autoscaling_terminate_instance" {
  name   = "autoscaling_terminate_instance"
  count  = var.autoscaling_terminate_instance && var.enabled ? 1 : 0
  role   = aws_iam_role.default_role[0].id
  policy = data.aws_iam_policy_document.autoscaling_terminate_instance[0].json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "autoscaling_terminate_instance" {
  count = var.autoscaling_terminate_instance && var.enabled ? 1 : 0

  statement {
    actions   = ["autoscaling:TerminateInstanceInAutoScalingGroup"]
    effect    = "Allow"
    resources = ["*"]
  }
}
