resource "azurerm_linux_web_app" "frontend" {
    location = var.location
    name = "${local.publicDNS_prefix}${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    service_plan_id = var.appServicePlanId

    app_settings = {
      WEBSITE_RUN_FROM_PACKAGE = "1"
    }

    site_config {
        always_on = local.isProd
        health_check_eviction_time_in_min = 2
        health_check_path = "/"

        application_stack {
          node_version = "20-lts"
        }
    }
}