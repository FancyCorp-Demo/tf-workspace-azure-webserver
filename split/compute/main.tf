terraform {
  cloud {
    organization = "fancycorp"

    workspaces {
      tags = ["webserver", "platform:azure", "component:compute"]
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

data "tfe_outputs" "network" {
  organization = "fancycorp"
  workspace    = var.network_workspace
}

output "upstream" {
  value = data.tfe_outputs.network.nonsensitive_values
}

locals {
  resource_group = data.tfe_outputs.network.nonsensitive_values.resource_group
}


# TODO: all of this
# https://github.com/FancyCorp-Demo/terraform-azure-webserver/blob/main/main.tf#L36-L145

resource "azurerm_public_ip" "example" {
  name                = "strawbtest-public-ip"
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  allocation_method   = "Static"
}
