
locals {
  worker_prefix = "worker"
  worker_labels = "node-pool=worker"

  workers = { for inx, zone in local.zones : zone => inx if lookup(try(var.instances[zone], {}), "enabled", false) && lookup(try(var.instances[zone], {}), "worker_count", 0) > 0 }
}

module "workers" {
  for_each = local.workers

  # source = "../../../sergelogvinov/terraform-proxmox-template-nodegroup"
  source = "github.com/sergelogvinov/terraform-proxmox-template-nodegroup"

  vms         = lookup(try(var.instances[each.key], {}), "worker_count", 0)
  id          = lookup(try(var.instances[each.key], {}), "worker_id", 9000)
  name        = "${local.worker_prefix}-${format("%02d", index(local.zones, each.key))}"
  description = "Worker node managed by Terraform"
  cpus        = lookup(try(var.instances[each.key], {}), "worker_cpu", 1)
  memory      = lookup(try(var.instances[each.key], {}), "worker_mem", 2048)
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
      firewall        = lookup(var.security_groups, "worker", "") == "" ? false : true
      firewall_groups = lookup(var.security_groups, "worker", "")
      ip6             = ""
      ip6subnet       = cidrsubnet(lookup(try(var.nodes[each.key], {}), "ip6", "fe80::/64"), 16, 1 + index(local.zones, each.key))
      ip6mask         = 64
      ip6index        = 384 + lookup(try(var.instances[each.key], {}), "worker_id", 9000)
      gw6             = lookup(try(var.nodes[each.key], {}), "gw6", "fe80::1")
    }
    "vmbr1" = {
      mtu       = 1400
      ip6       = ""
      ip6subnet = cidrsubnet(var.vpc_main_cidr[1], 16, index(local.zones, each.key))
      ip6mask   = 64
      ip6index  = 384 + lookup(try(var.instances[each.key], {}), "worker_id", 9000)

      ip4       = ""
      ip4subnet = local.subnets[each.key]
      ip4mask   = 24
      ip4index  = 7
      gw4       = cidrhost(local.subnets[each.key], 0)
    }
  }

  cloudinit_datastore = "local"
  cloudinit_region    = var.region
  cloudinit_userdata = templatefile("${path.module}/templates/${lookup(var.instances[each.key], "worker_template", "worker.yaml.tpl")}",
    merge(local.kubernetes, try(var.instances["all"], {}), {
      labels      = join(",", compact([local.worker_labels, lookup(var.instances[each.key], "worker_labels", "")]))
      nodeSubnets = [local.subnets[each.key], var.vpc_main_cidr[1]]
      lbv4        = local.lbv4
      kernelArgs  = []
  }))
}
