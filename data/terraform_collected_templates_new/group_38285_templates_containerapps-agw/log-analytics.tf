# Create logs analytics workspace
resource "azurerm_log_analytics_workspace" "log" {
    name = "${var.project_prefix}-${var.default_location}-log-${var.environment}"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.default_location
    sku = var.analytics_workspace_sku
    retention_in_days = 30

    depends_on = [azurerm_resource_group.rg]

    tags = var.tags
}