resource "azurerm_cognitive_account" "translatorService" {
    location = var.ai_location
    name = "${var.environment}-trsl-platform"
    resource_group_name = azurerm_resource_group.platformRG.name

    kind = "TextTranslation"
    sku_name = "F0"
}