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
  tenant_id = var.tenent_id
  subscription_id = var.sub_id
  client_secret = var.spn_secret
  client_id = var.spn_app_id
}