resource "azurerm_static_web_app" "frontend" {
    location = var.location
    name = "${var.environment}-swa-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    sku_size = "Free"
    sku_tier = "Free"
}