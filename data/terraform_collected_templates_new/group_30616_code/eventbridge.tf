module "eventbridge" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "3.11.0"

  create_bus = false

  rules = {
    glue = {
      description = "Capture failed Glue events"
      event_pattern = jsonencode({
        "source" : ["aws.glue"],
        "detail-type" : ["Glue Job State Change"],
        "detail" : {
          "state" : ["FAILED", "ERROR"]
        }
      })
      state = "ENABLED"
    }
  }

  targets = {
    glue = [
      {
        name = "sns"
        arn  = module.sns.arn
      }
    ]
  }

  attach_sns_policy = true
  sns_target_arns = [
    module.sns.arn
  ]
}