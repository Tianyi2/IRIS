# Create virtual network
resource "azurerm_virtual_network" "vm_network" {
  name                = var.network_name
  address_space       = [var.network_address]
  location            = var.resource_location
  resource_group_name = var.resource_group_name
}

# Create network subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm_network.name
  address_prefixes     = cidrsubnets(var.network_address, 1)
}

resource "azurerm_route_table" "route_table" {
  name                          = var.subnet_name
  location                      = var.resource_location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
}

resource "azurerm_route" "udr_internet" {
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.route_table.name
  name                = "UDR-Internet"
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}

resource "azurerm_subnet_route_table_association" "subnet_association" {
  subnet_id      = azurerm_subnet.vm_subnet.id
  route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = var.subnet_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "network_security_group_association" {
  subnet_id                 = azurerm_subnet.vm_subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}
