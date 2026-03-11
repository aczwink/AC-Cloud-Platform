resource "azurerm_service_plan" "funcPlan" {
    location = var.location
    name = "${var.environment}-asp-func"
    resource_group_name = azurerm_resource_group.platformRG.name

    os_type = "Windows"
    sku_name = "Y1"
}