resource "aws_mwaa_environment" "airflow" {
  name                  = "airflow"
  environment_class     = "mw1.medium"
  airflow_version       = "2.9.2"
  webserver_access_mode = "PUBLIC_ONLY"
  execution_role_arn    = aws_iam_role.airflow.arn
  source_bucket_arn     = module.s3_bucket["airflow_bucket"].s3_bucket_arn
  dag_s3_path           = "dags/"

  # Force two workers to avoid scaling up/down
  min_workers = 2
  max_workers = 2

  # The next two are required by DBT
  requirements_s3_path   = aws_s3_object.mwaa_requirements.key
  startup_script_s3_path = aws_s3_object.mwaa_startup.key

  logging_configuration {
    dag_processing_logs {
      enabled   = true
      log_level = "DEBUG"
    }

    scheduler_logs {
      enabled   = true
      log_level = "INFO"
    }

    task_logs {
      enabled   = true
      log_level = "WARNING"
    }

    webserver_logs {
      enabled   = true
      log_level = "ERROR"
    }

    worker_logs {
      enabled   = true
      log_level = "CRITICAL"
    }
  }

  network_configuration {
    security_group_ids = [module.security_group_airflow.security_group_id]
    subnet_ids         = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  }
}

module "security_group_airflow" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "airflow"
  description = "Security group for Airflow"
  vpc_id      = module.vpc.vpc_id

  # This is mandatory for the service to properly boot up - can be restricted to 443/tcp and 5432/tcp
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "internal"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# Inject in MWAA as a variable the SNS topic
resource "null_resource" "airflow_sns" {

  triggers = {
    mwaa_name      = aws_mwaa_environment.airflow.name,
    mwaa_host      = aws_mwaa_environment.airflow.webserver_url,
    mwaa_region    = var.region,
    variable_key   = "SNS_TOPIC",
    variable_value = module.sns.arn
  }

  provisioner "local-exec" {

    // zsh is required for curl to work 
    interpreter = ["zsh", "-c"]

    command = templatefile("${path.module}/resources/scripts/mwaa_addvariable.sh", {
      mwaa_name      = aws_mwaa_environment.airflow.name,
      mwaa_host      = aws_mwaa_environment.airflow.webserver_url,
      mwaa_region    = var.region,
      variable_key   = "SNS_TOPIC",
      variable_value = module.sns.arn
    })
  }
}

resource "aws_s3_object" "mwaa_requirements" {
  bucket = module.s3_bucket["airflow_bucket"].s3_bucket_id
  key    = "requirements.txt"
  source = "${path.module}/resources/mwaa/requirements.txt"

  tags = {
    md5 = "${filemd5("${path.module}/resources/mwaa/requirements.txt")}"
  }
}

resource "aws_s3_object" "mwaa_startup" {
  bucket = module.s3_bucket["airflow_bucket"].s3_bucket_id
  key    = "startup.sh"
  source = "${path.module}/resources/mwaa/startup.sh"

  tags = {
    md5 = "${filemd5("${path.module}/resources/mwaa/startup.sh")}"
  }
}

resource "aws_s3_object" "dag_python_files" {
  for_each = fileset("resources/mwaa/dags", "*.py")

  bucket       = module.s3_bucket["airflow_bucket"].s3_bucket_id
  key          = "dags/${each.value}"
  source       = "resources/mwaa/dags/${each.value}"
  content_type = each.value
  etag         = filemd5("${path.module}/resources/mwaa/dags/${each.value}")
}

resource "aws_s3_object" "dbt_sql_files" {
  for_each = fileset("resources/mwaa/dags/dbt/dbt_project", "{models,macros,tests}/**/*.sql")

  bucket       = module.s3_bucket["airflow_bucket"].s3_bucket_id
  key          = "dags/dbt/dbt_project/${each.value}"
  source       = "resources/mwaa/dags/dbt/dbt_project/${each.value}"
  content_type = each.value
  etag         = filemd5("${path.module}/resources/mwaa/dags/dbt/dbt_project/${each.value}")
}

resource "aws_s3_object" "dbt_yml_files" {
  for_each = fileset("resources/mwaa/dags/dbt/dbt_project", "{models,macros,tests}/**/*.yml")

  bucket       = module.s3_bucket["airflow_bucket"].s3_bucket_id
  key          = "dags/dbt/dbt_project/${each.value}"
  source       = "resources/mwaa/dags/dbt/dbt_project/${each.value}"
  content_type = each.value
  etag         = filemd5("${path.module}/resources/mwaa/dags/dbt/dbt_project/${each.value}")
}

resource "aws_s3_object" "dbt_config_project" {
  bucket = module.s3_bucket["airflow_bucket"].s3_bucket_id
  key    = "dags/dbt/dbt_project/dbt_project.yml"
  content = templatefile("resources/mwaa/dags/dbt/dbt_project/config/dbt_project.yml",
    {
      staging_bucket   = module.s3_bucket["staging_bucket"].s3_bucket_id
      reporting_bucket = module.s3_bucket["reporting_bucket"].s3_bucket_id
  })
}

resource "aws_s3_object" "dbt_config_profiles" {
  bucket = module.s3_bucket["airflow_bucket"].s3_bucket_id
  key    = "dags/dbt/dbt_project/profiles.yml"
  content = templatefile("resources/mwaa/dags/dbt/dbt_project/config/profiles.yml",
    {
      region     = var.region
      dbt_bucket = module.s3_bucket["dbt_bucket"].s3_bucket_id
  })
}

resource "aws_iam_role_policy_attachment" "airflow" {
  role       = aws_iam_role.airflow.name
  policy_arn = aws_iam_policy.airflow.arn
}

resource "aws_iam_role" "airflow" {
  name = "airflow"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "airflow.amazonaws.com",
                    "airflow-env.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# Be careful when modifying these permission since might affect the successful execution
resource "aws_iam_policy" "airflow" {
  name   = "airflow"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "airflow:PublishMetrics"
            ],
            "Resource": [
                "arn:aws:airflow:${var.region}:${local.account_id}:environment/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject*",
                "s3:GetBucket*",
                "s3:List*"
            ],
            "Resource": [
                "${module.s3_bucket["airflow_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["airflow_bucket"].s3_bucket_arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:CreateLogGroup",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:GetLogRecord",
                "logs:GetLogGroupFields",
                "logs:GetQueryResults"
            ],
            "Resource": [
                "arn:aws:logs:${var.region}:${local.account_id}:log-group:airflow-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:DescribeLogGroups"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetAccountPublicAccessBlock"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData*"            
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "sqs:ChangeMessageVisibility",
                "sqs:DeleteMessage",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ReceiveMessage",
                "sqs:SendMessage"            
            ],
            "Resource": [
                "arn:aws:sqs:${var.region}:*:airflow-celery-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:GenerateDataKey*",
                "kms:Encrypt",
                "kms:DescribeKey",
                "kms:Decrypt"
            ],
            "NotResource": "arn:aws:kms:*:${local.account_id}:key/*",
            "Condition": {
                "StringLike": {
                    "kms:ViaService": [
                      "sqs.${var.region}.amazonaws.com",
                      "s3.${var.region}.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": [
                "${module.sns.arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "athena:StartQueryExecution",
                "athena:StopQueryExecution",
                "athena:GetQueryExecution",
                "athena:GetQueryResults" 
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "glue:GetDatabase",
                "glue:GetDatabases",
                "glue:GetTable",
                "glue:GetTables",
                "glue:GetTableVersions",
                "glue:CreateTable",
                "glue:UpdateTable",
                "glue:DeleteTable", 
                "glue:GetPartitions",
                "glue:GetPartition",
                "glue:DeletePartition"         
            ],
            "Resource": [
                "arn:aws:glue:${var.region}:${local.account_id}:catalog",
                "arn:aws:glue:${var.region}:${local.account_id}:table/*",
                "${aws_glue_catalog_database.staging.arn}",
                "${aws_glue_catalog_database.reporting.arn}",
                "${aws_glue_catalog_database.dbt.arn}",
                "${aws_glue_catalog_database.dbt_test__audit.arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "glue:GetJob",       
                "glue:StartJobRun",       
                "glue:GetJobRun"       
            ],
            "Resource": [
                "arn:aws:glue:${var.region}:${local.account_id}:job/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload",
                "s3:PutObject"
            ],
            "Resource": [              
                "${module.s3_bucket["dbt_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["dbt_bucket"].s3_bucket_arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:List*",
                "s3:GetObject*",
                "s3:GetBucket*",
                "s3:PutObject*",
                "s3:DeleteObject*"
            ],
            "Resource": [              
                "${module.s3_bucket["staging_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["staging_bucket"].s3_bucket_arn}/*",
                "${module.s3_bucket["reporting_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["reporting_bucket"].s3_bucket_arn}/*",
                "${module.s3_bucket["dbt_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["dbt_bucket"].s3_bucket_arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "lakeformation:GetDataAccess"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}