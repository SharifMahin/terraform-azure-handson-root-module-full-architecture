variable "resource_group_name" {
  type        = string
  description = "Existing resource group name"
}

variable "vnet_name" {
  type        = string
  description = "New VNet name for private endpoint"
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "subnet_name" {
  type        = string
  description = "New subnet name for private endpoint"
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Subnet address prefixes"
}

variable "storage_account_name" {
  type        = string
  description = "Existing storage account name"
}

variable "private_endpoint_name" {
  type        = string
  description = "Name of the private endpoint"
}

variable "tags" {
  type    = map(string)
  default = {}
}