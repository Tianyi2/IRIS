# Required resource variables
variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
  default     = "WebServices"
}

variable "traffic_manager_endpoint_locations" {
  description = "Traffic manager endpoint locations"
  type        = list(string)
}

variable "traffic_manager_endpoints" {
  description = "Traffic manager endpoint public ips"
  type        = any
}

variable "traffic_manager_name" {
  description = "Traffic manager name"
  type        = string
}

variable "traffic_manager_location" {
  description = "Traffic manager location"
  type        = string
}

variable "vm_environment" {
  description = "Environment of vm"
  type        = string
  default     = "Production"
}

variable "resource_name" {
  description = "Name of vm"
  type        = string
}