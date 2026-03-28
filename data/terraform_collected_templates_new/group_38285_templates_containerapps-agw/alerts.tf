resource "azurerm_monitor_action_group" "ag_services" {
  name                = "services-ag-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "services-ag"

  email_receiver {
    name          = "sendtoadmin"
    email_address = "admin@example.com"
  }

  email_receiver {
    name                    = "sendtodevops"
    email_address           = "devops@example.com"
    use_common_alert_schema = true
  }
}

# Services' alerts for CPU usage
resource "azurerm_monitor_metric_alert" "cpu_usage_services" {
  for_each            = toset(var.aca_services)
  name                = "${var.aca.prefix_back}-${each.value}-cpu-alert-rule-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              =  ["/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/providers/Microsoft.App/containerapps/${var.aca.prefix_back}-${each.value}"]
  description         = "Alert when UsageNanoCores > ${var.alerts.cpu_alert_value}"
  target_resource_type = "Microsoft.App/containerApps"
  severity = 2

  criteria {
    metric_namespace = "Microsoft.App/containerApps"
    metric_name      = "UsageNanoCores"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.alerts.cpu_alert_value
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag_services.id
  }

  depends_on = [
        azapi_resource.aca_services
    ]
}

resource "azurerm_monitor_metric_alert" "cpu_critical_usage_services" {
  for_each            = toset(var.aca_services)
  name                = "${var.aca.prefix_back}-${each.value}-critical-cpu-alert-rule-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              =  ["/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/providers/Microsoft.App/containerapps/${var.aca.prefix_back}-${each.value}"]
  description         = "Alert when UsageNanoCores > ${var.alerts.cpu_alert_critical_value}"
  target_resource_type = "Microsoft.App/containerApps"
  severity = 0

  criteria {
    metric_namespace = "Microsoft.App/containerApps"
    metric_name      = "UsageNanoCores"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.alerts.cpu_alert_critical_value
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag_services.id
  }

  depends_on = [
        azapi_resource.aca_services
    ]
}

resource "azurerm_monitor_metric_alert" "memory_usage_services" {
  for_each            = toset(var.aca_services)
  name                = "${var.aca.prefix_back}-${each.value}-memory-alert-rule-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              =  ["/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/providers/Microsoft.App/containerapps/${var.aca.prefix_back}-${each.value}"]
  description         = "Alert when WorkingSetBytes > ${var.alerts.memory_alert_value}"
  target_resource_type = "Microsoft.App/containerApps"
  severity = 2

  criteria {
    metric_namespace = "Microsoft.App/containerApps"
    metric_name      = "WorkingSetBytes"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.alerts.memory_alert_value
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag_services.id
  }

  depends_on = [
        azapi_resource.aca_services
    ]
}