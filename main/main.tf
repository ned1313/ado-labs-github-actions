##################################################################################
# LOCALS
##################################################################################


locals {
  resource_group_name = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_plan_name = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_name = "${var.naming_prefix}-${random_integer.name_suffix.result}"
}

resource "random_integer" "name_suffix" {
  min = 10000
  max = 99999
}

##################################################################################
# APP SERVICE
##################################################################################

#resource "azurerm_resource_group" "app_service" {
#  name     = local.resource_group_name
#  location = var.location
#}

#resource "azurerm_network_security_group" "example" {
#  name                = "example-security-group"
#  location            = azurerm_resource_group.app_service.location
#  resource_group_name = azurerm_resource_group.app_service.name
#}

#resource "azurerm_virtual_network" "example" {
#  name                = "example-network"
#  location            = azurerm_resource_group.app_service.location
#  resource_group_name = azurerm_resource_group.app_service.name
#  address_space       = ["10.0.0.0/16"]
#  dns_servers         = ["10.0.0.4", "10.0.0.5"]
#
#  subnet {
#    name             = "subnet1"
#    address_prefixes = ["10.0.1.0/24"]
#  }
#
#  subnet {
#    name             = "subnet2"
#    address_prefixes = ["10.0.2.0/24"]
#    security_group   = azurerm_network_security_group.example.id
#  }
#
#  tags = {
#    environment = "Production"
#  }
#}


#resource "azurerm_log_analytics_workspace" "example" {
#  name                = "acctest-01"
#  location            = azurerm_resource_group.app_service.location
#  resource_group_name = azurerm_resource_group.app_service.name
#  sku                 = "PerGB2018"
#  retention_in_days   = 30
#}

#resource "azurerm_container_app_environment" "example" {
#  name                       = "Example-Environment"
#  location            = azurerm_resource_group.app_service.location
#  resource_group_name = azurerm_resource_group.app_service.name
#  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
#}

#resource "azurerm_container_app" "example" {
#  name                         = "example-app"
#  container_app_environment_id = azurerm_container_app_environment.example.id
#  resource_group_name = azurerm_resource_group.app_service.name
#  revision_mode                = "Single"
#
#  template {
#    container {
#      name   = "examplecontainerapp"
#      image  = "mcr.microsoft.com/k8se/quickstart:latest"
#      cpu    = 0.25
#      memory = "0.5Gi"
#    }
#  }
#}