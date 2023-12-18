terraform {

  backend "azurerm" {
    key                  = "github.terraform.tfstate"
  }

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "techielassrg" {
  name     = "github-terraform-resource-group"
  location = "uksouth"
  tags = {
    environment = "dev"
    owner = "sarah"
  }
}
resource "random_string" "ddos_protection_plan" {
  length  = 13
  upper   = false
  numeric = false
  special = false
}
resource "azurerm_network_ddos_protection_plan" "techielassddos" {
  name                = random_string.ddos_protection_plan.result
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.techielassrg.location
}


# Create Virtual Network
resource "azurerm_virtual_network" "techielassvnet" {
  name                = "techielass-gha-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.techielassrg.name

  ddos_protection_plan {
    id = azurerm_network_ddos_protection_plan.techielassddos.id
    enable = true
  }
  tags = {
    environment = "dev"
    owner = "sarah"
  }
}
 
# Create Subnet
resource "azurerm_subnet" "techielasssubnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.techielassrg.name
  virtual_network_name = azurerm_virtual_network.techielassvnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
