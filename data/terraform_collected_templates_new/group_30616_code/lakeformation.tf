resource "aws_lakeformation_data_lake_settings" "admins" {
  admins = [data.aws_iam_session_context.current.issuer_arn, aws_iam_role.airflow.arn, aws_iam_role.glue.arn]
}

resource "aws_lakeformation_resource" "buckets" {

  for_each = {
    raw_bucket       = module.s3_bucket["raw_bucket"].s3_bucket_arn
    staging_bucket   = module.s3_bucket["staging_bucket"].s3_bucket_arn
    reporting_bucket = module.s3_bucket["reporting_bucket"].s3_bucket_arn
  }

  arn                   = each.value
  hybrid_access_enabled = false
  role_arn              = aws_iam_role.lakeformation.arn
}

resource "aws_lakeformation_permissions" "staging_database" {

  for_each = {
    glue    = aws_iam_role.glue.arn
    airflow = aws_iam_role.airflow.arn
    this    = data.aws_iam_session_context.current.issuer_arn
  }

  principal                     = each.value
  permissions                   = ["ALL"]
  permissions_with_grant_option = ["ALL"]

  lifecycle {
    ignore_changes = [
      permissions_with_grant_option
    ]
  }

  database {
    name = aws_glue_catalog_database.staging.name
  }
}

resource "aws_lakeformation_permissions" "staging_tables" {

  for_each = {
    glue    = aws_iam_role.glue.arn
    airflow = aws_iam_role.airflow.arn
    this    = data.aws_iam_session_context.current.issuer_arn
  }

  principal   = each.value
  permissions = ["ALL"]

  table {
    database_name = aws_glue_catalog_database.staging.name
    wildcard      = true
  }
}

resource "aws_lakeformation_permissions" "reporting_database" {

  for_each = {
    glue    = aws_iam_role.glue.arn
    airflow = aws_iam_role.airflow.arn
    this    = data.aws_iam_session_context.current.issuer_arn
  }

  principal                     = each.value
  permissions                   = ["ALL"]
  permissions_with_grant_option = ["ALL"]

  lifecycle {
    ignore_changes = [
      permissions_with_grant_option
    ]
  }

  database {
    name = aws_glue_catalog_database.reporting.name
  }
}

resource "aws_lakeformation_permissions" "reporting_tables" {

  for_each = {
    glue    = aws_iam_role.glue.arn
    airflow = aws_iam_role.airflow.arn
    this    = data.aws_iam_session_context.current.issuer_arn
  }

  principal   = each.value
  permissions = ["ALL"]

  table {
    database_name = aws_glue_catalog_database.reporting.name
    wildcard      = true
  }
}

resource "aws_lakeformation_permissions" "dbt_test__audit_database" {

  for_each = {
    glue    = aws_iam_role.glue.arn
    airflow = aws_iam_role.airflow.arn
    this    = data.aws_iam_session_context.current.issuer_arn
  }

  principal                     = each.value
  permissions                   = ["ALL"]
  permissions_with_grant_option = ["ALL"]

  lifecycle {
    ignore_changes = [
      permissions_with_grant_option
    ]
  }

  database {
    name = aws_glue_catalog_database.dbt_test__audit.name
  }
}

resource "aws_lakeformation_permissions" "dbt_test__audit_tables" {

  for_each = {
    glue    = aws_iam_role.glue.arn
    airflow = aws_iam_role.airflow.arn
    this    = data.aws_iam_session_context.current.issuer_arn
  }

  principal   = each.value
  permissions = ["ALL"]

  table {
    database_name = aws_glue_catalog_database.dbt_test__audit.name
    wildcard      = true
  }
}

// Create a custom role rather than using the default AWSServiceRoleForLakeFormationDataAccess since it not always properly add the S3 locations to the policy
resource "aws_iam_role_policy_attachment" "lakeformation" {
  role       = aws_iam_role.lakeformation.name
  policy_arn = aws_iam_policy.lakeformation.arn
}

resource "aws_iam_role" "lakeformation" {
  name = "lakeformation"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "lakeformation.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "lakeformation" {
  name   = "lakeformation"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject*",
                "s3:GetBucket*",
                "s3:List*",
                "s3:DeleteObject",
                "s3:PutObject"
            ],
            "Resource": [
                "${module.s3_bucket["staging_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["staging_bucket"].s3_bucket_arn}/*",
                "${module.s3_bucket["reporting_bucket"].s3_bucket_arn}",
                "${module.s3_bucket["reporting_bucket"].s3_bucket_arn}/*"
            ]
        }
    ]
}
EOF
}