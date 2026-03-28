# Outputs for use by other modules
output "subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}
output "network_id" {
  value = azurerm_virtual_network.vm_network.id
}