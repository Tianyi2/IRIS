@description('key vault name')
param KeyVaultName string

@description('secret name')
param secretName string

@secure()
@description('secret value')
param secretValue string

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: KeyVaultName
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: toLower(secretName)
  properties: {
    value: secretValue
    contentType: 'plain/text'
  }
}
