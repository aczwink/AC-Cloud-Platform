resource "azurerm_windows_function_app" "restartFunctionApp" {
    location = var.location
    name = "${var.environment}-func-${local.appName}-restart"
    resource_group_name = azurerm_resource_group.rg.name

    functions_extension_version = "~4"    
    service_plan_id = var.funcServicePlanId
    storage_account_access_key = azurerm_storage_account.storageAccount.primary_access_key
    storage_account_name = azurerm_storage_account.storageAccount.name
    zip_deploy_file = "../../integration/app-openarabdict/restart-function-app.zip"

    app_settings = {
        ACPLATFORM_INT_BACKEND_NAME = azurerm_linux_web_app.backend.name
        ACPLATFORM_INT_RG_NAME = azurerm_resource_group.rg.name
    }

    identity {
        type = "SystemAssigned"
    }

    site_config {
        application_insights_connection_string = azurerm_application_insights.appInsights.connection_string
        application_insights_key = azurerm_application_insights.appInsights.instrumentation_key

        application_stack {
            powershell_core_version = "7.4"
        }
    }
}

resource "azurerm_eventgrid_event_subscription" "restartOnDictionaryChangeEventSubscription" {
    name = "restart-on-dictionary-change"
    scope = azurerm_storage_account.storageAccount.id

    included_event_types = [ "Microsoft.Storage.BlobCreated" ]

    azure_function_endpoint {
        function_id = "${azurerm_windows_function_app.restartFunctionApp.id}/functions/restart-function"
    }
    
    subject_filter {
        subject_begins_with = "/blobServices/default/containers/${azurerm_storage_container.dbContainer.name}/blobs/"
    }
}

resource "azurerm_role_assignment" "restartRoleAssignment" {
    scope = azurerm_linux_web_app.backend.id
    principal_id = azurerm_windows_function_app.restartFunctionApp.identity[0].principal_id
    role_definition_name = "Website Contributor"
}