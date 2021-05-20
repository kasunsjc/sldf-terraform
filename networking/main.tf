#--networking/main.tf

#Create Virtual Networks
resource "azurerm_virtual_network" "virtual_network" {
  address_space = [var.vnet_cidr]
  location = var.location
  name = var.vnet_name
  resource_group_name = var.rg_name
}

# Virtual Network Subnet
resource "azurerm_subnet" "web_subnet" {
  name = "${var.web_subnet_name}-subnet"
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [var.web_subnet_prefix]
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_assoc" {
  network_security_group_id = azurerm_network_security_group.web_nsg.id
  subnet_id = azurerm_subnet.web_subnet.id
}

resource "azurerm_subnet" "business_subnet" {
  name = "${var.business_subnet_name}-subnet"
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [var.business_subnet_prefix]
}

resource "azurerm_subnet_network_security_group_association" "business_subnet_assoc" {
  network_security_group_id = azurerm_network_security_group.business_nsg.id
  subnet_id = azurerm_subnet.business_subnet.id
}

resource "azurerm_network_security_group" "web_nsg" {
  name                = var.web_nsg_name
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_rule" "web_nsg_rules" {
  for_each                    = var.web_nsg_rules
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

resource "azurerm_network_security_group" "business_nsg" {
  name                = var.business_nsg_name
  location            = var.location
  resource_group_name = var.rg_name

}

resource "azurerm_network_security_rule" "business_nsg_rules" {
  for_each                    = var.business_nsg_rules
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.business_nsg.name
}

