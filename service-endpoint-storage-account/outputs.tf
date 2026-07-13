output "vnet_id" {
  value = azurerm_virtual_network.vnet_se.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet_se.id
}

output "storage_account_name" {
  value = azurerm_storage_account.stg.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.stg.primary_blob_endpoint
}