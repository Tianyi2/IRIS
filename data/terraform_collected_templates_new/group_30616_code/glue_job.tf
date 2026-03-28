resource "aws_glue_job" "jobs" {
  for_each = fileset("resources/scripts/glue", "*.py")

  execution_class   = "STANDARD"
  glue_version      = "4.0"
  max_retries       = "0"
  name              = replace(each.value, ".py", "")
  number_of_workers = local.glue_number_of_workers
  role_arn          = aws_iam_role.glue.arn
  timeout           = "2880"
  worker_type       = local.glue_worker_type

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${module.s3_bucket["glueassets_bucket"].s3_bucket_id}/artifacts/${each.value}"
  }

  execution_property {
    max_concurrent_runs = "1"
  }

  default_arguments = {
    "--TempDir"                          = "s3://${module.s3_bucket["glueassets_bucket"].s3_bucket_id}/temporary/"
    "--datalake-formats"                 = "iceberg"
    "--enable-auto-scaling"              = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-job-insights"              = "false"
    "--enable-metrics"                   = "true"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--job-language"                     = "python"
    "--config"                           = aws_ssm_parameter.glue_config.name
    "--tables"                           = aws_ssm_parameter.glue_tables.name
    "--iceberg_lock"                     = aws_dynamodb_table.iceberg_lock.name
  }
}

resource "aws_iam_role" "glue" {
  name = "glue"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "glue.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "glue" {
  name   = "glue"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "${module.s3_bucket["glueassets_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["glueassets_bucket"].s3_bucket_arn}/*",
                "${module.s3_bucket["raw_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["raw_bucket"].s3_bucket_arn}/*",
                "${module.s3_bucket["staging_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["staging_bucket"].s3_bucket_arn}/*",
                "${module.s3_bucket["reporting_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["reporting_bucket"].s3_bucket_arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": [
                "${aws_ssm_parameter.glue_config.arn}",
                "${aws_ssm_parameter.glue_tables.arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeTable",
                "dynamodb:UpdateItem",
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": [
                "${aws_dynamodb_table.iceberg_lock.arn}"
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

resource "aws_iam_role_policy_attachment" "glue" {
  role       = aws_iam_role.glue.name
  policy_arn = aws_iam_policy.glue.arn
}

resource "aws_iam_role_policy_attachment" "glue_AmazonEC2ContainerRegistryFullAccess" {
  role       = aws_iam_role.glue.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "glue_AWSGlueServiceRole" {
  role       = aws_iam_role.glue.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_s3_object" "glue_files" {
  for_each = fileset("resources/scripts/glue", "*.py")

  bucket       = module.s3_bucket["glueassets_bucket"].s3_bucket_id
  key          = "artifacts/${each.value}"
  source       = "resources/scripts/glue/${each.value}"
  content_type = each.value
  etag         = filemd5("${path.module}/resources/scripts/glue/${each.value}")
}