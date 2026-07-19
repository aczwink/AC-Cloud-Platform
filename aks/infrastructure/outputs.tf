output "storage_account_key" {
  value     = azurerm_storage_account.appFilesStorage.primary_access_key
  sensitive = true
}

output "storage_account_name" {
  value     = azurerm_storage_account.appFilesStorage.name
  sensitive = false
}