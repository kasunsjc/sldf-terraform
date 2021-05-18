terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}
