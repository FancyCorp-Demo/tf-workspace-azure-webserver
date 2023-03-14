terraform {
  cloud {
    organization = "fancycorp"

    workspaces {
      tags = ["webserver", "platform:azure"]
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


module "webserver" {
  source  = "app.terraform.io/fancycorp/webserver/azure"
  version = "~> 2.0"

  resource_group_name = "strawb-tfc-demo-${terraform.workspace}"
  location            = "UK South"

  # For an example PR...
  # Standard_B8ms will cause a policy-fail
  machine_size = var.machine_size

  resource_group_tags = {
    Name      = "StrawbTest"
    Owner     = "lucy.davinhart@hashicorp.com"
    Purpose   = "Terraform TFC Demo Org (FancyCorp)"
    TTL       = "24h"
    Terraform = "true"
    Source    = "https://github.com/FancyCorp-Demo/tfcb-setup/tree/main/terraform-azure"
    Workspace = terraform.workspace
  }

  packer_bucket_name = var.packer_bucket_name
  packer_channel     = var.packer_channel
}
