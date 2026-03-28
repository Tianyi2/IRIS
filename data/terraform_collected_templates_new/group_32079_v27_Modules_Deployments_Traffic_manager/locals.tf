# Calculate local variables
locals {

  # Resource functions and concatenations
  location_prefix         = replace(var.traffic_manager_location, "/[a-z[:space:]]/", "")
  resource_group_name     = "${local.location_prefix}-${var.traffic_manager_name}"
  traffic_manager_profile = lower("${var.traffic_manager_name}-${data.azurerm_subscription.current.subscription_id}")
}
