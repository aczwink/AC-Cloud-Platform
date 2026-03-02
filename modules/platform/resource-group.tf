resource "azurerm_resource_group" "platformRG" {
    location = var.location
    name = "${var.environment}-rg-acplatform"
}