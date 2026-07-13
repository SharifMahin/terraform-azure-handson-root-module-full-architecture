data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

# New Vnet for Service Endpoint
resource "azurerm_virtual_network" "vnet_se" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = var.address_space
  tags                = var.tags
}

# Subnet for service_endpoints
resource "azurerm_subnet" "subnet_se" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_se.name
  address_prefixes     = var.subnet_prefixes

  service_endpoints = ["Microsoft.Storage"]  # This is for Service Endpoint
}

resource "azurerm_storage_account" "stg" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  tags                     = var.tags


  public_network_access_enabled = false # public access disabled

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.subnet_se.id]  # allow from this subnet
    bypass                     = ["AzureServices"]
  }
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.stg.id
  container_access_type = "private"
}