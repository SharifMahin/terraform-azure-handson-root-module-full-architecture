output "agw_id" {
  value = azurerm_application_gateway.agw.id
}

output "agw_name" {
  value = azurerm_application_gateway.agw.name
}

output "agw_public_ip" {
  value = azurerm_public_ip.agw_pip.ip_address
}

output "backend_address_pool_id" {
  value = tolist(azurerm_application_gateway.agw.backend_address_pool)[0].id
}