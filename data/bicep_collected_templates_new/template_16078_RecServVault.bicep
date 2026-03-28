targetScope = 'resourceGroup'

@description('Name of the Recovery Services vault')
param vaultName string = 'myRecoveryVault'

@description('Azure location for the vault')
param location string = resourceGroup().location

@description('SKU of the Recovery Services vault (Standard or RS0)')
@allowed([
  'Standard'
  'RS0'
])
param vaultSku string = 'Standard'

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: vaultName
  location: location
  sku: {
    name: vaultSku
  }
  properties: {
    // Empty, but required property block
  }
}

output vaultId string = recoveryVault.id
output vaultNameOut string = recoveryVault.name
