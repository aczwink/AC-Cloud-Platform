resource "azurerm_linux_web_app" "backend" {
    location = var.location
    name = "${var.environment}-app-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    https_only = true
    service_plan_id = var.appServicePlanId

    app_settings = {
        AME_DICTDB_PATH = "/srv/db/db.json"
        AME_ORIGIN = "https://${azurerm_static_web_app.frontend.default_host_name}"
        AME_PORT = "8080"
    }
    
    site_config {
        always_on = local.isProd
        minimum_tls_version = "1.3"
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