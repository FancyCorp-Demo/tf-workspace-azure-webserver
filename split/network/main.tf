terraform {
  cloud {
    organization = "fancycorp"

    workspaces {
      tags = ["webserver", "platform:azure", "component:network"]
    }
  }
  # Minimum provider version for OIDC auth
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.29.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.25.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
  tags = merge(
    { Workspace = terraform.workspace },
    var.resource_group_tags,
  )
}



#
# Networking
#

resource "azurerm_virtual_network" "example" {
  name                = "strawb-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefixes
}
