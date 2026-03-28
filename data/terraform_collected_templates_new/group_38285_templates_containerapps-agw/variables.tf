variable "project_prefix" {
  type        = string
  description = "Project prefix used in the name of the services"
}

variable "environment" {
  type        = string
  description = "Project environment"
}

variable "default_location" {
  type        = string
  description = "Primary location for deploying Azure services"
}

variable "containerappmi_name" {
  type        = string
  description = "Name of the managed identity for container apps"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID"
  sensitive = true
}

variable "analytics_workspace_sku" {
  type        = string
  description = "Logs Analytics Workspace SKU"
}

variable "acr" {
  description = "Azure Container Registry service configuration"
  type = object({
    sku = string
  })
}

variable "aca" {
  description = "Azure Container App service configuration"
  type = object({
    assigned_cpu = number
    assigned_memory = string
    environment_name = string
    prefix_back  = string
    min_replicas = number
    max_replicas = number
    cpu_scaler_type = string
    cpu_scaler_value = string
    memory_scaler_value = string
    memory_scaler_type = string
    zone_redundant = bool
  })
}

variable "agw" {
  description = "Azure Container App service configuration"
  type = object({
    backend_prefix = string
    protocol = string
    # certificate_name = string
    # certificate_key_vault_secret_id = string
  })
}

variable "aca_services" {
  type = list(string)
  default = ["service01","service02","service03","service04","service05"]
  description = "ContainerApps names"
}

variable "alerts" {
  description = "Azure Alerts service configuration"
  type = object({
    cpu_alert_critical_value = number
    cpu_alert_value = number
    memory_alert_value = number
  })
}

variable "tags" {
  type        = map(string)
  description = "Tags for the environment services"
}