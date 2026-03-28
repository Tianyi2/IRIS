
locals {
  db_prefix = "db"
  db_labels = "node-pool=db"

  dbs = { for inx, zone in local.zones : zone => inx if lookup(try(var.instances[zone], {}), "enabled", false) && lookup(try(var.instances[zone], {}), "db_count", 0) > 0 }
}

module "dbs" {
  for_each = local.dbs

  # source = "../../../sergelogvinov/terraform-proxmox-template-nodegroup"
  source = "github.com/sergelogvinov/terraform-proxmox-template-nodegroup"

  vms         = lookup(try(var.instances[each.key], {}), "db_count", 0)
  id          = lookup(try(var.instances[each.key], {}), "db_id", 9000)
  name        = "${local.db_prefix}-${format("%02d", index(local.zones, each.key))}"
  description = "DB node managed by Terraform"
  cpus        = lookup(try(var.instances[each.key], {}), "db_cpu", 1)
  memory      = lookup(try(var.instances[each.key], {}), "db_mem", 2048)
  hugepages   = 1024

  node                   = each.key
  node_numa_shift        = -1
  node_numa_architecture = lookup(try(var.nodes[each.key], {}), "cpu", [])

  template_id = module.template[each.key].id

  # boot_size      = 64
  boot_datastore = lookup(try(var.nodes[each.key], {}), "storage", "local")

  network_dns = ["1.1.1.1", "2001:4860:4860::8888"]
  network = {
    "vmbr0" = {
      firewall        = lookup(var.security_groups, "db", "") == "" ? false : true
      firewall_groups = lookup(var.security_groups, "db", "")
      ip6             = ""
      ip6subnet       = cidrsubnet(lookup(try(var.nodes[each.key], {}), "ip6", "fe80::/64"), 16, 1 + index(local.zones, each.key))
      ip6mask         = 64
      ip6index        = 512 + lookup(try(var.instances[each.key], {}), "db_id", 9000)
      gw6             = lookup(try(var.nodes[each.key], {}), "gw6", "fe80::1")
    }
    "vmbr1" = {
      mtu       = 1400
      ip6       = ""
      ip6subnet = cidrsubnet(var.vpc_main_cidr[1], 16, index(local.zones, each.key))
      ip6mask   = 64
      ip6index  = 512 + lookup(try(var.instances[each.key], {}), "db_id", 9000)

      ip4       = ""
      ip4subnet = local.subnets[each.key]
      ip4mask   = 24
      ip4index  = 5
      gw4       = cidrhost(local.subnets[each.key], 0)
    }
  }

  cloudinit_datastore = "local"
  cloudinit_region    = var.region
  cloudinit_userdata = templatefile("${path.module}/templates/${lookup(var.instances[each.key], "db_template", "worker.yaml.tpl")}",
    merge(local.kubernetes, try(var.instances["all"], {}), {
      labels      = join(",", compact([local.db_labels, lookup(var.instances[each.key], "db_labels", "")]))
      nodeSubnets = [local.subnets[each.key], var.vpc_main_cidr[1]]
      lbv4        = local.lbv4
      kernelArgs  = []
  }))
}
