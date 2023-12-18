terraform {

  backend "azurerm" {
    key                  = "github-terraform.tfstate"
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
}

# Create Virtual Network
resource "azurerm_virtual_network" "techielassvnet" {
  name                = "techielass-gha-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.techielassrg.name
}
 
# Create Subnet
resource "azurerm_subnet" "techielasssubnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.techielassrg.name
  virtual_network_name = azurerm_virtual_network.techielassvnet
  address_prefixes     = ["10.0.0.0/24"]
}
