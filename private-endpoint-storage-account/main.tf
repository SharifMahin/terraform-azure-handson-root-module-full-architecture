data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet_pe" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet_pe" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_pe.name
  address_prefixes     = var.subnet_prefixes

  private_endpoint_network_policies = "Disabled" # Connection fail or intermittent error, if this subnet has NSG.So,disabled.
}

data "azurerm_storage_account" "existing_stg" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "pe" {
  name                = var.private_endpoint_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  subnet_id           = azurerm_subnet.subnet_pe.id
  tags                = var.tags

  private_service_connection {
    name                           = "${var.private_endpoint_name}-connection"
    private_connection_resource_id = data.azurerm_storage_account.existing_stg.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.blob.core.windows.net" # https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "${var.private_endpoint_name}-dns-link"
  resource_group_name   = data.azurerm_resource_group.existing_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet_pe.id
}

resource "azurerm_private_dns_a_record" "dns_record" {
  name                = data.azurerm_storage_account.existing_stg.name
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pe.private_service_connection[0].private_ip_address]
}