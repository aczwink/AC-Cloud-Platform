locals {
  env = "dev"
}

module "platform" {
    source = "../../modules/platform"

    ai_location = var.ai_location
    environment = local.env
    location = var.location
}

/*

module "app_arabicmusicencyclopedia" {
    source = "../../modules/app-arabicmusicencyclopedia"

    appServicePlanId = module.platform.appServicePlanId
    environment = local.env
    location = var.location
    servicePrincipalObjectId = var.servicePrincipalObjectId
}

module "app_kungfudoc" {
    source = "../../modules/app-kungfudoc"

    appServicePlanId = module.platform.appServicePlanId
    environment = local.env
    location = var.location
    logAnalyticsWorkspaceId = module.platform.logAnalyticsWorkspaceId
}
*/

module "app_openarabdict" {
    source = "../../modules/app-openarabdict"

    ai_location = var.ai_location
    appServicePlanId = module.platform.appServicePlanId
    buildId = var.buildId
    environment = local.env
    funcServicePlanId = module.platform.functionServicePlanId
    gptModelDeploymentName = module.platform.gptModelDeploymentName
    location = var.location
    logAnalyticsWorkspaceId = module.platform.logAnalyticsWorkspaceId
    openAIServiceKey = module.platform.openAIServiceKey
    servicePrincipalObjectId = var.servicePrincipalObjectId
    translationServiceKey = module.platform.translationServiceKey
}
