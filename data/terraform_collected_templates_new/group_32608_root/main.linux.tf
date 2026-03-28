resource "azurerm_linux_virtual_machine" "this" {
  count = (lower(var.os_type) == "linux") ? 1 : 0

  #required properties
  admin_username        = var.admin_username
  location              = var.location
  name                  = var.name
  network_interface_ids = [for interface in azurerm_network_interface.virtualmachine_network_interfaces : interface.id]
  resource_group_name   = var.resource_group_name
  size                  = var.sku_size
  #optional properties
  admin_password                                         = (var.disable_password_authentication ? null : local.admin_password_linux)
  allow_extension_operations                             = var.allow_extension_operations
  availability_set_id                                    = var.availability_set_resource_id
  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = var.capacity_reservation_group_resource_id
  computer_name                                          = coalesce(var.computer_name, var.name)
  custom_data                                            = var.custom_data
  dedicated_host_group_id                                = var.dedicated_host_group_resource_id
  dedicated_host_id                                      = var.dedicated_host_resource_id
  disable_password_authentication                        = var.disable_password_authentication
  disk_controller_type                                   = var.disk_controller_type
  edge_zone                                              = var.edge_zone
  encryption_at_host_enabled                             = var.encryption_at_host_enabled
  eviction_policy                                        = var.eviction_policy
  extensions_time_budget                                 = var.extensions_time_budget
  license_type                                           = var.license_type
  max_bid_price                                          = var.max_bid_price
  patch_assessment_mode                                  = var.patch_assessment_mode
  patch_mode                                             = var.patch_mode
  platform_fault_domain                                  = var.platform_fault_domain
  priority                                               = var.priority
  provision_vm_agent                                     = var.provision_vm_agent
  proximity_placement_group_id                           = var.proximity_placement_group_resource_id
  reboot_setting                                         = var.reboot_setting
  secure_boot_enabled                                    = var.secure_boot_enabled
  source_image_id                                        = var.source_image_resource_id
  user_data                                              = var.user_data
  virtual_machine_scale_set_id                           = var.virtual_machine_scale_set_resource_id
  vtpm_enabled                                           = var.vtpm_enabled
  zone                                                   = var.zone

  os_disk {
    caching                          = var.os_disk.caching
    storage_account_type             = var.os_disk.storage_account_type
    disk_encryption_set_id           = var.os_disk.disk_encryption_set_id
    disk_size_gb                     = var.os_disk.disk_size_gb
    name                             = var.os_disk.name
    secure_vm_disk_encryption_set_id = var.os_disk.secure_vm_disk_encryption_set_id
    security_encryption_type         = var.os_disk.security_encryption_type
    write_accelerator_enabled        = var.os_disk.write_accelerator_enabled

    dynamic "diff_disk_settings" {
      for_each = var.os_disk.diff_disk_settings == null ? [] : ["diff_disk_settings"]

      content {
        option    = var.os_disk.diff_disk_settings.option
        placement = var.os_disk.diff_disk_settings.placement
      }
    }
  }

  dynamic "additional_capabilities" {
    for_each = var.vm_additional_capabilities == null ? [] : ["additional_capabilities"]

    content {
      hibernation_enabled = var.vm_additional_capabilities.hibernation_enabled
      ultra_ssd_enabled   = var.vm_additional_capabilities.ultra_ssd_enabled
    }
  }

  dynamic "admin_ssh_key" {
    for_each = toset(local.admin_ssh_keys)

    content {
      public_key = admin_ssh_key.value.public_key
      username   = admin_ssh_key.value.username
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics ? ["boot_diagnostics"] : []

    content {
      storage_account_uri = var.boot_diagnostics_storage_account_uri
    }
  }

  dynamic "gallery_application" {
    for_each = { for app, app_details in var.gallery_applications : app => app_details }

    content {
      version_id             = gallery_application.value.version_id
      configuration_blob_uri = gallery_application.value.configuration_blob_uri
      order                  = gallery_application.value.order
      tag                    = gallery_application.value.tag
    }
  }

  dynamic "identity" {
    for_each = local.managed_identity_type == null ? [] : ["identity"]

    content {
      type         = local.managed_identity_type
      identity_ids = var.managed_identities.user_assigned_resource_ids
    }
  }

  dynamic "plan" {
    for_each = var.plan == null ? [] : ["plan"]

    content {
      name      = var.plan.name
      product   = var.plan.product
      publisher = var.plan.publisher
    }
  }

  dynamic "secret" {
    for_each = toset(var.secrets)

    content {
      key_vault_id = secret.value.key_vault_id

      dynamic "certificate" {
        for_each = secret.value.certificate

        content {
          url = certificate.value.url
        }
      }
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_resource_id == null ? ["source_image_reference"] : []

    content {
      offer     = local.source_image_reference.offer
      publisher = local.source_image_reference.publisher
      sku       = local.source_image_reference.sku
      version   = local.source_image_reference.version
    }
  }

  dynamic "termination_notification" {
    for_each = var.termination_notification == null ? [] : [
      "termination_notification"
    ]

    content {
      enabled = var.termination_notification.enabled
      timeout = var.termination_notification.timeout
    }
  }

  tags = merge(
    try(local.tags, {}),
    tomap({
      "Resource Type" = "Virtual Machine"
    })
  )

  depends_on = [ #set explicit depends on for each association to address delete order issues.
    azurerm_network_interface_security_group_association.this,
    azurerm_network_interface_application_security_group_association.this,
    azurerm_network_interface_backend_address_pool_association.this,
    azurerm_network_interface_application_gateway_backend_address_pool_association.this,
    azurerm_network_interface_nat_rule_association.this
  ]

  lifecycle {
    ignore_changes = [
      custom_data
    ]
  }
}


# https://github.com/hashicorp/terraform-provider-azurerm/issues/15156
# https://github.com/Azure/azure-rest-api-specs/issues/21325

resource "azapi_update_resource" "linux_os_disk" {
  count = (lower(var.os_type) == "linux") ? 1 : 0

  type      = "Microsoft.Compute/disks@2023-01-02"
  name      = azurerm_linux_virtual_machine.this[0].os_disk[0].name
  parent_id = "/subscriptions/${local.virtualmachine_parsed_id["subscription_id"]}/resourceGroups/${local.virtualmachine_parsed_id["resource_group_name"]}"

  body = {
    properties = {
      networkAccessPolicy = var.os_disk_managed_disk.network_access_policy
      publicNetworkAccess = var.os_disk_managed_disk.public_network_access_enabled
    }
  }
}