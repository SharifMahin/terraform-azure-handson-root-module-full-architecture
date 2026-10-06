data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "stg" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

  # NOTE: Public access is intentionally enabled for learning purposes.
  # In this repo, storage was deployed before private endpoint (private-endpoint/).
  # WARNING: Do NOT set public_network_access_enabled = false before private
  # endpoint is ready — Terraform itself will lose access to Azure API and fail.
  # In production, use a self-hosted agent inside the VNet to avoid this issue.

  #  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_storage_container" "cnt" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.stg.id
  container_access_type = "private"
}