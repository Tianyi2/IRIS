# Create resource group
resource "azurerm_resource_group" "vm_group" {
  name     = var.resource_group_name
  location = var.resource_location
}