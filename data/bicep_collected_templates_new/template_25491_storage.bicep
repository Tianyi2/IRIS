resource mystorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'ecouncilstorlesson4'
  location: resourceGroup().location
  sku: {
    name:  'Standard_LRS'
  }
  kind:  'StorageV2'
}
