# Required resource variables
variable "resource_name" {
  description = "Name of vm"
  type        = string
}

variable "resource_group_name" {
  description = "Desired resource group name for the provisioned resources"
  type        = string
}

variable "resource_environment" {
  description = "Desired environment for the provisioned resources"
  type        = string
}

variable "resource_location" {
  description = "Desired location for the provisioned resources"
  type        = string
}

variable "location_zone_support" {
  description = "Whether the current location supports zones"
  type        = bool
}