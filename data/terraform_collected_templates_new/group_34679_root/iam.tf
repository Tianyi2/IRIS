# iam.tf (Centralized with Full Access Policies)

# -----------------------------------------------------------------------------
# --- IAM ROLE FOR INGESTION LAMBDA ---
# -----------------------------------------------------------------------------
resource "aws_iam_role" "ingestion_lambda_role" {
  name               = "gg-analyzer-ingestion-lambda-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# Attach Full Access policies

resource "aws_iam_role_policy_attachment" "ingestion_sqs_attach" {
  role       = aws_iam_role.ingestion_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "ingestion_secrets_attach" {
  role       = aws_iam_role.ingestion_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite" 
}

resource "aws_iam_role_policy_attachment" "ingestion_logs_attach" {
  role       = aws_iam_role.ingestion_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess" 
}


# -----------------------------------------------------------------------------
# --- IAM ROLE FOR TRANSFORMATION LAMBDA ---
# -----------------------------------------------------------------------------
resource "aws_iam_role" "transformation_lambda_role" {
  name               = "gg-analyzer-transformation-lambda-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# Attach Full Access policies
resource "aws_iam_role_policy_attachment" "transformation_s3_attach" {
  role       = aws_iam_role.transformation_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "transformation_sqs_attach" {
  role       = aws_iam_role.transformation_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "transformation_dynamodb_attach" {
  role       = aws_iam_role.transformation_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "transformation_secrets_attach" {
  role       = aws_iam_role.transformation_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "transformation_logs_attach" {
  role       = aws_iam_role.transformation_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}


# -----------------------------------------------------------------------------
# --- IAM ROLE FOR GLUE CRAWLER ---
# -----------------------------------------------------------------------------
resource "aws_iam_role" "glue_crawler_role" {
  name = "gg-analyzer-glue-crawler-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "glue.amazonaws.com" }
    }]
  })
}

# Attach standard AWS Glue service role
resource "aws_iam_role_policy_attachment" "glue_service_attach" {
  role       = aws_iam_role.glue_crawler_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Grant full access to S3 for the crawler
resource "aws_iam_role_policy_attachment" "glue_s3_attach" {
  role       = aws_iam_role.glue_crawler_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


# -----------------------------------------------------------------------------
# --- IAM USER FOR POPSQL ---
# -----------------------------------------------------------------------------
resource "aws_iam_user" "popsql_user" {
  name = "popsql-athena-user"
}

resource "aws_iam_access_key" "popsql_user_key" {
  user = aws_iam_user.popsql_user.name
}

# Attach Full Access policies
resource "aws_iam_user_policy_attachment" "popsql_athena_attach" {
  user       = aws_iam_user.popsql_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

resource "aws_iam_user_policy_attachment" "popsql_glue_attach" {
  user       = aws_iam_user.popsql_user.name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_user_policy_attachment" "popsql_s3_attach" {
  user       = aws_iam_user.popsql_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


# -----------------------------------------------------------------------------
# --- IAM USER FOR POWER BI ---
# -----------------------------------------------------------------------------
resource "aws_iam_user" "powerbi_user" {
  name = "powerbi-athena-user"
  tags = {
    Description = "IAM user for Power BI to access Athena data sources"
  }
}

resource "aws_iam_access_key" "powerbi_user_key" {
  user = aws_iam_user.powerbi_user.name
}

# Attach Full Access policies
resource "aws_iam_user_policy_attachment" "powerbi_athena_attach" {
  user       = aws_iam_user.powerbi_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

resource "aws_iam_user_policy_attachment" "powerbi_glue_attach" {
  user       = aws_iam_user.powerbi_user.name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_user_policy_attachment" "powerbi_s3_attach" {
  user       = aws_iam_user.powerbi_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}