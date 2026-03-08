resource "azurerm_linux_web_app" "frontend" {
    location = var.location
    name = "${local.publicDNS_prefix}${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    service_plan_id = var.appServicePlanId

    app_settings = {
      APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appInsights.connection_string
      APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.appInsights.instrumentation_key
      WEBSITE_RUN_FROM_PACKAGE = "1"
    }

    site_config {
        always_on = local.isProd

        application_stack {
          node_version = "20-lts"
        }
    }
}