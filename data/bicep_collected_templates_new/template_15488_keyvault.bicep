@description('Key Vault name.')
param name string

@description('Location of the Key Vault.')
param location string

@description('Optional subnet IDs to allow via KV network ACLs (rarely needed when using Private Endpoints).')
param allowedSubnetIds array = []

@description('Tags applied to the Key Vault.')
param tags object = {}

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    enablePurgeProtection: true
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      virtualNetworkRules: [for id in allowedSubnetIds: {
        id: id
      }]
      ipRules: []
    }
    publicNetworkAccess: 'Disabled'
  }
}

@description('Key Vault name.')
output name string = kv.name

@description('Key Vault resource ID.')
output id string = kv.id
