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
        name = "gpt-4o"
        version = "2024-08-06"
    }

    sku {
        name = "Standard"
        capacity = 50
    }
}