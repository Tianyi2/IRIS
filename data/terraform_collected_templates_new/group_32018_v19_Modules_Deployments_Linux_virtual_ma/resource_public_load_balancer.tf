# Create spoke network dependencies
module "public_load_balancer" {
  source                = "../../Resources/Public_load_balancer"
  resource_location     = azurerm_resource_group.vm_group.location
  resource_group_name   = azurerm_resource_group.vm_group.name
  resource_environment  = var.vm_environment
  resource_name         = local.resource_name
  location_zone_support = local.platform_location_az_count > 1 ? true : false
}
