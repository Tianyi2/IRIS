locals {
  location_prefix            = replace(var.resource_location, "/[a-z[:space:]]/", "")
  resource_group_name        = "${var.resource_group_name}-${local.location_prefix}-${var.deployment}"
  resource_name              = "${var.resource_name}-${local.location_prefix}"
  platform_location_az_count = lookup(var.platform_location_az, var.resource_location, null)
}
