# Create spoke network dependencies
module "data_disks" {
  count                       = var.resource_instance_count
  source                      = "../../Resources/Disks/"
  resource_location           = azurerm_resource_group.vm_group.location
  resource_group_name         = azurerm_resource_group.vm_group.name
  resource_environment        = var.vm_environment
  resource_name               = "${local.resource_name}${count.index + 1}"
  resource_zone               = local.platform_location_az_count > 1 ? (count.index % local.platform_location_az_count) + 1 : null
  vm_data_disk_count          = var.vm_data_disk_count
  vm_data_disk_size           = var.vm_data_disk_size
  resource_virtual_machine_id = element(azurerm_linux_virtual_machine.virtual_machine.*.id, count.index)
}
