locals {
  env = "prd"
}

module "platform" {
    source = "../../modules/platform"

    environment = local.env
    location = var.location
    resourceGroupName = azurerm_resource_group.platformRG.name
}