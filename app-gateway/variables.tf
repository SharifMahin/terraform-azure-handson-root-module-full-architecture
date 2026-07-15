variable "resource_group_name" {
  type        = string
  description = "Existing resource group name"
}

variable "vnet_name" {
  type        = string
  description = "New VNet name for App Gateway"
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name — dedicated for App Gateway"
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Subnet address prefixes"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name for App Gateway"
}

variable "agw_name" {
  type        = string
  description = "Application Gateway name"
}

variable "backend_fqdns" {
  type        = list(string)
  description = "Backend FQDNs — App Service URL or VM FQDN"
}

variable "tags" {
  type    = map(string)
  default = {}
}