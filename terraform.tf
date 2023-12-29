##
# Terraform Configuration
##

terraform {

  backend "azurerm" {
    key = "github.terraform.tfstate"
  }

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.0"
    }
  }
}

##
# Provider configuration
##

provider "azurerm" {
  features {}
}

provider "random" {

}
