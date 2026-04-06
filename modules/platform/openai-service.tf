resource "azurerm_cognitive_account" "openAIService" {
    location = var.ai_location
    name = "${var.environment}-oai-platform"
    resource_group_name = azurerm_resource_group.platformRG.name

    kind = "OpenAI"
    sku_name = "S0"
}

resource "azurerm_cognitive_deployment" "gptModelDeployment" {
    name = "gpt-model"

    cognitive_account_id = azurerm_cognitive_account.openAIService.id

    model {
        format = "OpenAI"
        name = "gpt-5.1"
        version = "2025-11-13"
    }

    sku {
        name = "Standard"
        capacity = 50
    }
}