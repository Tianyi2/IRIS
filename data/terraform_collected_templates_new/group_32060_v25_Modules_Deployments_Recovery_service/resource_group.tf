# Define resource group for resource
resource "azurerm_resource_group" "vm_group" {
  name     = local.resource_group_name
  location = var.recovery_services_location
}
