# Azure resource group
resource "azurerm_resource_group" "rg" {
  name = "${var.project_prefix}-${var.environment}-rg"
  location = var.default_location
  tags = var.tags
}