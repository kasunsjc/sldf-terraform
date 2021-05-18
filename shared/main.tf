#--shared/main.tf

resource "azurerm_resource_group" "rg_name" {
  location = var.location
  name = var.rg_name
}
