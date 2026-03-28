# data "azurerm_resource_group" "this" {
#   name = (lower(var.os_type) == "linux") ? azurerm_linux_virtual_machine.this[0].resource_group_name : azurerm_windows_virtual_machine.this[0].resource_group_name
# }