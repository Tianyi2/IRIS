resource "azurerm_managed_disk" "this" {
  for_each = var.data_disk_managed_disks

  create_option                     = each.value.create_option
  location                          = var.location
  name                              = each.value.name
  resource_group_name               = coalesce(each.value.resource_group_name, var.resource_group_name)
  storage_account_type              = each.value.storage_account_type
  disk_access_id                    = each.value.disk_access_resource_id
  disk_encryption_set_id            = each.value.disk_encryption_set_resource_id
  disk_iops_read_only               = each.value.disk_iops_read_only
  disk_iops_read_write              = each.value.disk_iops_read_write
  disk_mbps_read_only               = each.value.disk_mbps_read_only
  disk_mbps_read_write              = each.value.disk_mbps_read_write
  disk_size_gb                      = each.value.disk_size_gb
  edge_zone                         = each.value.edge_zone != null ? each.value.edge_zone : var.edge_zone
  gallery_image_reference_id        = each.value.gallery_image_reference_resource_id
  hyper_v_generation                = each.value.hyper_v_generation
  image_reference_id                = each.value.image_reference_resource_id
  logical_sector_size               = each.value.logical_sector_size
  max_shares                        = each.value.max_shares
  network_access_policy             = each.value.network_access_policy
  on_demand_bursting_enabled        = each.value.on_demand_bursting_enabled
  optimized_frequent_attach_enabled = each.value.optimized_frequent_attach_enabled
  os_type                           = each.value.os_type
  performance_plus_enabled          = each.value.performance_plus_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  secure_vm_disk_encryption_set_id  = each.value.secure_vm_disk_encryption_set_resource_id
  security_type                     = each.value.security_type
  source_resource_id                = each.value.source_resource_id
  source_uri                        = each.value.source_uri
  storage_account_id                = each.value.storage_account_resource_id
  tags                              = each.value.tags != null && each.value.tags != {} ? each.value.tags : local.tags
  tier                              = each.value.tier
  trusted_launch_enabled            = each.value.trusted_launch_enabled
  upload_size_bytes                 = each.value.upload_size_bytes
  zone                              = var.zone

  dynamic "encryption_settings" {
    for_each = each.value.encryption_settings

    content {
      disk_encryption_key {
        secret_url      = encryption_settings.value.disk_encryption_key_vault_secret_url
        source_vault_id = encryption_settings.value.disk_encryption_key_vault_resource_id
      }
      key_encryption_key {
        key_url         = encryption_settings.value.key_encryption_key_vault_secret_url
        source_vault_id = encryption_settings.value.key_encryption_key_vault_resource_id
      }
    }
  }
}

#attach the disk(s) to the virtual machine
resource "azurerm_virtual_machine_data_disk_attachment" "this_linux" {
  for_each = { for disk, values in var.data_disk_managed_disks : disk => values if(lower(var.os_type) == "linux") }

  caching                   = each.value.caching
  lun                       = each.value.lun
  managed_disk_id           = azurerm_managed_disk.this[each.key].id
  virtual_machine_id        = azurerm_linux_virtual_machine.this[0].id
  create_option             = each.value.disk_attachment_create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled
}

resource "azurerm_virtual_machine_data_disk_attachment" "this_windows" {
  for_each = { for disk, values in var.data_disk_managed_disks : disk => values if(lower(var.os_type) == "windows") }

  caching                   = each.value.caching
  lun                       = each.value.lun
  managed_disk_id           = azurerm_managed_disk.this[each.key].id
  virtual_machine_id        = azurerm_windows_virtual_machine.this[0].id
  create_option             = each.value.disk_attachment_create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled
}
