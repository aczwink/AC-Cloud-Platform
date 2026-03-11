locals {
    appName = "arabicmusicencyclopedia"
    isProd = var.environment == "prd"
    publicDNS_prefix = local.isProd ? "" : var.environment
}