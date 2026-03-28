# Create traffic manager endpoint
resource "azurerm_traffic_manager_endpoint" "traffic_manager_endpoint" {
  for_each            = toset(var.traffic_manager_endpoint_locations)
  name                = "${replace(each.value, "/[a-z[:space:]]/", "")}-${var.resource_name}"
  resource_group_name = azurerm_resource_group.vm_group.name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager_profile.name
  target_resource_id  = var.traffic_manager_endpoints[each.value].public_ip_id
  type                = "azureEndpoints"
  weight              = 100
}