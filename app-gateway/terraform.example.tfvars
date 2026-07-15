resource_group_name = "rg-<project>-<region>"
vnet_name           = "vnet-agw-<project>-<region>"
address_space       = ["10.3.0.0/16"]    # 10.0, 10.1, 10.2 already used
subnet_name         = "snet-agw-<project>-<region>"
subnet_prefixes     = ["10.3.1.0/24"]
public_ip_name      = "pip-agw-<project>-<region>"
agw_name            = "agw-<project>-<region>"
backend_fqdns       = ["<your-app-service>.azurewebsites.net"]

tags = {
  environment = "dev"
  project     = "<project-name>"
  owner       = "<your-name>"
}