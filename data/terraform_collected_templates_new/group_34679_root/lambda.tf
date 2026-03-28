# lambda.tf (Lambda Functions and Packaging)

# -----------------------------------------------------------------------------
# --- LAMBDA PACKAGING ---
# These resources handle the preparation of the Python code for deployment.
# -----------------------------------------------------------------------------

# Defines a local variable for the project's root path.
locals {
  project_root = abspath(path.module)
}

# Uses Docker to install the Python libraries from requirements.txt for the ingestion Lambda.
resource "null_resource" "package_ingestion" {
  triggers = {
    requirements_hash = filebase64sha256("${path.module}/src/ingestion_lambda/requirements.txt")
  }
  provisioner "local-exec" {
    command = "docker run --rm -v ${local.project_root}/src/ingestion_lambda:/var/task python:3.11-slim pip install -r /var/task/requirements.txt -t /var/task"
  }
}

# Uses Docker to install the Python libraries for the transformation Lambda.
resource "null_resource" "package_transformation" {
  triggers = {
    requirements_hash = filebase64sha256("${path.module}/src/transformation_lambda/requirements.txt")
  }
  provisioner "local-exec" {
    command = "docker run --rm -v ${local.project_root}/src/transformation_lambda:/var/task python:3.11-slim pip install -r /var/task/requirements.txt -t /var/task"
  }
}

# Zips the ingestion Lambda's source code and dependencies into a deployment package.
data "archive_file" "ingestion_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src/ingestion_lambda"
  output_path = "${path.module}/dist/ingestion_lambda.zip"
  depends_on  = [null_resource.package_ingestion]
}

# Zips the transformation Lambda's source code and dependencies.
data "archive_file" "transformation_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src/transformation_lambda"
  output_path = "${path.module}/dist/transformation_lambda.zip"
  depends_on  = [null_resource.package_transformation]
}


# -----------------------------------------------------------------------------
# --- INGESTION LAMBDA FUNCTION ---
# This function is triggered with a player's Riot ID & Region to fetch their match list.
# -----------------------------------------------------------------------------
resource "aws_lambda_function" "ingestion_lambda" {
  function_name    = "gg-analyzer-ingestion-lambda"
  role             = aws_iam_role.ingestion_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30
  filename         = data.archive_file.ingestion_lambda_zip.output_path
  source_code_hash = data.archive_file.ingestion_lambda_zip.output_base64sha256

  environment {
    variables = {
      S3_BUCKET_NAME = aws_s3_bucket.gg_analyzer_data.id
      SECRET_NAME    = aws_secretsmanager_secret.riot_api_secret.name
      SQS_QUEUE_URL  = aws_sqs_queue.player_processing_queue.id
    }
  }
}


# -----------------------------------------------------------------------------
# --- TRANSFORMATION LAMBDA FUNCTION ---
# This function processes matches from the SQS queue and stores them in S3.
# -----------------------------------------------------------------------------
resource "aws_lambda_function" "transformation_lambda" {
  function_name    = "gg-analyzer-transformation-lambda"
  role             = aws_iam_role.transformation_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  timeout          = 210
  memory_size      = 256
  filename         = data.archive_file.transformation_lambda_zip.output_path
  source_code_hash = data.archive_file.transformation_lambda_zip.output_base64sha256

  environment {
    variables = {
      RIOT_API_SECRET_NAME = aws_secretsmanager_secret.riot_api_secret.name
      S3_BUCKET_NAME       = aws_s3_bucket.gg_analyzer_data.id
      GLUE_DATABASE_NAME   = aws_glue_catalog_database.game_data_db.name
      GLUE_TABLE_NAME      = "player_match_stats"
      PROCESSED_TABLE_NAME = aws_dynamodb_table.processed_matches_table.name
      SQS_QUEUE_URL        = aws_sqs_queue.player_processing_queue.id
    }
  }
}


# -----------------------------------------------------------------------------
# --- LAMBDA TRIGGERS AND PERMISSIONS ---
# These resources connect the Lambda functions to other AWS services.
# -----------------------------------------------------------------------------

# Connects the SQS queue to the transformation Lambda, triggering it when a message arrives.
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.player_processing_queue.arn
  function_name    = aws_lambda_function.transformation_lambda.arn
  batch_size       = 1 
}

# Grants S3 the permission to invoke the transformation Lambda (used for S3 event triggers).
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.transformation_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.gg_analyzer_data.arn
}