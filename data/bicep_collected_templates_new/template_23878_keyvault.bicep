param location string

resource keyVault 'Microsoft.KeyVault/vaults@2022-11-01' = {
  name: 'kv-${uniqueString(resourceGroup().id)}'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: []
    enabledForDeployment: true
    enabledForTemplateDeployment: true
  }
}

output keyVaultName string = keyVault.name