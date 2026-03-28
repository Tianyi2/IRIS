# Create Azure Container App Environment with azapi resource
resource "azapi_resource" "acae" {
    type = "Microsoft.App/managedEnvironments@2022-03-01"
    parent_id = azurerm_resource_group.rg.id
    location = var.default_location
    name = "${var.project_prefix}-${var.aca.environment_name}-acae-${var.environment}"

    body = {
        properties = {
            appLogsConfiguration = {
                destination = "log-analytics"
                logAnalyticsConfiguration = {
                    customerId = azurerm_log_analytics_workspace.log.workspace_id
                    sharedKey =  azurerm_log_analytics_workspace.log.primary_shared_key
                }
            }
            vnetConfiguration = {
                internal               = true
                infrastructureSubnetId = azurerm_subnet.private.id
                dockerBridgeCidr       = "10.2.0.1/16"
                platformReservedCidr   = "10.1.0.0/16"
                platformReservedDnsIP  = "10.1.0.2"
            }
            zoneRedundant = var.aca.zone_redundant
        }
        tags = var.tags
    }
    depends_on = [
        azurerm_log_analytics_workspace.log, azurerm_subnet.private
    ]
    response_export_values  = ["properties.defaultDomain", "properties.staticIp"]
    ignore_missing_property = true
}

# Container Apps
resource "azapi_resource" "aca_services" {
    for_each = toset(var.aca_services)
    type = "Microsoft.App/containerApps@2022-03-01"
    parent_id = azurerm_resource_group.rg.id
    location = var.default_location
    name = "${var.aca.prefix_back}-${each.value}"

    identity {
        type         = "SystemAssigned, UserAssigned"
        identity_ids = [azurerm_user_assigned_identity.containerapp.id]
    }

    body = {
        properties: {
            managedEnvironmentId = azapi_resource.acae.id
            configuration = {
                ingress = {
                    allowInsecure: false,
                    external: true,
                    targetPort = 80
                }
            }

            template = {
                containers = [
                    {
                        name = "${var.aca.prefix_back}-${each.value}"
                        image = "nginx"
                        resources = {
                            cpu    =  var.aca.assigned_cpu
                            memory =  var.aca.assigned_memory
                        }   
                    }
                ]

                scale = {
                    minReplicas = var.aca.min_replicas
                    maxReplicas = var.aca.max_replicas
                    rules = [
                        {
                            name = "http-scaler"
                            http = {
                                metadata = {
                                    concurrentRequests = "100"
                                }
                            }
                        },
                        {
                            name = "memory-scaler"
                            custom = {
                                type = "memory"
                                metadata = {
                                    type = var.aca.memory_scaler_type
                                    value = var.aca.memory_scaler_value # percentage of average utilization between replicas
                                }
                            }
                        },
                        {
                            name = "cpu-scaler"
                            custom = {
                                type = "cpu"
                                metadata = {
                                    type = var.aca.cpu_scaler_type
                                    value = var.aca.cpu_scaler_value # percentage of average utilization between replicas
                                }
                            }
                        }
                    ]
                }
            }
        }
        tags = var.tags
    }
    depends_on = [
        azapi_resource.acae,
        azurerm_container_registry.acr
    ]
    response_export_values = ["properties.configuration.ingress.fqdn", "properties.latestRevisionFqdn"]
}

# Create private dns zone for backend containers
resource "azurerm_private_dns_zone" "aca_private_dns_zone" {
    name                = azapi_resource.acae.output["properties"]["defaultDomain"]
    resource_group_name = azurerm_resource_group.rg.name
    depends_on = [
        azapi_resource.acae,
    ]
}

# Set VNet link for private backend dns 
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
    name                  = "${var.project_prefix}-acalink-${var.environment}"
    resource_group_name   = azurerm_resource_group.rg.name
    private_dns_zone_name = azurerm_private_dns_zone.aca_private_dns_zone.name
    virtual_network_id    = azurerm_virtual_network.vnet.id
    depends_on = [
        azurerm_private_dns_zone.aca_private_dns_zone
    ]
}

# Set DNS A records for private dns zone

resource "azurerm_private_dns_a_record" "aca_root_record" {
    name                = "@"
    zone_name           = azurerm_private_dns_zone.aca_private_dns_zone.name
    resource_group_name = azurerm_resource_group.rg.name
    ttl                 = 300
    records             = ["${azapi_resource.acae.output["properties"]["staticIp"]}"]    
    depends_on = [
        azurerm_private_dns_zone.aca_private_dns_zone
    ]
}

resource "azurerm_private_dns_a_record" "aca_services_record" {
    name                = "*"
    zone_name           = azurerm_private_dns_zone.aca_private_dns_zone.name
    resource_group_name = azurerm_resource_group.rg.name
    ttl                 = 300
    records             = ["${azapi_resource.acae.output["properties"]["staticIp"]}"]    
    depends_on = [
        azurerm_private_dns_zone.aca_private_dns_zone
    ]
}