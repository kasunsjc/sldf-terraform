output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}

output "business_subnet_id" {
  value = azurerm_subnet.business_subnet.id
}