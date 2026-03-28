# Calculate local variables
locals {

  # Service functions and concatenations
  location_prefix = replace(var.recovery_services_location, "/[a-z[:space:]]/", "")

  # Resource functions and concatenations
  resource_group_name    = "${local.location_prefix}-${var.recovery_services_name}"
  recovery_services_name = "${local.location_prefix}-${var.recovery_services_name}"
}
