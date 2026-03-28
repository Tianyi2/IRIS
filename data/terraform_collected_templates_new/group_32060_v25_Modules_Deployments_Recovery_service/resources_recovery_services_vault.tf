# Recovery services vault for solution
resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = "${local.recovery_services_name}-vault"
  location            = azurerm_resource_group.vm_group.location
  resource_group_name = azurerm_resource_group.vm_group.name
  sku                 = "Standard"

  soft_delete_enabled = false
}