resource "azurerm_application_insights" "appInsights" {
    location = var.location
    name = "${var.environment}-appi-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name
    
    application_type = "web"
    workspace_id = var.logAnalyticsWorkspaceId
}