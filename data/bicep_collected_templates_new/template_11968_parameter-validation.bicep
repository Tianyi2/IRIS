// Parameter validation example.

param location string = resourceGroup().location

@validate(v => startsWith(v, 'st'), 'Storage account name must start with `st`.')
param name string

resource storage 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}
