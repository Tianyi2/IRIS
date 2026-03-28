// Referencing resource types example.

param name string
param location string
param tier resourceInput<'Microsoft.Storage/storageAccounts@2025-06-01'>.properties.accessTier

resource storage 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: tier
  }
}
