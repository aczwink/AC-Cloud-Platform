resource "azurerm_public_ip" "pip" {
    location = var.location
    name = "${local.environment}-pip-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name
    
    allocation_method = "Static"
    sku = "Standard"
}