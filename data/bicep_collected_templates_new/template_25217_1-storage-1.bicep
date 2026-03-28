resource storage 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: 'storage'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_RAGZRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

output url string = storage.properties.primaryEndpoints.blob
