# Create public container registry
resource "azurerm_container_registry" "acr" {
  name                = "${var.project_prefix}acr${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default_location
  sku                 = "${var.acr.sku}"
  admin_enabled       = true
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_resource_group.rg]

  tags = var.tags
}

# Create managed identity for pulling images
resource "azurerm_user_assigned_identity" "containerapp" {
  location            = var.default_location
  name                = "${var.containerappmi_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [azurerm_resource_group.rg]
}

# Assign ACR pull to managed identity
resource "azurerm_role_assignment" "containerapp" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_user_assigned_identity.containerapp.principal_id
  depends_on = [
    azurerm_user_assigned_identity.containerapp
  ]
}