output "appServicePlanId" {
  description = "ID of the shared App Service Plan"
  value = azurerm_service_plan.asp.id
}

output "functionServicePlanId" {
  description = "ID of the shared Function Service Plan"
  value = azurerm_service_plan.funcPlan.id
}

output "gptModelDeploymentName" {
  description = "Model deployment name of the OpenAI GPT model"
  value = azurerm_cognitive_deployment.gptModelDeployment.name
}

output "logAnalyticsWorkspaceId" {
  description = "ID of the shared Log Analytics Workspace"
  value = azurerm_log_analytics_workspace.law.id
}

output "openAIServiceKey" {
  description = "Service key of the OpenAI instance"
  value = azurerm_cognitive_account.openAIService.primary_access_key
  sensitive = true
}

output "translationServiceKey" {
  description = "Service key of the Translator instance"
  value = azurerm_cognitive_account.translatorService.primary_access_key
  sensitive = true
}