module "sns" {
  source  = "geekcell/sns-email-notification/aws"
  version = "1.0.2"

  name                      = "alerts"
  email_addresses           = [var.email]
  enable_sns_sse_encryption = false
}