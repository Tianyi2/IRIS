/*
 * time management slack
 */
resource "aws_ssm_parameter" "igsr5_time_management_slack_dsn" {
  name        = "/igsr5/time_management_slack/dsn"
  value       = "null"
  type        = "String"
  description = "slack api BOT_USER_OAUTH_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "igsr5_time_management_slack_bot_user_oauth_token" {
  name        = "/igsr5/time_management_slack/bot_user_oauth_token"
  value       = "null"
  type        = "String"
  description = "slack api BOT_USER_OAUTH_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "igsr5_time_management_slack_signing_secret" {
  name        = "/igsr5/time_management_slack/signing_secret"
  value       = "null"
  type        = "String"
  description = "slack api SIGNING_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "igsr5_time_management_slack_app_token" {
  name        = "/igsr5/time_management_slack/app_token"
  value       = "null"
  type        = "String"
  description = "slack api SIGNING_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}


resource "aws_ssm_parameter" "igsr5_time_management_slack_auth_user_id" {
  name        = "/igsr5/time_management_slack/auth_user_id"
  value       = "null"
  type        = "String"
  description = "slack user id"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "igsr5_time_management_slack_auth_user_name" {
  name        = "/igsr5/time_management_slack/auth_user_name"
  value       = "null"
  type        = "String"
  description = "slack user name"
  lifecycle {
    ignore_changes = [value]
  }
}
