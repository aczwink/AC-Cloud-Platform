resource "azurerm_linux_function_app" "translationFunctionApp" {
    location = var.location
    name = "${var.environment}-func-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    service_plan_id = var.appServicePlanId

    app_settings = {
      FUNCTIONS_WORKER_RUNTIME = "node"
    }

    site_config {
    }
}