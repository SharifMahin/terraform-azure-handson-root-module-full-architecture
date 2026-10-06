variable "resource_group_name" {
  type        = string
  description = "Existing resource group name"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name — globally unique, lowercase, max 24 chars, no hypen"
  validation {
    condition     = length(var.storage_account_name) <= 24 && can(regex("^[a-z0-9]+$", var.storage_account_name))
    error_message = "Storage account name must be lowercase alphanumeric only and max 24 characters."
  }
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

variable "container_name" {
  type        = string
  description = "Name of the blob container"
}

variable "tags" {
  type    = map(string)
  default = {}
}