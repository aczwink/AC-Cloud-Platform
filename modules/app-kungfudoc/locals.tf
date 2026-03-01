locals {
  appName = "ackungfudoc"
  isProd = var.environment == "prd"
  publicDNS_prefix = local.isProd ? "" : var.environment
}