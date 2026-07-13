variable "resource_group_name" {
  type        = string
  description = "Existing resource group name"
}

variable "vnet_name" {
  type        = string
  description = "New VNet name for service endpoint"
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Subnet address prefixes"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name — globally unique, lowercase, max 24 chars"
}

variable "container_name" {
  type        = string
  description = "Blob container name"
}

variable "account_tier" {
  type        = string
  description = "Standard or Premium"
  default     = "Standard"
}

variable "replication_type" {
  type        = string
  description = "LRS, GRS, ZRS etc"
  default     = "LRS"
}

variable "tags" {
  type    = map(string)
  default = {}
}