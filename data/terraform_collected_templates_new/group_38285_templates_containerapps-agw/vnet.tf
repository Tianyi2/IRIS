resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_prefix}-vnet-${var.environment}"
  address_space       = ["10.0.0.0/16"]
  location            = var.default_location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [azurerm_resource_group.rg]
  tags = var.tags
}

resource "azurerm_subnet" "private" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.8.0/21"]
  depends_on = [azurerm_virtual_network.vnet]
}