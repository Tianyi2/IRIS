variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
  default     = "WebServices"
}

variable "resource_location" {
  description = "Location of resources"
  type        = string
  default     = "UK South"
}

variable "network_name" {
  description = "Name of network"
  type        = string
  default     = "WebServicesNetwork"
}

variable "subnet_name" {
  description = "Name of subnet"
  type        = string
  default     = "WebServicesSubnet"
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

variable "vm_disk_size" {
  description = "Size of vm disk"
  type        = string
  default     = "32"
}

variable "vm_disk_type" {
  description = "Type of vm disk"
  type        = string
  default     = "Standard_LRS"
}

variable "vm_sku" {
  description = "Size of vm"
  type        = string
  default     = "2019-Datacenter-smalldisk"
}

variable "admin_username" {
  description = "Desired username for the provisioned resources"
  type        = string
  default     = "Wesley"
}

variable "admin_password" {
  description = "Desired password for the provisioned resources"
  type        = string
  default     = "sdfhq48SDFdf224sf"
  sensitive   = true
}

variable "vm_environment" {
  description = "Environment of vm"
  type        = string
  default     = "Production"
}

variable "network_address" {
  description = "Network address space"
  type        = string
  default     = "10.0.0.0/22"
}

variable "subnet_address" {
  description = "Subnet prefix"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vm_network_interface" {
  description = "Name of vm ni"
  type        = string
  default     = "Production"
}