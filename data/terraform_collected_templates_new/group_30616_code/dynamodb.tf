resource "aws_dynamodb_table" "iceberg_lock" {
  name         = "iceberg-lock"
  hash_key     = "entityId"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "entityId"
    type = "S"
  }
}