variable "hotpatching_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the VM be patched without requiring a reboot? Possible values are `true` or `false`. Defaults to `false`. For more information about hot patching please see the [product documentation](https://docs.microsoft.com/azure/automanage/automanage-hotpatch). Hotpatching can only be enabled if the `patch_mode` is set to `AutomaticByPlatform`, the `provision_vm_agent` is set to `true`, your `source_image_reference` references a hotpatching enabled image, and the VM's `size` is set to a [Azure generation 2](https://docs.microsoft.com/azure/virtual-machines/generation-2#generation-2-vm-sizes) VM. An example of how to correctly configure a Windows Virtual Machine to use the `hotpatching_enabled` field can be found in the [`./examples/virtual-machines/windows/hotpatching-enabled`](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/virtual-machines/windows/hotpatching-enabled) directory within the GitHub Repository."
}

variable "timezone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Time Zone which should be used by the Windows Virtual Machine, [the possible values are defined here](https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/). Changing this forces a new resource to be created."
}

variable "enable_automatic_updates" {
  type        = bool
  default     = true
  description = "(Optional) Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created. Defaults to `true`."
}

variable "winrm_listeners" {
  type = object({
    https_listener_with_self_signed_cert = optional(bool, false)
    listeners = optional(set(object({
      protocol        = string
      certificate_url = optional(string)
    })), [])
  })
  default     = {}
  description = <<WINRM_LISTENERS

- `https_listener_with_self_signed_cert` = (optional) Boolean value to enable winrm over https without supplyig a certificate url
- `listeners`       = (optional) Set of objects describing the winRM listener configuration for windows VM's using the following attributes:
- `protocol`        = (Required) Specifies Specifies the protocol of listener. Possible values are `Http` or `Https`
- `certificate_url` = (Optional) The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https`. Changing this forces a new resource to be created.

Example Inputs:

```hcl
#https example
winrm_listeners = {
  listeners = [
    {
    protocol = "Https"
    certificate_url = data.azurerm_keyvault_secret.example.secret_id
    }
  ]
}

or without cert url:

winrm_listeners = {
  https_listener_with_self_signed_cert = true
}

#http example
winrm_listeners = {
  listeners = [
    {
    protocol = "Http"
    }
  ]
}
```
WINRM_LISTENERS
  nullable    = false
}

variable "additional_unattend_contents" {
  type = list(object({
    content = string
    setting = string
  }))
  default     = []
  description = <<ADDITIONAL_UNATTEND_CONTENTS
List of objects representing unattend content settings

- `content` (Required) - The XML formatted content that is added to the unattend.xml file for the specified path and component. Changing this forces a new resource to be created.
- `setting` (Required) - The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`. Changing this forces a new resource to be created.

Example Inputs:
```hcl
#Example Reboot
additional_unattend_contents = [
  {
    content = "<FirstLogonCommands><SynchronousCommand><CommandLine>shutdown /r /t 0 /c \"initial reboot\"</CommandLine><Description>reboot</Description><Order>1</Order></SynchronousCommand></FirstLogonCommands>"
    setting = "FirstLogonCommands"
  }
]
```
ADDITIONAL_UNATTEND_CONTENTS
  nullable    = false
}
