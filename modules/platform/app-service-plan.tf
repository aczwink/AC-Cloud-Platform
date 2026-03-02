resource "azurerm_service_plan" "asp" {
    location = var.location
    name = "${var.environment}-asp-linux"
    resource_group_name = azurerm_resource_group.platformRG.name

    os_type = "Linux"
    sku_name = "B1"
}