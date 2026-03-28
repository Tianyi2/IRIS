# Creation of key vault
module "key_vault" {
  source                  = "../../Resources/Key_vault"
  resource_location       = azurerm_resource_group.vm_group.location
  resource_group_name     = azurerm_resource_group.vm_group.name
  resource_name           = local.resource_name
  resource_secret         = random_password.vm_password
  resource_instance_count = var.resource_instance_count
}
