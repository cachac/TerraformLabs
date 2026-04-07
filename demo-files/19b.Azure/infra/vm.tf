resource "azurerm_public_ip" "pip" {
  name                = "pip-${terraform.workspace}"
  location            = var.res_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${terraform.workspace}"
  location            = var.res_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
  
  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${terraform.workspace}-vm"
  resource_group_name             = var.rg_name
  location                        = var.res_location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = "Password1234!"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = merge(var.tags, {
    Name = "${terraform.workspace}-vm"
  })
}
