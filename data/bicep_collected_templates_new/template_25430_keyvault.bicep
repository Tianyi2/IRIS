param keyVaultName string
param location string = resourceGroup().location

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantId()
    accessPolicies: [
      {
        objectId: 'YOUR_OBJECT_ID_1' // Replace with the object ID of the user or service principal
        permissions: {
          keys: ['get', 'list']
          secrets: ['get', 'list']
          certificates: ['get', 'list']
        }
      },
      {
        objectId: 'YOUR_OBJECT_ID_2' // Replace with the object ID of another user or service principal
        permissions: {
          keys: ['get']
        }
      }
    ]
  }
}

output keyVaultResourceId string = keyVault.id
