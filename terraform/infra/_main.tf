terraform {
  required_version = ">= 1.0.0"

  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.20.0"
    }
  }
}

provider "azurerm" {
  features {}
}

### Resorce Group

resource "azurerm_resource_group" "perf_test" {
  name     = var.service_name
  location = var.location
  tags     = local.common_tags
}

