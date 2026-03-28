// Simple Bicep template with loops and conditionals
param storageNames array = ['storage1', 'storage2', 'storage3']
param location string = 'eastus'
param deployBackup bool = true
param environment string = 'dev'

// Storage accounts with loop
resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = [
  for name in storageNames: {
    name: '${name}${uniqueString(resourceGroup().id)}'
    location: location
    sku: {
      name: 'Standard_LRS'
    }
    kind: 'StorageV2'
    properties: {
      accessTier: 'Hot'
    }
  }
]

// Conditional backup vault
resource vault 'Microsoft.RecoveryServices/vaults@2021-08-01' = if (deployBackup) {
  name: 'backup-vault-${environment}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {}
}

// Output storage account IDs
output storageAccountIds array = [for i in range(0, length(storageNames)): stg[i].id]
output vaultId string = deployBackup ? vault.id : ''
