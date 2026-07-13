terraform {
  required_version = ">= 1.3.0" # terraform CLI er version

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # provider er version
    }
  }
}

# not needed as az_cli login
provider "azurerm" {
  # subscription_id = ""
  # tenant_id       = ""
  # client_id       = ""
  # client_secret   = ""
  features {}
}