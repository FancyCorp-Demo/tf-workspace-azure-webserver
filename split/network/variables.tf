variable "resource_group_tags" {
  default = {
    Name      = "StrawbTest"
    Owner     = "lucy.davinhart@hashicorp.com"
    Purpose   = "Terraform TFC Demo Org (FancyCorp)"
    TTL       = "24h"
    Terraform = "true"
  }
}

variable "resource_group_name" {
  default = "strawb-demo-webserver"
}

variable "location" {
  default = "UK South"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  default = ["10.0.2.0/24"]
}
