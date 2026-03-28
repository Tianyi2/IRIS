#-----------------------------------------------------------------------------------------------------------------------
# EventBridge
#-----------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "codecommit_pages" {
  name        = local.eventbridge_iam_rule_name
  description = local.eventbridge_iam_rule_name

  event_pattern = jsonencode({
    "source" : ["aws.codecommit"],
    "resources" : ["${aws_codecommit_repository.codecommit_pages.arn}"],
    "detail" : {
      "event" : [
        "referenceCreated",
        "referenceUpdated"
      ],
      "referenceName" : ["${local.codecommit_branch_name}"]
    }
  })
}

resource "aws_cloudwatch_event_target" "codecommit_pages" {
  rule      = aws_cloudwatch_event_rule.codecommit_pages.name
  target_id = "ExecuteCodeBuild"
  arn       = aws_codebuild_project.codecommit_pages_proj.arn
  role_arn  = aws_iam_role.eventbridge_iam_role.arn
}
