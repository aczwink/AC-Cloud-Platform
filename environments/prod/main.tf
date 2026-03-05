locals {
  env = "prd"
}

module "platform" {
    source = "../../modules/platform"

    environment = local.env
    location = var.location
}

module "app_kungfudoc" {
    source = "../../modules/app-kungfudoc"

    appServicePlanId = module.platform.appServicePlanId
    environment = local.env
    location = var.location
    logAnalyticsWorkspaceId = module.platform.logAnalyticsWorkspaceId
}