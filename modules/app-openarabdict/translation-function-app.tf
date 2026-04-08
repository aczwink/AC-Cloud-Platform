resource "azurerm_windows_function_app" "translationFunctionApp" {
    location = var.location
    name = "${var.environment}-func-${local.appName}-translation"
    resource_group_name = azurerm_resource_group.rg.name

    functions_extension_version = "~4"    
    service_plan_id = var.funcServicePlanId
    storage_account_access_key = azurerm_storage_account.storageAccount.primary_access_key
    storage_account_name = azurerm_storage_account.storageAccount.name
    zip_deploy_file = "../../_build/translation-function-app-${var.buildId}.zip"

    app_settings = {
        ACPLATFORM_INT_CONTAINER_NAME: azurerm_storage_container.dbContainer.name
        ACPLATFORM_INT_TRANSLATION_LANGUAGE: "de"
        OPENARABDICT_TRANSLATOR_AZURE_OPENAI_KEY: var.openAIServiceKey
        OPENARABDICT_TRANSLATOR_AZURE_OPENAI_MODEL_DEPLOYMENT_NAME: var.gptModelDeploymentName
        OPENARABDICT_TRANSLATOR_AZURE_OPENAI_REGION: var.ai_location
        OPENARABDICT_TRANSLATOR_AZURE_TRANSLATOR_KEY: var.translationServiceKey
        OPENARABDICT_TRANSLATOR_AZURE_TRANSLATOR_REGION: var.ai_location
        OPENARABDICT_TRANSLATOR_IMPLEMENTATION: "azure-openai-azure-translator-fallback"
    }

    site_config {
        application_insights_connection_string = azurerm_application_insights.appInsights.connection_string
        application_insights_key = azurerm_application_insights.appInsights.instrumentation_key

        application_stack {
            node_version = "~20"
        }
    }
}

resource "azurerm_eventgrid_event_subscription" "translateOnDictionaryChangeEventSubscription" {
    name = "translate-on-dictionary-change"
    scope = azurerm_storage_account.storageAccount.id
    depends_on = [
        azurerm_windows_function_app.translationFunctionApp
    ]

    included_event_types = [ "Microsoft.Storage.BlobCreated" ]

    azure_function_endpoint {
        function_id = "${azurerm_windows_function_app.translationFunctionApp.id}/functions/start-translation"
    }

    subject_filter {
        subject_begins_with = "/blobServices/default/containers/${azurerm_storage_container.dbContainer.name}/blobs/"
        subject_ends_with = "en.json"
    }
}