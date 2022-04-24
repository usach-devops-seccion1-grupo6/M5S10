terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "azurerm_resource_group" "resourcegroup" {
 name     =  var.name
 location =  var.location
}

variable "name" {
}

variable "location" {
}

resource "azurerm_virtual_network" "virtualnetwork" {
  name = "network-diegobell2"
  address_space = [ "12.0.0.0/16" ]
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

resource "azurerm_subnet" "subnet" {
  name = "internal"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.virtualnetwork.name
  address_prefixes = [ "12.0.0.0/20" ]
}

resource "azurerm_container_registry" "acr" {
  name = "containerRegistry2diegobell"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location = azurerm_resource_group.resourcegroup.location
  sku = "Basic"
  admin_enabled = true
}

resource "azurerm_kubernetes_cluster" "kubernetescluster" {
  name = "aksdiplomado"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  dns_prefix = "aksl"
  kubernetes_version = "1.23.5"
  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "standard_d2as_v4"
    vnet_subnet_id = azurerm_subnet.subnet.id
    enable_auto_scaling = true
    max_count = 2
    min_count = 1
  }

  service_principal {
    client_id = "client_id"
    client_secret = "client_secret"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
}
