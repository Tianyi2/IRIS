# Used by DMS instead of inyecting them directly
module "secrets_manager_postgres" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "~> 1.0"

  name_prefix = "postgres-"
  description = "Postgres secret"

  # Secret
  recovery_window_in_days = 0
  secret_string = jsonencode(
    {
      username = var.postgres_user
      password = random_password.password.result
      port     = 5432
      host     = "${element(split(":", aws_db_instance.postgres.endpoint), 0)}"
    }
  )
  kms_key_id = aws_kms_key.secrets.id
}

resource "aws_kms_key" "secrets" {
  description         = "KMS CMK"
  enable_key_rotation = true
}