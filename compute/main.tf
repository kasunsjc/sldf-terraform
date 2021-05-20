#--compute/main.tf

#Creare virtual machine

resource "azurerm_virtual_machine" "create_vm" {
  count = var.vm_count
  location = var.location
  name = "${var.vm_name}${count.index}"
  network_interface_ids = [
    "${element(azurerm_network_interface.create_nic.*.id,count.index )}"]
  resource_group_name = var.rg_name
  vm_size = var.vm_size

  storage_os_disk {
    create_option = "FromImage"
    name = "${var.vm_name}osdisk-${count.index}"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "16.04-LTS"
    version = "latest"

  }

  os_profile {
    computer_name = "${var.vm_name}"
    admin_username = "localadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "create_nic" {
  name                = "${var.vm_name}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name
  count               = var.vm_count

  ip_configuration {
    name                          = "testconfiguration${count.index}"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "dynamic"
  }
}
