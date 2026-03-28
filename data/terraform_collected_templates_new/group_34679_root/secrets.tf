# secrets.tf (Secret Management)

# -----------------------------------------------------------------------------
# --- RIOT API KEY SECRET ---
# These resources create a secret in AWS Secrets Manager to securely store
# the Riot API key, avoiding the need to hardcode it in the Lambda functions.
# -----------------------------------------------------------------------------

# Creates the secret container.
resource "aws_secretsmanager_secret" "riot_api_secret" {
  name = "gg-analyzer/riot-api-key"
}

# Creates a version of the secret and stores the actual key value from a variable.
resource "aws_secretsmanager_secret_version" "riot_api_secret_version" {
  secret_id     = aws_secretsmanager_secret.riot_api_secret.id
  secret_string = jsonencode({
    riot_api_key = var.riot_api_key
  })
}