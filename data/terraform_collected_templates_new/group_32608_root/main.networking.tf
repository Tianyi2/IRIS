resource "azurerm_public_ip" "virtualmachine_public_ips" {
  for_each = { for key, values in local.nics_ip_configs : key => values if values.ipconfig.create_public_ip_address == true }

  allocation_method       = var.public_ip_configuration_details.allocation_method
  location                = var.location
  name                    = each.value.ipconfig.public_ip_address_name
  resource_group_name     = var.resource_group_name
  ddos_protection_mode    = var.public_ip_configuration_details.ddos_protection_mode
  ddos_protection_plan_id = var.public_ip_configuration_details.ddos_protection_plan_id
  domain_name_label       = var.public_ip_configuration_details.domain_name_label
  edge_zone               = var.edge_zone #var.public_ip_configuration_details.edge_zone
  idle_timeout_in_minutes = var.public_ip_configuration_details.idle_timeout_in_minutes
  ip_version              = var.public_ip_configuration_details.ip_version
  sku                     = var.public_ip_configuration_details.sku
  sku_tier                = var.public_ip_configuration_details.sku_tier
  tags                    = var.public_ip_configuration_details.tags != null && var.public_ip_configuration_details != {} ? var.public_ip_configuration_details.tags : local.tags
  zones                   = var.zone != null ? [var.zone] : [] #var.public_ip_configuration_details.zones
}

resource "azurerm_network_interface" "virtualmachine_network_interfaces" {
  for_each = var.network_interfaces

  location                       = var.location
  name                           = each.value.name
  resource_group_name            = coalesce(each.value.resource_group_name, var.resource_group_name)
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  dns_servers                    = each.value.dns_servers
  edge_zone                      = var.edge_zone #each.value.edge_zone
  internal_dns_name_label        = each.value.internal_dns_name_label
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  tags                           = each.value.tags != null && each.value.tags != {} ? each.value.tags : local.tags

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name                                               = ip_configuration.value.name
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_resource_id
      primary                                            = ip_configuration.value.is_primary_ipconfiguration
      private_ip_address                                 = ip_configuration.value.private_ip_address
      private_ip_address_version                         = ip_configuration.value.private_ip_address_version
      public_ip_address_id                               = ip_configuration.value.create_public_ip_address ? azurerm_public_ip.virtualmachine_public_ips["${each.key}-${ip_configuration.key}"].id : ip_configuration.value.public_ip_address_resource_id
      subnet_id                                          = ip_configuration.value.private_ip_subnet_resource_id
    }
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  for_each = local.nics_nsgs

  network_interface_id      = azurerm_network_interface.virtualmachine_network_interfaces[each.value.nic_key].id
  network_security_group_id = each.value.network_security_groups.network_security_group_resource_id
}

resource "azurerm_network_interface_application_security_group_association" "this" {
  for_each = local.nics_asgs

  application_security_group_id = each.value.application_security_groups.application_security_group_resource_id
  network_interface_id          = azurerm_network_interface.virtualmachine_network_interfaces[each.value.nic_key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  for_each = local.nics_ip_configs_lb_pools

  backend_address_pool_id = each.value.lb_pools.load_balancer_backend_pool_resource_id
  ip_configuration_name   = each.value.ipconfig_name
  network_interface_id    = azurerm_network_interface.virtualmachine_network_interfaces[each.value.nic_key].id
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "this" {
  for_each = local.nics_ip_configs_app_gw_pools

  backend_address_pool_id = each.value.ag_pools.app_gateway_backend_pool_resource_id
  ip_configuration_name   = each.value.ipconfig_name
  network_interface_id    = azurerm_network_interface.virtualmachine_network_interfaces[each.value.nic_key].id
}

resource "azurerm_network_interface_nat_rule_association" "this" {
  for_each = local.nics_ip_configs_lb_nat_rules

  ip_configuration_name = each.value.ipconfig_name
  nat_rule_id           = each.value.lb_nat_rules.load_balancer_nat_rule_resource_id
  network_interface_id  = azurerm_network_interface.virtualmachine_network_interfaces[each.value.nic_key].id
}