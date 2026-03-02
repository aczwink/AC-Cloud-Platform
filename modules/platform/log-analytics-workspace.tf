resource "azurerm_log_analytics_workspace" "law" {
    location = var.location
    name = "${var.environment}-log-platform"
    resource_group_name = azurerm_resource_group.platformRG.name
    
    sku = "PerGB2018"
    daily_quota_gb = 0.023
    retention_in_days = 30
}