output "appServicePlanId" {
  description = "ID of the shared App Service Plan"
  value = azurerm_service_plan.asp.id
}

output "logAnalyticsWorkspaceId" {
  description = "ID of the shared Log Analytics Workspace"
  value = azurerm_log_analytics_workspace.law.id
}