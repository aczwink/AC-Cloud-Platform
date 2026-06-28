resource "azurerm_resource_group" "rg" {
    location = var.location
    name = "${var.environment}-rg-${local.appName}"
}