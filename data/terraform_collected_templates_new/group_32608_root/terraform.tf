terraform {
  required_version = ">= 1.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.5, < 5.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 2.0, < 3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}
