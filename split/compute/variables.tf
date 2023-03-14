variable "machine_size" {
  type    = string
  default = "Standard_B1ls"
}

variable "packer_bucket_name" {
  type        = string
  default     = "azure-webserver"
  description = "Which HCP Packer bucket should we pull our Machine Image from?"
}

variable "packer_channel" {
  type        = string
  default     = "production"
  description = "Which HCP Packer channel should we use for our Machine Image?"
}


# TODO: Variable to specify which workspace to use for the vnet ID
