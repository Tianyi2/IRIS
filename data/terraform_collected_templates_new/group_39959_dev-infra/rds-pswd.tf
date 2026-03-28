resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "random_string" "secret_name_db" {
  length  = 5
  special = false
}

resource "aws_secretsmanager_secret" "db_password_secret" {
  name       = "${random_string.secret_name_db.result}-db-password"
  kms_key_id = aws_kms_key.secrets_manager_key.arn
}

resource "aws_secretsmanager_secret_version" "db_password_secret_version" {
  secret_id = aws_secretsmanager_secret.db_password_secret.id
  secret_string = jsonencode({
    DB_PASSWORD = random_password.db_password.result
  })
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id  = aws_secretsmanager_secret.db_password_secret.id
  depends_on = [aws_secretsmanager_secret_version.db_password_secret_version]
}