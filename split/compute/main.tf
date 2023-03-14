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
  value = nonsensitive(data.tfe_outputs.network)
}

/*
module "webserver" {
  source  = "app.terraform.io/fancycorp/webserver/azure"
  version = "~> 2.0"

 # TODO:
  # subnet_id = ...

  # For an example PR...
  # Standard_B8ms will cause a policy-fail
  machine_size = var.machine_size

  packer_bucket_name = var.packer_bucket_name
  packer_channel     = var.packer_channel
}
*/
