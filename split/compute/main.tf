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
