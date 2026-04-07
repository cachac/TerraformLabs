resource "azurerm_resource_group" "rg" {
  name     = "rg-${terraform.workspace}-final"
  location = var.res_location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "VNet-${terraform.workspace}"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = merge(var.tags, {
    Name = "VNet-${terraform.workspace}"
  })
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}
