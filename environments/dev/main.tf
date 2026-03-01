locals {
  env = "dev"
}

resource "azurerm_resource_group" "platformRG" {
    location = var.location
    name = "${local.env}-rg-acplatform"
}

module "platform" {
    source = "../../modules/platform"

    environment = local.env
    location = var.location
    resourceGroupName = azurerm_resource_group.platformRG.name
}

module "app_arabicmusicencyclopedia" {
    source = "../../modules/app-arabicmusicencyclopedia"

    appServicePlanId = module.platform.appServicePlanId
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

module "app_openarabdict" {
    source = "../../modules/app-openarabdict"

    appServicePlanId = module.platform.appServicePlanId
    environment = local.env
    location = var.location
}