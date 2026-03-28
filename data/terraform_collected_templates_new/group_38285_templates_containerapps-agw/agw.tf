# Dedicated subnet for Application Gateway
resource "azurerm_subnet" "agw_subnet" {
  name                 = "agw-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.41.0/24"]  
}

# Public IP for Application Gateway
resource "azurerm_public_ip" "agw_public_ip" {
  name                = "${var.project_prefix}-agw-public-ip-${var.environment}"
  location            = var.default_location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = var.tags
}

# Definition of Application Gateway
resource "azurerm_application_gateway" "agw" {
  name                = "${var.project_prefix}-agw-${var.environment}"
  location            = var.default_location
  resource_group_name = azurerm_resource_group.rg.name
  enable_http2 = true

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }
  
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.containerapp.id]
  }

  gateway_ip_configuration {
    name      = "gateway_ip_configuration"
    subnet_id = azurerm_subnet.agw_subnet.id
  }

  frontend_ip_configuration {
    name                 = "frontend_ip_configuration"
    public_ip_address_id = azurerm_public_ip.agw_public_ip.id
  }

  frontend_port {
    name = "frontend_port"
    port = 8080
    # port = 443 # use this port if a valid SSL certificate is available
  }

  # # Uncomment this block if there's a valid SSL certificate available
  # ssl_certificate {
  #   name                                       = var.agw.certificate_name
  #   key_vault_secret_id                        = var.agw.certificate_key_vault_secret_id
  # }

  # Backend pools
  dynamic "backend_address_pool" {
    for_each = var.aca_services
    content {
      name = "${var.agw.backend_prefix}-${backend_address_pool.value}-pool"
      fqdns = [azapi_resource.aca_services[backend_address_pool.value].output["properties"]["configuration"]["ingress"]["fqdn"]]
    }
  }

  # Backend Settings
  dynamic "backend_http_settings" {
    for_each = toset(var.aca_services)
    content {
      name                  = "${var.agw.backend_prefix}-${backend_http_settings.value}-http-settings"
      cookie_based_affinity = "Disabled"
      protocol              = "Https"
      port                  = 443
      pick_host_name_from_backend_address = true
      path                  = ""
      probe_name = "${var.agw.backend_prefix}-${backend_http_settings.value}-probe"
    }
  }

  # HTTP(S) Listener (all paths share the same listener)
  http_listener {
    name                           = "http-listener"
    # name                           = "https-listener"
    frontend_ip_configuration_name = "frontend_ip_configuration"
    frontend_port_name             = "frontend_port"
    protocol                       = "Http"
    # protocol                       = "Https"
    # ssl_certificate_name           = var.agw.certificate_name
  }

  # URL Path Map that defines the routes for all services
  url_path_map {
      name = "url-path-map"
      default_backend_address_pool_name = "${var.agw.backend_prefix}-${var.aca_services[0]}-pool"
      default_backend_http_settings_name = "${var.agw.backend_prefix}-${var.aca_services[0]}-http-settings"

      dynamic "path_rule" {
        for_each = toset(var.aca_services)
        content{
          name = "${var.agw.backend_prefix}-${path_rule.value}-path-rule"
          paths = ["/${path_rule.value}/*,/api/v1/${path_rule.value}/*"] # path where the service is running. It can be modified at convenience
          backend_address_pool_name = "${var.agw.backend_prefix}-${path_rule.value}-pool"
          backend_http_settings_name = "${var.agw.backend_prefix}-${path_rule.value}-http-settings"
        }
      }
  }
  
  # Single routing rule for all services
  request_routing_rule {
    name                       = "http-routing-rule"
    # name                       = "https-routing-rule"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "http-listener"
    # http_listener_name         = "https-listener"
    url_path_map_name          = "url-path-map"
    backend_address_pool_name  = "${var.agw.backend_prefix}-${var.aca_services[0]}-pool"
    backend_http_settings_name = "${var.agw.backend_prefix}-http-settings"
    priority                   = 5
  }

  dynamic "probe" {
    for_each                                = toset(var.aca_services)
    content {
      name                                    = "${var.agw.backend_prefix}-${probe.value}-probe"
      protocol                                = "Https"
      path                                    = "/" # Change for actuator path
      interval                                = 30
      timeout                                 = 30
      unhealthy_threshold                     = 3
      pick_host_name_from_backend_http_settings = true
    }
  }

  waf_configuration {
    enabled                  = true
    firewall_mode            = "Detection"
    rule_set_type            = "OWASP"
    rule_set_version         = "3.2"
  }

  depends_on = [
    azurerm_user_assigned_identity.containerapp,
    azurerm_public_ip.agw_public_ip,
    azapi_resource.aca_services
    # azurerm_key_vault_access_policy.policy
  ]
  
  tags = var.tags
}

# # If there's a valid SSL certificate available, uncomment the following blocks
# data "azurerm_client_config" "azconfig" {}

# resource "azurerm_key_vault_access_policy" "policy" {
#   key_vault_id = var.agw.certificate_key_vault_id
#   tenant_id    = data.azurerm_client_config.azconfig.tenant_id
#   object_id    = azurerm_user_assigned_identity.containerapp.principal_id

#   certificate_permissions = [
#     "Get",
#     "List",
#   ]

#   secret_permissions = [
#     "Get",
#     "List",
#   ]

#   depends_on = [
#     azurerm_user_assigned_identity.containerapp
#   ]
# }