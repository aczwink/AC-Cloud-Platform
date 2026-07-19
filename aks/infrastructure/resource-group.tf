resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${local.environment}-rg-${local.appName}"
}