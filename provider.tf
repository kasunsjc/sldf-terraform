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
  sub_id = var.sub_id
  spn_secret = var.spn_secret
  spn_app_id = var.spn_app_id
}
