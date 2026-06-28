resource "azurerm_linux_web_app" "backend" {
    location = var.location
    name = "${var.environment}-app-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    https_only = true
    service_plan_id = var.appServicePlanId

    app_settings = {
        ARABDICT_DICTDB_PATH = "/srv/db"
        ARABDICT_ORIGIN = "https://${azurerm_linux_web_app.frontend.default_hostname}"
        ARABDICT_PORT = "8080"
    }
    
    site_config {
        always_on = local.isProd
        app_command_line = "./bundle.js"
        health_check_eviction_time_in_min = 2
        health_check_path = "/dialects"
        minimum_tls_version = "1.3"
        
        application_stack {
            node_version = "22-lts"
        }
    }

    storage_account {
        access_key = azurerm_storage_account.storageAccount.primary_access_key
        account_name = azurerm_storage_account.storageAccount.name
        mount_path = "/srv/db"
        name = azurerm_storage_container.dbContainer.name
        share_name = azurerm_storage_container.dbContainer.name
        type = "AzureBlob"
    }
}