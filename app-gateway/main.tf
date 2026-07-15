data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet_agw" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = var.address_space
  tags                = var.tags
}

# Need new separate subnet for App Gateway
resource "azurerm_subnet" "subnet_agw" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_agw.name
  address_prefixes     = var.subnet_prefixes
  # In App Gateway subnet, can not assign NSG
}

# Public IP for App Gateway
resource "azurerm_public_ip" "agw_pip" {
  name                = var.public_ip_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Application Gateway
locals {
  backend_address_pool_name      = "${var.agw_name}-beap"
  frontend_port_name             = "${var.agw_name}-feport"
  frontend_ip_configuration_name = "${var.agw_name}-feip"
  http_setting_name              = "${var.agw_name}-be-htst"
  listener_name                  = "${var.agw_name}-httplstn"
  request_routing_rule_name      = "${var.agw_name}-rqrt"
}

resource "azurerm_application_gateway" "agw" {
  name                = var.agw_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  tags                = var.tags

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "${var.agw_name}-gwip"
    subnet_id = azurerm_subnet.subnet_agw.id
  }

  # Frontend
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agw_pip.id
  }

 frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  # Backend
  backend_address_pool {
    name  = local.backend_address_pool_name
    fqdns = var.backend_fqdns
  }
 
  backend_http_settings {
    name                                = local.http_setting_name
    cookie_based_affinity               = "Disabled"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 60

    # Without this setting:
    #   AGW sends → Host: agw-terraformhandson-jpe (AGW's own name)
    #   App Service does not recognize this host → returns 502
    #
    # With this setting:
    #   AGW sends → Host: app-terraformhandson-jpe.azurewebsites.net (backend FQDN)
    #   App Service recognizes this host → returns 200 OK
    pick_host_name_from_backend_address = true
  }

  # Listener
  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  # Routing Rule
  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = 100
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}