resource storageAccount 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: 'prdsttfstate'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2025-06-01' = {
  name: 'default'
  parent: storageAccount
}

resource platformContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-06-01' = {
  name: 'terraform-state-acplatform'
  parent: blobServices
}
