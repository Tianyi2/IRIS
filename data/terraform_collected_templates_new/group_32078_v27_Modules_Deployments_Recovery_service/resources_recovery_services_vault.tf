# Recovery services vault for solution
resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = "${local.recovery_services_name}-vault"
  location            = azurerm_resource_group.vm_group.location
  resource_group_name = azurerm_resource_group.vm_group.name
  sku                 = "Standard"

  soft_delete_enabled = false
}

# Backup policy
resource "azurerm_backup_policy_vm" "backup_policy_vm" {
  name                = "${local.recovery_services_name}-policy"
  resource_group_name = azurerm_resource_group.vm_group.name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_services_vault.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "00:00"
  }

  retention_daily {
    count = 7
  }
}

# Backup virtual machine
resource "azurerm_backup_protected_vm" "backup_protected_vm" {
  count               = var.recovery_services_instance_count
  resource_group_name = azurerm_resource_group.vm_group.name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_services_vault.name
  source_vm_id        = var.recovery_services_virtual_machines.virtual_machine_id[count.index]
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy_vm.id
}
