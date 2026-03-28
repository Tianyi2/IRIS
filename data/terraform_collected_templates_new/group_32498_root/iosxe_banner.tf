resource "iosxe_banner" "banner" {
  for_each = { for device in local.devices : device.name => device if try(local.device_config[device.name].banner, null) != null }
  device   = each.value.name

  exec_banner           = try(local.device_config[each.value.name].banner.exec, local.defaults.iosxe.configuration.banner.exec, null)
  login_banner          = try(local.device_config[each.value.name].banner.login, local.defaults.iosxe.configuration.banner.login, null)
  prompt_timeout_banner = try(local.device_config[each.value.name].banner.prompt_timeout, local.defaults.iosxe.configuration.banner.prompt_timeout, null)
  motd_banner           = try(local.device_config[each.value.name].banner.motd, local.defaults.iosxe.configuration.banner.motd, null)
}