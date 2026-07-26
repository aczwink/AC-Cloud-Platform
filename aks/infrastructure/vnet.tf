resource "azurerm_virtual_network" "vnet" {
    location = var.location
    name = "${local.environment}-vnet-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    address_space = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "agwSubnet" {
    name = "${local.environment}-snet-${local.appName}-agw"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name

    address_prefixes = [ "10.0.0.0/24" ]
}

resource "azurerm_subnet" "aksSubnet" {
    name = "${local.environment}-snet-${local.appName}-aks"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name

    address_prefixes = [ "10.0.1.0/24" ]
}