# Create traffic manager profile
resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  name                   = var.traffic_manager_name
  resource_group_name    = azurerm_resource_group.vm_group.name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = local.traffic_manager_profile
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = var.vm_environment
  }
}
