resource "azurerm_storage_account" "storageAccount" {
    location = var.location
    name = "${var.environment}stamedbstorage"
    resource_group_name = azurerm_resource_group.rg.name

    account_kind = "StorageV2"
    account_replication_type = "LRS"
    account_tier = "Standard"
    min_tls_version = "TLS1_2"
    shared_access_key_enabled = true //required for mounting
}

resource "azurerm_storage_container" "dbContainer" {
    name = "dbstorage"
    storage_account_id = azurerm_storage_account.storageAccount.id
}