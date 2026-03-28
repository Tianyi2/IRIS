# Provision public IP for load balancer
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.resource_name}-ip"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  availability_zone   = var.location_zone_support == true ? "Zone-Redundant" : "No-Zone"
}

# Create load balancer
resource "azurerm_lb" "load_balancer" {
  name                = "${var.resource_name}-lb"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = azurerm_public_ip.public_ip.name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}
