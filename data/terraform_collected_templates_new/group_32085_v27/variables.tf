variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
  default     = "WebServices"
}

variable "resource_location" {
  description = "Location of resources"
  type        = list(string)
  default = [
    "UK South",
    #"North Central US"
  ]
}

variable "recovery_services_location" {
  description = "Location of recovery services"
  type        = list(string)
  default = [
    "UK South",
  ]
}

variable "resource_name" {
  description = "Name of vm"
  type        = string
  default     = "WEB"
}

variable "resource_size" {
  description = "Size of vm"
  type        = string
  default     = "Standard_B1s"
}

variable "resource_instance_count" {
  description = "Number of vms to deploy"
  type        = string
  default     = 1
}

variable "recovery_services_instance_count" {
  description = "Number of vms to backup"
  type        = string
  default     = 1
}

variable "network_address" {
  description = "Network address space"
  type        = map(string)
  default = {
    "UK South"         = "10.0.0.0/22"
    "North Europe"     = "10.1.0.0/22"
    "North Central US" = "10.2.0.0/22"
  }
}

variable "vm_data_disk_count" {
  description = "Desired size for the provisioned resources for each service"
  type        = number
  default     = 0
}

variable "vm_data_disk_size" {
  description = "Desired disk size for the provisioned data disk resources"
  type        = number
  default     = 32
}

variable "traffic_manager_location" {
  description = "The production resource location for traffic manager to deploy"
  type        = string
  default     = "UK South"
}
