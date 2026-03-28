var isPrimaryRegion = resourceGroup().location == 'westus'

resource storage 'Microsoft.Storage/storageAccounts@2021-08-01' = if (isPrimaryRegion) {
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

resource existingStorage 'Microsoft.Storage/storageAccounts@2021-08-01' existing = if (!isPrimaryRegion) {
  name: 'storage'
  scope: resourceGroup(replace(resourceGroup().name, '-WUS', '-EUS'))
}

output url string = isPrimaryRegion ? storage.properties.primaryEndpoints.blob : existingStorage.properties.primaryEndpoints.blob
