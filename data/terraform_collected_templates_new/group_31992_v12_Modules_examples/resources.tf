# Create production virtual machines
module "vm_deployment" {
  for_each                = toset(var.resource_location)
  source                  = "../"
  resource_name           = var.resource_name
  resource_instance_count = var.resource_instance_count
  resource_size           = var.resource_size
  resource_location       = each.value
  deployment              = var.deployment
  network_address         = lookup(var.network_address, each.value, null)
}
