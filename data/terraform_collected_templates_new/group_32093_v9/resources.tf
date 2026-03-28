# Create production virtual machines
module "vm_deployment" {
  for_each                = toset(var.resource_location)
  source                  = "./Modules/"
  resource_name           = var.resource_name
  resource_instance_count = var.resource_instance_count
  resource_size           = var.resource_size
  resource_location       = each.value
  deployment              = format("%02d", index(var.resource_location, each.value) + 1)
  network_address         = lookup(var.network_address, each.value, null)
}
