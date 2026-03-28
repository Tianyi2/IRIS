########## Required variables
variable "location" {
  type        = string
  description = "The Azure region where this and supporting resources should be deployed."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name to use when creating the virtual machine."
  nullable    = false

  validation {
    condition     = can(regex("^.{1,64}$", var.name))
    error_message = "virtual machine names for linux must be between 1 and 64 characters in length. Virtual machine name for windows must be between 1 and 20 characters in length."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name of the resource group where the vm resources will be deployed."
  nullable    = false
}

variable "zone" {
  type        = string
  description = "The Availability Zone which the Virtual Machine should be allocated in, only one zone would be accepted. If set then this module won't create `azurerm_availability_set` resource. Changing this forces a new resource to be created. This has been moved to a required value to comply with WAF guidance to intentionally select zones for resources as part of resource architectures. If deploying to a region without zones, set this value to null."
}

########## optional variables
variable "admin_password" {
  type        = string
  default     = null
  description = "Password to use for the default admin account created for the virtual machine. Passing this as a key vault secret value is recommended!, its in the lifecycle, so it will not recreate the vm when its changed."
  sensitive   = true
}

variable "rotate_admin_state_password" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
  Recreate the password, that have useless password in state, make sure to run it at least once if you generate it.

  If you want to stop the pipeline from re-generating the password, set it to false!
  This is a work around to just make sure if you use the generate_admin_password feature, it will no be kept in state
  preffered is ofcourse to specify the password another way

  DESCRIPTION
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Name to use for the default admin account created for the virtual machine"
  nullable    = false

  validation {
    condition     = !can(regex("^(administrator|admin|user|user1|test|user2|test2|user3|admin1|1|123|a|actuser|adm|admin2|aspnet|backup|console|david|guest|john|owner|root|server|sql|support|support_388945a0|sys|test2|test3|user4|user5)$", lower(var.admin_username)))
    error_message = "Admin username may not contain any of the following reserved values. ( administrator, admin, user, user1, test, user2, test1, user3, admin1, 1, 123, a, actuser, adm, admin2, aspnet, backup, console, david, guest, john, owner, root, server, sql, support, support_388945a0, sys, test2, test3, user4, user5 )"
  }
  validation {
    condition     = can(regex("^.{1,64}$", var.admin_username))
    error_message = "Admin username for linux must be between 1 and 64 characters in length. Admin name for windows must be between 1 and 20 characters in length."
  }
}

variable "allow_extension_operations" {
  type        = bool
  default     = true
  description = "(Optional) Should Extension Operations be allowed on this Virtual Machine? Defaults to `true`."
}

variable "availability_set_resource_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Azure Resource ID of the Availability Set in which the Virtual Machine should exist. Cannot be used along with `new_availability_set`, `new_capacity_reservation_group`, `capacity_reservation_group_id`, `virtual_machine_scale_set_id`, `zone`. Changing this forces a new resource to be created."
}

variable "boot_diagnostics" {
  type        = bool
  default     = false
  description = "(Optional) Enable or Disable boot diagnostics."
  nullable    = false
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
  default     = null
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. Passing a null value will Utilize a managed storage account for diags."
}

variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. This value can only be set to true when patch_mode is set to AutomaticByPlatform"
}

variable "capacity_reservation_group_resource_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Azure Resource ID of the Capacity Reservation Group with the Virtual Machine should be allocated to. Cannot be used with availability_set_id or proximity_placement_group_id"
}

variable "computer_name" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the `vm_name` field. If the value of the `vm_name` field is not a valid `computer_name`, then you must specify `computer_name`. Changing this forces a new resource to be created."
}

variable "custom_data" {
  type        = string
  default     = null
  description = "(Optional) The Base64 encoded Custom Data for building this virtual machine. Changing this forces a new resource to be created"

  validation {
    condition     = var.custom_data == null ? true : can(base64decode(var.custom_data))
    error_message = "The `custom_data` must be either `null` or a valid Base64-Encoded string."
  }
}

variable "os_disk_managed_disk" {
  type = object({
    network_access_policy         = optional(string, "DenyAll")
    public_network_access_enabled = optional(string, "Disabled")
  })
  default     = {}
  description = <<OS_DISK_MANAGED_DISK
This variable is an object used to define the managed disk settings for the OS disk of the virtual machine.

- `network_access_policy` (Optional) - Policy for accessing the disk via network. Allowed values are AllowAll, AllowPrivate, and DenyAll.
- `public_network_access_enabled` (Optional) - Whether it is allowed to access the disk via public network. Defaults to Disabled.

```hcl
os_disk_managed_disk = {
  network_access_policy = "AllowPrivate"
  public_network_access_enabled = "Enabled"
}
```

OS_DISK_MANAGED_DISK
}

variable "data_disk_managed_disks" {
  type = map(object({
    caching                                   = string
    lun                                       = number
    name                                      = string
    storage_account_type                      = string
    create_option                             = optional(string, "Empty")
    disk_access_resource_id                   = optional(string)
    disk_attachment_create_option             = optional(string)
    disk_encryption_set_resource_id           = optional(string) #this is currently a preview feature in the provider
    disk_iops_read_only                       = optional(number, null)
    disk_iops_read_write                      = optional(number, null)
    disk_mbps_read_only                       = optional(number, null)
    disk_mbps_read_write                      = optional(number, null)
    disk_size_gb                              = optional(number, 128)
    edge_zone                                 = optional(string, null)
    gallery_image_reference_resource_id       = optional(string)
    hyper_v_generation                        = optional(string)
    image_reference_resource_id               = optional(string)
    inherit_tags                              = optional(bool, true)
    lock_level                                = optional(string, null)
    lock_name                                 = optional(string, null)
    logical_sector_size                       = optional(number, null)
    max_shares                                = optional(number)
    network_access_policy                     = optional(string)
    on_demand_bursting_enabled                = optional(bool)
    optimized_frequent_attach_enabled         = optional(bool, false)
    os_type                                   = optional(string)
    performance_plus_enabled                  = optional(bool, false)
    public_network_access_enabled             = optional(bool, false)
    resource_group_name                       = optional(string)
    secure_vm_disk_encryption_set_resource_id = optional(string)
    security_type                             = optional(string)
    source_resource_id                        = optional(string)
    source_uri                                = optional(string)
    storage_account_resource_id               = optional(string)
    tags                                      = optional(map(string), null)
    tier                                      = optional(string)
    trusted_launch_enabled                    = optional(bool)
    upload_size_bytes                         = optional(number, null)
    write_accelerator_enabled                 = optional(bool)

    encryption_settings = optional(list(object({
      disk_encryption_key_vault_secret_url  = optional(string)
      disk_encryption_key_vault_resource_id = optional(string)
      key_encryption_key_vault_secret_url   = optional(string)
      key_encryption_key_vault_resource_id  = optional(string)
    })), [])

    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
  }))
  default     = {}
  description = <<DATA_DISK_MANAGED_DISKS
This variable is a map of objects used to define one or more data disks for creation and attachment to the virtual machine.

- `<map key>` - Use a custom map key to define each data disk
  - `caching` (Required) - Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite
  - `lun` (Required) - The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created.
  - `name` (Required) - Specifies the name of the Managed Disk. Changing this forces a new resource to be created.
  - `storage_account_type` (Required) - The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS
  - `create_option` (Optional) - The method to use when creating the managed disk. Changing this forces a new resource to be created. Possible values include: 1. Import - Import a VHD file in to the managed disk (VHD specified with source_uri). 2.ImportSecure - Securely import a VHD file in to the managed disk (VHD specified with source_uri). 3. Empty - Create an empty managed disk. 4. Copy - Copy an existing managed disk or snapshot (specified with source_resource_id). 5. FromImage - Copy a Platform Image (specified with image_reference_id) 6. Restore - Set by Azure Backup or Site Recovery on a restored disk (specified with source_resource_id). 7. Upload - Upload a VHD disk with the help of SAS URL (to be used with upload_size_bytes).
  - `disk_access_resource_id` (Optional) - The ID of the disk access resource for using private endpoints on disks. disk_access_resource_id is only supported when network_access_policy is set to AllowPrivate.
  - `disk_attachment_create_option` (Optional) - The disk attachment create Option of the Data Disk, such as Empty or Attach. Defaults to Attach. Changing this forces a new resource to be created.
  - `disk_encryption_set_resource_id` (Optional) - The resource ID of the Disk Encryption Set which should be used to Encrypt this OS Disk.
  - `disk_iops_read_only` (Optional) - The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. One operation can transfer between 4k and 256k bytes.
  - `disk_iops_read_write` (Optional) - The number of IOPS allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. One operation can transfer between 4k and 256k bytes.
  - `disk_mbps_read_only` (Optional) - The bandwidth allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. MBps means millions of bytes per second.
  - `disk_mbps_read_write` (Optional) - The bandwidth allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. MBps means millions of bytes per second.
  - `disk_size_gb` (Optional) - (Required for a new managed disk) - Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased.If No Downtime Resizing is not available, be aware that changing this value is disruptive if the disk is attached to a Virtual Machine. The VM will be shut down and de-allocated as required by Azure to action the change. Terraform will attempt to start the machine again after the update if it was in a running state when the apply was started. When upgrading disk_size_gb from value less than 4095 to a value greater than 4095, the disk will be detached from its associated Virtual Machine as required by Azure to action the change. Terraform will attempt to reattach the disk again after the update.
  - `gallery_image_reference_resource_id` (Optional) - ID of a Gallery Image Version to copy when create_option is FromImage. This field cannot be specified if image_reference_id is specified. Changing this forces a new resource to be created.
  - `hyper_v_generation` (Optional) - The HyperV Generation of the Disk when the source of an Import or Copy operation targets a source that contains an operating system. Possible values are V1 and V2. For ImportSecure it must be set to V2. Changing this forces a new resource to be created.
  - `image_reference_resource_id` (Optional) - ID of an existing platform/marketplace disk image to copy when create_option is FromImage. This field cannot be specified if gallery_image_reference_resource_id is specified. Changing this forces a new resource to be created.
  - `inherit_tags` (Optional) - Defaults to true.  Set this to false if only the tags defined on this resource should be applied.
  - `lock_level` (Optional) - Set this value to override the resource level lock value.  Possible values are `CanNotDelete`, and `ReadOnly`.
  - `lock_name` (Optional) - The name for the lock on this disk
  - `logical_sector_size` (Optional) - Logical Sector Size. Possible values are: 512 and 4096. Defaults to 4096. Changing this forces a new resource to be created. Setting logical sector size is supported only with UltraSSD_LRS disks and PremiumV2_LRS disks.
  - `max_shares` (Optional) - The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time. Premium SSD maxShares limit: P15 and P20 disks: 2. P30,P40,P50 disks: 5. P60,P70,P80 disks: 10. For ultra disks the max_shares minimum value is 1 and the maximum is 5.
  - `network_access_policy` (Optional) - Policy for accessing the disk via network. Allowed values are AllowAll, AllowPrivate, and DenyAll.
  - `on_demand_bursting_enabled` (Optional) - Specifies if On-Demand Bursting is enabled for the Managed Disk.
  - `optimized_frequent_attach_enabled` (Optional) - Specifies whether this Managed Disk should be optimized for frequent disk attachments (where a disk is attached/detached more than 5 times in a day). Defaults to false. Setting optimized_frequent_attach_enabled to true causes the disks to not align with the fault domain of the Virtual Machine, which can have operational implications.
  - `os_type` (Optional) - Specify a value when the source of an Import, ImportSecure or Copy operation targets a source that contains an operating system. Valid values are Linux or Windows.
  - `performance_plus_enabled` (Optional) - Specifies whether Performance Plus is enabled for this Managed Disk. Defaults to false. Changing this forces a new resource to be created. performance_plus_enabled can only be set to true when using a Managed Disk with an Ultra SSD.
  - `public_network_access_enabled` (Optional) - Whether it is allowed to access the disk via public network. Defaults to true.
  - `resource_group_name` (Optional) - Specify a resource group name if the data disk should be created in a separate resource group from the virtual machine
  - `secure_vm_disk_encryption_set_resource_id` (Optional) - The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with disk_encryption_set_id. Changing this forces a new resource to be created. secure_vm_disk_encryption_set_resource_id can only be specified when security_type is set to ConfidentialVM_DiskEncryptedWithCustomerKey.
  - `security_type` (Optional) - Security Type of the Managed Disk when it is used for a Confidential VM. Possible values are ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithPlatformKey and ConfidentialVM_DiskEncryptedWithCustomerKey. Changing this forces a new resource to be created. When security_type is set to ConfidentialVM_DiskEncryptedWithCustomerKey the value of create_option must be one of FromImage or ImportSecure. security_type cannot be specified when trusted_launch_enabled is set to true. secure_vm_disk_encryption_set_id must be specified when security_type is set to ConfidentialVM_DiskEncryptedWithCustomerKey.
  - `source_resource_id` (Optional) - The ID of an existing Managed Disk or Snapshot to copy when create_option is Copy or the recovery point to restore when create_option is Restore. Changing this forces a new resource to be created.
  - `source_uri` (Optional) - URI to a valid VHD file to be used when create_option is Import or ImportSecure. Changing this forces a new resource to be created.
  - `storage_account_resource_id` (Optional) - The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import or ImportSecure. Changing this forces a new resource to be created.
  - `tags` (Optional) - A mapping of tags to assign to the resource.
  - `tier` (Optional) - The disk performance tier to use. Possible values are documented at https://docs.microsoft.com/azure/virtual-machines/disks-change-performance. This feature is currently supported only for premium SSDs.Changing this value is disruptive if the disk is attached to a Virtual Machine. The VM will be shut down and de-allocated as required by Azure to action the change. Terraform will attempt to start the machine again after the update if it was in a running state when the apply was started.
  - `trusted_launch_enabled` (Optional) - Specifies if Trusted Launch is enabled for the Managed Disk. Changing this forces a new resource to be created. Trusted Launch can only be enabled when create_option is FromImage or Import
  - `upload_size_bytes` (Optional) - Specifies the size of the managed disk to create in bytes. Required when create_option is Upload. The value must be equal to the source disk to be copied in bytes. Source disk size could be calculated with ls -l or wc -c. More information can be found at Copy a managed disk. Changing this forces a new resource to be created.
  - `write_accelerator_enabled` (Optional) - Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs. Defaults to false.
  - `encryption_settings` = (Optional) List of encryption objects with the following attributes:
    -  `disk_encryption_key_vault_secret_url` (Required) - The URL to the Key Vault Secret used as the Disk Encryption Key. This can be found as the id on the azurerm_key_vault_secret resource.
    -  `disk_encryption_key_vault_resource_id` (Required) - The ID of the source Key Vault. This can be found as the id on the azurerm_key_vault resource.
    -  `key_encryption_key_vault_secret_url` (Required) - The URL to the Key Vault Key used as the Key Encryption Key. This can be found as the id on the azurerm_key_vault_key resource.
    -  `key_encryption_key_vault_resource_id` (Required) - The ID of the source Key Vault. This can be found as the id on the azurerm_key_vault resource.
  - `role_assignments` = (Optional) - Map of role assignments to assign to this disk
    - `<map key>` - Use a custom map key to define each role assignment configuration assigned to the system managed identity of this virtual machine
      - `role_definition_id_or_name`                 = (Required) - The Scoped-ID of the Role Definition or the built-in role name. Changing this forces a new resource to be created. Conflicts with role_definition_name
      - `scope_resource_id`                          = (Required) - The scope at which the System Managed Identity Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created.
      - `condition`                                  = (Optional) - The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
      - `condition_version`                          = (Optional) - The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.
      - `description`                                = (Optional) - The description for this Role Assignment. Changing this forces a new resource to be created.
      - `skip_service_principal_aad_check`           = (Optional) - If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to true.
      - `delegated_managed_identity_resource_id`     = (Optional) - The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created.
      - `principal_type`                             = (Optional) - The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.

Example Inputs:

```hcl
#Create a new empty disk and attach it as lun 0
data_disk_managed_disks = {
  disk1 = {
    name                 = "testdisk1-win-lun0"
    storage_account_type = "Premium_LRS"
    lun                  = 0
    caching              = "ReadWrite"
    disk_size_gb         = 32
  }
}
```
DATA_DISK_MANAGED_DISKS
  nullable    = false
}

variable "dedicated_host_group_resource_id" {
  type        = string
  default     = null
  description = "(Optional) The Azure Resource ID of the dedicated host group where this virtual machine should run. Conflicts with dedicated_host_resource_id (dedicated_host_group_id on the azurerm provider)"
}

variable "dedicated_host_resource_id" {
  type        = string
  default     = null
  description = "(Optional) The Azure Resource ID of the dedicated host where this virtual machine should run. Conflicts with dedicated_host_group_resource_id (dedicated_host_group_id on the azurerm provider)"
}

variable "disk_controller_type" {
  type        = string
  default     = null
  description = "(Optional) - Specifies the Disk Controller Type used for this Virtual Machine.  Possible values are `SCSI` and `NVME`."

  validation {
    condition     = var.disk_controller_type == null || can(regex("^(SCSI|NVMe)$", var.disk_controller_type))
    error_message = "disk_controller_type must be either `SCSI` or `NVMe`."
  }
}

variable "edge_zone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Machine should exist. Changing this forces a new Virtual Machine to be created."
}

variable "encryption_at_host_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
}

variable "eviction_policy" {
  type        = string
  default     = null
  description = "(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created. This value can only be set when priority is set to Spot"
}

variable "extensions" {
  type = map(object({
    name                        = string
    publisher                   = string
    type                        = string
    type_handler_version        = string
    auto_upgrade_minor_version  = optional(bool)
    automatic_upgrade_enabled   = optional(bool)
    failure_suppression_enabled = optional(bool, false)
    settings                    = optional(string)
    protected_settings          = optional(string)
    provision_after_extensions  = optional(list(string), [])
    tags                        = optional(map(string), null)
    protected_settings_from_key_vault = optional(object({
      secret_url      = string
      source_vault_id = string
    }))
  }))
  # tflint-ignore: terraform_sensitive_variable_no_default
  default     = {}
  description = <<EXTENSIONS
This map of objects is used to create additional `azurerm_virtual_machine_extension` resources, the argument descriptions could be found at [the document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension).

- `<map key>` - Provide a custom key value to define each extension object
  - `name` (Required) - Set a custom name on this value if you want the guest configuration extension to have a custom name
  - `publisher` (Required) - Configure the publisher for the extension to be deployed. The Publisher and Type of Virtual Machine Extensions can be found using the Azure CLI, via: az vm extension image list --location westus -o table
  - `type` (Required) - Configure the type value for the extension to be deployed.
  - `type_handler_version` (Required) - The type handler version for the extension. A common value is 1.0.
  - `auto_upgrade_minor_version` (Optional) - Set this to false to avoid automatic upgrades for minor versions on the extension.  Defaults to true
  - `automatic_upgrade_enabled` (Optional) - Set this to false to avoid automatic upgrades for major versions on the extension.  Defaults to true
  - `failure_suppression_enabled` (Optional) - Should failures from the extension be suppressed? Possible values are true or false. Defaults to false. Operational failures such as not connecting to the VM will not be suppressed regardless of the failure_suppression_enabled value.
  - `settings` (Optional) - The settings passed to the extension, these are specified as a JSON object in a string. Certain VM Extensions require that the keys in the settings block are case sensitive. If you're seeing unhelpful errors, please ensure the keys are consistent with how Azure is expecting them (for instance, for the JsonADDomainExtension extension, the keys are expected to be in TitleCase.)
  - `protected_settings` (Optional) - The protected_settings passed to the extension, like settings, these are specified as a JSON object in a string. Certain VM Extensions require that the keys in the protected_settings block are case sensitive. If you're seeing unhelpful errors, please ensure the keys are consistent with how Azure is expecting them (for instance, for the JsonADDomainExtension extension, the keys are expected to be in TitleCase.)
  - `provision_after_extensions` (Optional) - list of strings that specifies the collection of extension names after which this extension needs to be provisioned.
  - `protected_settings_from_key_vault` (Optional) object for protected settings.  Cannot be used with `protected_settings`
    - `secret_url` (Required) - The Secret URL of a Key Vault Certificate. This can be sourced from the `secret_id` field within the `azurerm_key_vault_certificate` Resource.
    - `source_vault_id` (Required) - the Azure resource ID of the key vault holding the secret
  - `tags` (Optional) - A mapping of tags to assign to the extension resource.

Example Inputs:

```hcl
#custom script extension example - linux
extensions = {
  {
    name = "CustomScriptExtension"
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"
    settings = <<SETTINGS
      {
        "script": "<base 64 encoded script file>"
      }
    SETTINGS
  }
}

#custom script extension example - windows
extensions = {
  {
    name = "CustomScriptExtension"
    publisher = "Microsoft.Compute"
    type = "CustomScriptExtension"
    type_handler_version = "1.10"
    settings = <<SETTINGS
      {
        "timestamp":123456789
      }
    SETTINGS
    protected_settings = <<PROTECTED_SETTINGS
      {
        "commandToExecute": "myExecutionCommand",
        "storageAccountName": "myStorageAccountName",
        "storageAccountKey": "myStorageAccountKey",
        "managedIdentity" : {},
        "fileUris": [
            "script location"
        ]
      }
    PROTECTED_SETTINGS
  }
}
```
EXTENSIONS
  nullable    = false
  sensitive   = true # Because `protected_settings` is sensitive

  validation {
    condition = length(var.extensions) == length(distinct([
      for e in var.extensions : e.type
    ]))
    error_message = "`type` in `vm_extensions` must be unique."
  }
}

variable "guest_attestation_extension" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
  Set this value to true if the deployment should create a guest attestation extension for the virtual machine.
  This extension is used to verify the integrity of the virtual machine and its boot process. It is particularly useful for ensuring that the VM has not been tampered with and is running a trusted configuration.
  it also needs vTPM and Secureboot enabled, they are also on by default.

  DESCRIPTION
}

variable "extensions_time_budget" {
  type        = string
  default     = "PT1H30M"
  description = "(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (`PT1H30M`)."
}

variable "gallery_applications" {
  type = map(object({
    version_id             = string
    configuration_blob_uri = optional(string)
    order                  = optional(number, 0)
    tag                    = optional(string)
  }))
  default     = {}
  description = <<GALLERY_APPLICATIONS
A list of gallery application objects with the following elements:

- `<map key>` - Used to designate a unique instance for a gallery application.
  - `version_id` (Required) Specifies the Gallery Application Version resource ID.
  - `configuration_blob_uri` (Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
  - `order` (Optional) Specifies the order in which the packages have to be installed. Possible values are between `0` and `2,147,483,647`.
  - `tag` (Optional) Specifies a passthrough value for more generic context. This field can be any valid `string` value.

Example Inputs:

```hcl
gallery_applications = {
  application_1 = {
    version_id = "/subscriptions/{subscriptionId}/resourceGroups/<resource group>/providers/Microsoft.Compute/galleries/{gallery name}/applications/{application name}/versions/{version}"
    order      = 1
  }
}
```
GALLERY_APPLICATIONS
  nullable    = false
}

variable "generate_admin_password" {
  type        = bool
  default     = false
  description = "Set this value to true if the deployment should create a strong password for the admin user."
}

variable "generated_secrets_key_vault_secret_config" {
  type = object({
    key_vault_resource_id          = string
    name                           = optional(string, null)
    expiration_date_length_in_days = optional(number, 45)
    content_type                   = optional(string, "text/plain")
    not_before_date                = optional(string, null)
    tags                           = optional(map(string), {})
  })
  default     = null
  description = <<DESCRIPTION
For simplicity this module provides the option to use an auto-generated admin user password.  That password or key is then stored in a key vault provided in the `admin_credential_key_vault_resource_id` input. This variable allows the user to override the configuration for the key vault secret which stores the generated password or ssh key. The object details are:

- `name` - (Optional) - The name to use for the key vault secret that stores the auto-generated ssh key or password
- `expiration_date_length_in_days` - (Optional) - This value sets the number of days from the installation date to set the key vault expiration value. It defaults to `45` days.  This value will not be overridden in subsequent runs. If you need to maintain this virtual machine resource for a long period, generate and/or use your own password or ssh key.
- `content_type` - (Optional) - This value sets the secret content type.  Defaults to `text/plain`
- `not_before_date` - (Optional) - The UTC datetime (Y-m-d'T'H:M:S'Z) date before which this key is not valid.  Defaults to null.
- `tags` - (Optional) - Specific tags to assign to this secret resource
DESCRIPTION
}

variable "guest_configuration_extension" {
  type        = bool
  default     = false
  description = "(Optional) Set this value to true if the deployment should create a guest configuration extension for the virtual machine, this will also make sure you get a system assigned identity, since its required for this extension."
}

variable "license_type" {
  type        = string
  default     = null
  description = "(Optional) For Linux virtual machine specifies the BYOL Type for this Virtual Machine, possible values are `RHEL_BYOS` and `SLES_BYOS`. For Windows virtual machine specifies the type of on-premise license (also known as [Azure Hybrid Use Benefit](https://docs.microsoft.com/windows-server/get-started/azure-hybrid-benefit)) which should be used for this Virtual Machine, possible values are `None`, `Windows_Client` and `Windows_Server`."
}

variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default     = {}
  description = <<IDENTITY
An object that sets the managed identity configuration for the virtual machine being deployed. Be aware that capabilities such as the Azure Monitor Agent and Role Assignments require that a managed identity has been configured.

- `system_assigned`            = (Optional) Specifies whether the System Assigned Managed Identity should be enabled.  Defaults to false.
- `user_assigned_resource_ids` = (Optional) Specifies a set of User Assigned Managed Identity IDs to be assigned to this Virtual Machine.

Example Inputs:
```hcl
#default system managed identity
managed_identities = {
  system_assigned = true
}
#user assigned managed identity only
managed_identities           = {
  user_assigned_resource_ids = ["<azure resource ID of a user assigned managed identity>"]
}
#user assigned and system assigned managed identities
managed_identities  = {
  system_assigned            = true
  user_assigned_resource_ids = ["<azure resource ID of a user assigned managed identity>"]
}
```
IDENTITY
  nullable    = false
}

variable "max_bid_price" {
  type        = number
  default     = -1
  description = "(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the `eviction_policy`. Defaults to `-1`, which means that the Virtual Machine should not be evicted for price reasons. This can only be configured when `priority` is set to `Spot`."
}

variable "os_disk" {
  type = object({
    caching                          = string
    storage_account_type             = string
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool, false)
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string, "CacheDisk")
    }), null)
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_ZRS"
  }
  description = <<OS_DISK
Required configuration values for the OS disk on the virtual machine.

- `caching`                          = (Required) - The type of caching which should be used for the internal OS disk.  Possible values are `None`, `ReadOnly`, and `ReadWrite`.
- `storage_account_type`             = (Required) - The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `Premium_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`. Changing this forces a new resource to be created
- `disk_encryption_set_id`           = (Optional) - The Azure Resource ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with secure_vm_disk_encryption_set_id. The Disk Encryption Set must have the Reader Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault
- `disk_size_gb`                     = (Optional) - The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
- `name`                             = (Optional) - The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
- `secure_vm_disk_encryption_set_id` = (Optional) - The Azure Resource ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with disk_encryption_set_id. Changing this forces a new resource to be created.
- `security_encryption_type`         = (Optional) - Encryption Type when the Virtual Machine is a Confidential VM. Possible values are `VMGuestStateOnly` and `DiskWithVMGuestState`. Changing this forces a new resource to be created. `vtpm_enabled` must be set to true when security_encryption_type is specified. encryption_at_host_enabled cannot be set to `true` when security_encryption_type is set to `DiskWithVMGuestState`
- `write_accelerator_enabled`        = (Optional) - Should Write Accelerator be Enabled for this OS Disk? Defaults to `false`. This requires that the storage_account_type is set to `Premium_LRS` and that caching is set to `None`
- `diff_disk_settings` - An optional object defining the diff disk settings
  - `option`    = (Required) - Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is `Local`. Changing this forces a new resource to be created.
  - `placement` = (Optional) - Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.

Example Inputs:

```hcl
#basic example:
os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Premium_LRS"
}

#increased disk size and write acceleration example
os_disk = {
  name                      = "sample os disk"
  caching                   = "None"
  storage_account_type      = "Premium_LRS"
  disk_size_gb              = 128
  write_accelerator_enabled = true
}
```
OS_DISK
  nullable    = false
}

variable "patch_assessment_mode" {
  type        = string
  default     = "AutomaticByPlatform"
  description = "(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are `AutomaticByPlatform` or `ImageDefault`. Defaults to `AutomaticByPlatform`."
}

variable "patch_mode" {
  type        = string
  default     = null
  description = "(Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are `AutomaticByPlatform` and `ImageDefault`. Defaults to `ImageDefault`. For more information on patch modes please see the [product documentation](https://docs.microsoft.com/azure/virtual-machines/automatic-vm-guest-patching#patch-orchestration-modes)."
}

variable "plan" {
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  default     = null
  description = <<PLAN
An object variable that defines the Marketplace image this virtual machine should be created from. If you use the plan block with one of Microsoft's marketplace images (e.g. publisher = "MicrosoftWindowsServer"). This may prevent the purchase of the offer. An example Azure API error: The Offer: 'WindowsServer' cannot be purchased by subscription: '12345678-12234-5678-9012-123456789012' as it is not to be sold in market: 'US'. Please choose a subscription which is associated with a different market.

- `name`      = (Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
- `product`   = (Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
- `publisher` = (Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.

Example Input:

```hcl
plan = {
  name      = "17_04_02-payg-essentials"
  product   = "cisco-8000v"
  publisher = "cisco"
}
```
PLAN
}

variable "platform_fault_domain" {
  type = number
  # Why use `null` instead of [`-1`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine#platform_fault_domain) as default value? `platform_fault_domain` must be set along with `virtual_machine_scale_set_id` so the default value must be `null` for this module if we don't want to use `virtual_machine_scale_set_id`.
  default     = null
  description = "(Optional) Specifies the Platform Fault Domain in which this Virtual Machine should be created. Defaults to `null`, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. `virtual_machine_scale_set_id` is required with it. Changing this forces new Virtual Machine to be created."
}

variable "priority" {
  type        = string
  default     = "Regular"
  description = "(Optional) Specifies the priority of this Virtual Machine. Possible values are `Regular` and `Spot`. Defaults to `Regular`. Changing this forces a new resource to be created."
}

variable "provision_vm_agent" {
  type        = bool
  default     = true
  description = "(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to `true`. Changing this forces a new resource to be created. If `provision_vm_agent` is set to `false` then `allow_extension_operations` must also be set to `false`."
}

variable "proximity_placement_group_resource_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Proximity Placement Group which the Virtual Machine should be assigned to. Conflicts with `capacity_reservation_group_resource_id`."
}

variable "reboot_setting" {
  type        = string
  default     = null
  description = "(Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform"
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    description                            = optional(string, null)
    principal_type                         = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)

    }
  ))
  default     = {}
  description = <<VIRTUAL_MACHINE_ROLE_ASSIGNMENTS
A map of role definitions and scopes to be assigned as part of this resources implementation.  Two forms are supported. Assignments against this virtual machine resource scope and assignments to external resource scopes using the system managed identity.

- `<map key>` - Use a custom map key to define each role assignment configuration for this virtual machine
  - `principal_id`                               = (optional) - The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created.
  - `role_definition_id_or_name`                 = (Optional) - The Scoped-ID of the Role Definition or the built-in role name. Changing this forces a new resource to be created. Conflicts with role_definition_name
  - `condition`                                  = (Optional) - The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
  - `condition_version`                          = (Optional) - The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.
  - `description`                                = (Optional) - The description for this Role Assignment. Changing this forces a new resource to be created.
  - `skip_service_principal_aad_check`           = (Optional) - If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
  - `delegated_managed_identity_resource_id`     = (Optional) - The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created.
  - `principal_type`                             = (Optional) - The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.

Example Inputs:

```hcl
#typical assignment example. It is also common for the scope resource ID to be a terraform resource reference like azurerm_resource_group.example.id
role_assignments = {
  role_assignment_1 = {
    #assign a built-in role to the virtual machine
    role_definition_id_or_name                 = "Storage Blob Data Contributor"
    principal_id                               = data.azuread_client_config.current.object_id
    description                                = "Example for assigning a role to an existing principal for the virtual machine scope"
  }
}
```
VIRTUAL_MACHINE_ROLE_ASSIGNMENTS
  nullable    = false
}

variable "role_assignments_system_managed_identity" {
  type = map(object({
    role_definition_id_or_name             = string
    scope_resource_id                      = string
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
    }
  ))
  default     = {}
  description = <<SYSTEM_MANAGED_IDENTITY_ROLE_ASSIGNMENTS
A map of role definitions and scopes to be assigned as part of this resources implementation.  Two forms are supported. Assignments against this virtual machine resource scope and assignments to external resource scopes using the system managed identity.

- `<map key>` - Use a custom map key to define each role assignment configuration assigned to the system managed identity of this virtual machine
  - `role_definition_id_or_name`                 = (Required) - The Scoped-ID of the Role Definition or the built-in role name. Changing this forces a new resource to be created. Conflicts with role_definition_name
  - `scope_resource_id`                          = (Required) - The scope at which the System Managed Identity Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created.
  - `condition`                                  = (Optional) - The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
  - `condition_version`                          = (Optional) - The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.
  - `description`                                = (Optional) - The description for this Role Assignment. Changing this forces a new resource to be created.
  - `skip_service_principal_aad_check`           = (Optional) - If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
  - `delegated_managed_identity_resource_id`     = (Optional) - The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created.
  - `principal_type`                             = (Optional) - The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.
Example Inputs:

```hcl
#typical assignment example. It is also common for the scope resource ID to be a terraform resource reference like azurerm_resource_group.example.id
role_assignments_system_managed_identity = {
  role_assignment_1 = {
    #assign a built-in role to the system assigned managed identity
    scope_resource_id                          = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/test_resource_group/providers/Microsoft.Storage/storageAccounts/examplestorageacct"
    role_definition_id_or_name                 = "Storage Blob Data Contributor"
    description                                = "Example for assigning a role to the vm system managed identity"
  }
}
```
SYSTEM_MANAGED_IDENTITY_ROLE_ASSIGNMENTS
  nullable    = false
}

variable "secrets" {
  type = list(object({
    key_vault_id = string
    certificate = set(object({
      url   = string
      store = optional(string)
    }))
  }))
  default     = []
  description = <<SECRETS
A list of objects defining VM secrets with the following attributes:

- `key_vault_id` = (Required) The ID of the Key Vault from which all Secrets should be sourced.
- `certificate`  = A set of object describing the secret certificate using the following attributes:
  - `url`   = (Required) The Secret URL of a Key Vault Certificate. This can be sourced from the `secret_id` field within the `azurerm_key_vault_certificate` Resource.
  - `store` = (Optional) The certificate store on the Virtual Machine where the certificate should be added. Required when use with Windows Virtual Machine.

Example Inputs:

```hcl
secrets = [
  {
    key_vault_id = azurerm_key_vault.example.id
    certificate = [
      {
        url = azurerm_key_vault_certificate.example.secret_id
        store = "My"
      }
    ]
  }
]
```
SECRETS
  nullable    = false
}

variable "secure_boot_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created, defaults to true."
}

variable "shutdown_schedules" {
  type = map(object({
    daily_recurrence_time = string
    notification_settings = optional(object({
      enabled         = optional(bool, false)
      email           = optional(string, null)
      time_in_minutes = optional(string, "30")
      webhook_url     = optional(string, null)
    }), { enabled = false })
    timezone = string
    enabled  = optional(bool, true)
    tags     = optional(map(string), null)
  }))
  default     = {}
  description = <<SHUTDOWN_SCHEDULES
This map of objects describes an auto-shutdown schedule for the virtual machine.  The default is to not have a shutdown schedule.

- `<map key>` - Use a custom map key for the shutdown schedule definition
  - `daily_recurrence_time` = (Required) The time each day when the schedule takes effect. Must match the format HHmm where HH is 00-23 and mm is 00-59 (e.g. 0930, 2300, etc.)
  - `enabled` = (Required) Designates whether the shutdown schedule is enabled.  Defaults to true when a schedule is configured.
  - `notification_settings` = (Required) The notification setting object for this schedule.
    - `enabled` = (Required) Whether to enable pre-shutdown notifications.  Possible values are true or false.
    - `email` = (Optional) = Email address or multiple email addresses separated by a semi-colon where the notification emails will be sent.
    - `time_in_minutes` = (Optional) TIme in minutes between 15 and 120 before a shutdown event at which a notification will be sent.  Defaults to "30".
    - `webhook_url` = (Optional) The webhook URL to which notifications will be sent.
  - `tags` = (Optional) - Tags to apply to the shutdown schedules resource.
  - `timezone` = (Required) - The time zone ID (e.g. Pacific Standard time).

Example Input:
```hcl
  shutdown_schedules = {
    test_schedule = {
      daily_recurrence_time = "1700"
      enabled               = true
      timezone              = "Pacific Standard Time"
      notification_settings = {
        enabled         = true
        email           = "example@example.com;example2@example.com"
        time_in_minutes = "15"
        webhook_url     = "https://example-webhook-url.example.com"
      }
    }
  }

```
SHUTDOWN_SCHEDULES
}

variable "sku_size" {
  type        = string
  default     = "Standard_D2ds_v5"
  description = "The sku value to use for this virtual machine"
  nullable    = false
}

variable "os_type" {
  type        = string
  default     = null
  description = "The base OS type of the vm to be built.  Valid answers are Windows or Linux"

  validation {
    condition     = can(regex("^(windows|linux)$", lower(var.os_type)))
    error_message = "Valid OS type values are Windows or Linux."
  }
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  #default     = null
  default = {
    publisher = null
    offer     = null
    sku       = null
    version   = "latest"
  }
  description = <<SOURCE_IMAGE_REFERENCE
The source image to use when building the virtual machine. Either `source_image_resource_id` or `source_image_reference` must be set and both can not be null at the same time.

- `publisher` = (Required) Specifies the publisher of the image this virtual machine should be created from.  Changing this forces a new virtual machine to be created.
- `offer`     = (Required) Specifies the offer of the image used to create this virtual machine.  Changing this forces a new virtual machine to be created.
- `sku`       = (Required) Specifies the sku of the image used to create this virutal machine.  Changing this forces a new virtual machine to be created.
- `version`   = (Required) Specifies the version of the image used to create this virutal machine.  Changing this forces a new virtual machine to be created.

Example Inputs:

```hcl
#Linux example:
source_image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts"
  version   = "latest"
}

#Windows example:
source_image_reference = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}
```
SOURCE_IMAGE_REFERENCE
}

variable "source_image_resource_id" {
  type        = string
  default     = null
  description = "The Azure resource ID of the source image used to create the VM. Either `source_image_resource_id` or `source_image_reference` must be set and both can not be null at the same time."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Map of tags to be assigned to this resource"
}

variable "termination_notification" {
  type = object({
    enabled = optional(bool, false)
    timeout = optional(string, "PT5M")
  })
  default     = null
  description = <<TERMINATION_NOTIFICATION
optional Termination notification object with the following attributes:

- `enabled` = (Optional) - Should the termination notification be enabled on this Virtual Machine? Defaults to false
- `timeout` = (Optional) - Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format. Defaults to PT5M.

Example Inputs:

```hcl
termination_notification = {
  enabled = true
  timeout = "PT5M"
}
```
TERMINATION_NOTIFICATION
}

variable "user_data" {
  type        = string
  default     = null
  description = "(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."

  validation {
    condition     = var.user_data == null ? true : can(base64decode(var.user_data))
    error_message = "`user_data` must be either `null` or valid base64 encoded string."
  }
}

variable "virtual_machine_scale_set_resource_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Conflicts with `availability_set_id`. Changing this forces a new resource to be created."
}

variable "vm_additional_capabilities" {
  type = object({
    ultra_ssd_enabled  = optional(bool, false)
    hiberation_enabled = optional(bool, null)
  })
  default     = null
  description = <<VM_ADDITIONAL_CAPABILITIES
Object describing virtual machine additional capabilities using the following attributes:

- `ultra_ssd_enabled` = (Optional) Should the capacity to enable Data Disks of the `UltraSSD_LRS` storage account type be supported on this Virtual Machine? Defaults to `false`.
- `hibernation_enabled = (Optional) Whether to enable the hiberation capability or not.

Example Inputs:

```hcl
vm_additional_capabilities = {
  ultra_ssd_enabled = true
}
```
VM_ADDITIONAL_CAPABILITIES
}

variable "vtpm_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created, defaults to true."
}
