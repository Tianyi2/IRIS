# Create availability set
resource "azurerm_availability_set" "vm_availability_set" {
  count                       = local.platform_location_az_count < 1 ? 1 : 0
  name                        = local.resource_name
  location                    = azurerm_resource_group.vm_group.location
  resource_group_name         = azurerm_resource_group.vm_group.name
  platform_fault_domain_count = var.vm_fault_domain

  tags = {
    environment = var.vm_environment
  }
}

# Create network adapter
resource "azurerm_network_interface" "vm_network_interface" {

  # Force explicit dependency to prevent race condition/deadlock in network module
  depends_on = [
    module.vm_network
  ]

  count               = var.resource_instance_count
  name                = "${local.resource_name}${count.index + 1}"
  location            = azurerm_resource_group.vm_group.location
  resource_group_name = azurerm_resource_group.vm_group.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = module.vm_network.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "virtual_machine" {
  count                           = var.resource_instance_count
  name                            = "${local.resource_name}${count.index + 1}"
  resource_group_name             = azurerm_resource_group.vm_group.name
  location                        = azurerm_resource_group.vm_group.location
  size                            = var.resource_size
  admin_username                  = var.admin_username
  admin_password                  = random_password.vm_password[count.index].result
  disable_password_authentication = false

  # Get all of the interface ids, and select the correct one for this iteration
  network_interface_ids = [
    azurerm_network_interface.vm_network_interface[count.index].id,
  ]

  # If there is less than one availability zone, then specify availability set id
  availability_set_id = local.platform_location_az_count < 1 ? azurerm_availability_set.vm_availability_set[0].id : null

  # If there is more than one availability zone, select the AZ in iteration from the maximum count of availability zones
  zone = local.platform_location_az_count > 1 ? (count.index % local.platform_location_az_count) + 1 : null

  os_disk {
    caching              = "ReadOnly"
    storage_account_type = var.vm_disk_type
    disk_size_gb         = var.vm_disk_size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.vm_sku
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = {
    environment = var.vm_environment
  }

}
