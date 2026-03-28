output "public_ip_id" {
  value = module.public_load_balancer.public_ip_id
}

output "virtual_machine_id" {
  value = azurerm_linux_virtual_machine.virtual_machine[*].id
}
