module "step_function_etl_pipeline" {
  source  = "terraform-aws-modules/step-functions/aws"
  version = "4.2.0"

  name    = "etl_pipeline"
  type    = "Standard"
  publish = true

  definition = <<EOF
{
  "Comment": "A description of my state machine",
  "StartAt": "Run ${aws_glue_job.jobs["${aws_glue_job.jobs["raw_to_staging.py"].name}.py"].name}",
  "States": {
    "Run ${aws_glue_job.jobs["raw_to_staging.py"].name}": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "${aws_glue_job.jobs["raw_to_staging.py"].name}"
      },
      "Next": "Get ${aws_glue_job.jobs["raw_to_staging.py"].name}"
    },
    "Get ${aws_glue_job.jobs["raw_to_staging.py"].name}": {
      "Type": "Task",
      "Parameters": {
        "JobName": "${aws_glue_job.jobs["raw_to_staging.py"].name}",
        "RunId.$": "$.Id"
      },
      "Resource": "arn:aws:states:::aws-sdk:glue:getJobRun",
      "Next": "Choice0"
    },
    "Choice0": {
      "Type": "Choice",
      "Choices": [
        {
          "Or": [
            {
              "Variable": "$.JobRun.JobRunState",
              "StringEquals": "FAILED"
            },
            {
              "Variable": "$.JobRun.JobRunState",
              "StringEquals": "ERROR"
            }
          ],
          "Next": "SNS alerts"
        }
      ],
      "Default": "Run ${aws_glue_job.jobs["c_order_agg.py"].name}"
    },
    "Run ${aws_glue_job.jobs["c_order_agg.py"].name}": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "${aws_glue_job.jobs["c_order_agg.py"].name}"
      },
      "Next": "Get ${aws_glue_job.jobs["c_order_agg.py"].name}"
    },
    "Get ${aws_glue_job.jobs["c_order_agg.py"].name}": {
      "Type": "Task",
      "Parameters": {
        "JobName": "${aws_glue_job.jobs["c_order_agg.py"].name}",
        "RunId.$": "$.Id"
      },
      "Resource": "arn:aws:states:::aws-sdk:glue:getJobRun",
      "Next": "Choice1"
    },
    "Choice1": {
      "Type": "Choice",
      "Choices": [
        {
          "Or": [
            {
              "Variable": "$.JobRun.JobRunState",
              "StringEquals": "FAILED"
            },
            {
              "Variable": "$.JobRun.JobRunState",
              "StringEquals": "ERROR"
            }
          ],
          "Next": "SNS alerts"
        }
      ],
      "Default": "Pass"
    },
    "Pass": {
      "Type": "Pass",
      "Next": "Success"
    },
    "Success": {
      "Type": "Succeed"
    },
    "SNS alerts": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sns:publish",
      "Parameters": {
        "TopicArn": "${module.sns.arn}",
        "Message.$": "$"
      },
      "Next": "Fail"
    },
    "Fail": {
      "Type": "Fail"
    }
  }
}
EOF

  logging_configuration = {
    include_execution_data = true
    level                  = "OFF"
  }

  attach_policies    = true
  policies           = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole", aws_iam_policy.glue.arn]
  number_of_policies = 3

  attach_policy_statements = true
  policy_statements = {
    sns = {
      effect    = "Allow",
      actions   = ["sns:Publish"],
      resources = [module.sns.arn]
    }
  }
}

module "step_function_optimize_iceberg" {
  source  = "terraform-aws-modules/step-functions/aws"
  version = "4.2.0"

  name    = "optimize_iceberg"
  type    = "Standard"
  publish = true

  definition = <<EOF
{
  "Comment": "A description of my state machine",
  "StartAt": "Run ${aws_glue_job.jobs["optimize_iceberg.py"].name}",
  "States": {
    "Run ${aws_glue_job.jobs["optimize_iceberg.py"].name}": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "${aws_glue_job.jobs["optimize_iceberg.py"].name}"
      },
      "Next": "Get ${aws_glue_job.jobs["optimize_iceberg.py"].name}"
    },
    "Get ${aws_glue_job.jobs["optimize_iceberg.py"].name}": {
      "Type": "Task",
      "Parameters": {
        "JobName": "${aws_glue_job.jobs["optimize_iceberg.py"].name}",
        "RunId.$": "$.Id"
      },
      "Resource": "arn:aws:states:::aws-sdk:glue:getJobRun",
      "Next": "Choice"
    },
    "Choice": {
      "Type": "Choice",
      "Choices": [
        {
          "Or": [
            {
              "Variable": "$.JobRun.JobRunState",
              "StringEquals": "FAILED"
            },
            {
              "Variable": "$.JobRun.JobRunState",
              "StringEquals": "ERROR"
            }
          ],
          "Next": "SNS alerts"
        }
      ],
      "Default": "Pass"
    },
    "Pass": {
      "Type": "Pass",
      "Next": "Success"
    },
    "Success": {
      "Type": "Succeed"
    },
    "SNS alerts": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sns:publish",
      "Parameters": {
        "TopicArn": "${module.sns.arn}",
        "Message.$": "$"
      },
      "Next": "Fail"
    },
    "Fail": {
      "Type": "Fail"
    }
  }
}
EOF

  logging_configuration = {
    include_execution_data = true
    level                  = "OFF"
  }

  attach_policies    = true
  policies           = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole", aws_iam_policy.glue.arn]
  number_of_policies = 3

  attach_policy_statements = true
  policy_statements = {
    sns = {
      effect    = "Allow",
      actions   = ["sns:Publish"],
      resources = [module.sns.arn]
    }
  }
}