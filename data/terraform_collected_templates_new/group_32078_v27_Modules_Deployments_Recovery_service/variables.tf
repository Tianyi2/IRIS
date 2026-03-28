# Required resource variables
variable "resource_name" {
  description = "Desired name for the provisioned resources"
  type        = string
}

variable "recovery_services_location" {
  description = "Desired location of the recovery services"
  type        = string
}

variable "recovery_services_name" {
  description = "Desired name of the recovery services"
  type        = string
}

variable "recovery_services_instance_count" {
  description = "Desired number of instances to backup"
  type        = string
}

variable "recovery_services_virtual_machines" {
  description = "The virtual machines available to be backed up"
  type        = any
}