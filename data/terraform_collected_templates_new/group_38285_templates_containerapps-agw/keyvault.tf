# # Create azure keyvault for SSL certificate storage

# resource "azurerm_key_vault" "kv" {
#   name                        = "${var.key_vault_name}${var.environment}"
#   location                    = var.default_location
#   resource_group_name         = azurerm_resource_group.rg.name
#   enabled_for_disk_encryption = false
#   tenant_id                   = data.azurerm_client_config.azconfig.tenant_id
#   soft_delete_retention_days  = var.key_vault_soft_delete_retention_days
#   purge_protection_enabled    = false

#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.azconfig.tenant_id
#     object_id = data.azurerm_client_config.azconfig.object_id

#     key_permissions = [
#                         "Get",
#                         "Create",
#                         "Delete",
#                         "List",
#                         "Restore",
#                         "Recover",
#                         "UnwrapKey",
#                         "WrapKey",
#                         "Purge",
#                         "Encrypt",
#                         "Decrypt",
#                         "Sign",
#                         "Verify",
#                         "GetRotationPolicy"
#                     ]

#     secret_permissions = [
#                         "Get",
#                         "List",
#                         "Set",
#                         "Delete",
#                         "Recover",
#                         "Backup",
#                         "Restore"
#                     ]

#     certificate_permissions = [
#                         "Get",
#                         "List",
#                         "Update",
#                         "Create",
#                         "Import",
#                         "Delete",
#                         "Recover",
#                         "Backup",
#                         "Restore",
#                         "ManageContacts",
#                         "ManageIssuers",
#                         "GetIssuers",
#                         "ListIssuers",
#                         "SetIssuers",
#                         "DeleteIssuers"
#                     ]
#   }

#   tags = var.tags
# }

# resource "azurerm_key_vault_access_policy" "kv_policy" {
#   key_vault_id = azurerm_key_vault.kv.id
#   tenant_id    = data.azurerm_client_config.azconfig.tenant_id
#   object_id    = azurerm_user_assigned_identity.containerapp.principal_id

#   certificate_permissions = [
#     "Get",
#     "List",
#   ]

#   secret_permissions = [
#     "Get",
#     "List",
#   ]

#   depends_on = [
#     azurerm_user_assigned_identity.containerapp,
#     azurerm_key_vault.kv
#   ]
# }