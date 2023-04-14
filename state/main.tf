provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "strawb-tf-state"
  location = "UK South"
  tags = {
    Name      = "StrawbTest"
    Owner     = "lucy.davinhart@hashicorp.com"
    Purpose   = "Terraform TFC Demo Org (FancyCorp)"
    TTL       = "24h"
    Terraform = "true"
    Source    = "https://github.com/FancyCorp-Demo/tf-workspace-azure-webserver/tree/oss-to-tfc/state/"
    Workspace = terraform.workspace
  }
}


resource "azurerm_storage_account" "sa" {
  name                     = "strawbtfstate"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}

resource "azurerm_storage_container" "c" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
}
