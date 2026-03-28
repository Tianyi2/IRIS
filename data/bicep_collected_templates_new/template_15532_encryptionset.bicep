targetScope = 'resourceGroup'

@description('Location for resources. Must be in same region as virtual machine.')
param location string = resourceGroup().location
@description('Name of key vault.')
param keyVaultName string = 'kv-desdemo-${uniqueString(utcNow())}'
@minValue(7)
@maxValue(90)
@description('Soft-delete retention period in days. Minimum 7, maximum 90.')
param keyVaultSoftDeleteRetentionDays int = 7
@description('Name of disk encryption key.')
param desKeyName string = 'des-key'
@description('Name of disk encryption set.')
param diskEncryptionSetName string = 'des-demo'

resource keyVault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    accessPolicies: []
    enablePurgeProtection: true
    softDeleteRetentionInDays: keyVaultSoftDeleteRetentionDays
  }
}

resource desKey 'Microsoft.KeyVault/vaults/keys@2021-10-01' = {
  name: desKeyName
  parent: keyVault
  properties: {
    keySize: 2048
    kty: 'RSA'
  }
}

resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: diskEncryptionSetName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    activeKey: {
      keyUrl: desKey.properties.keyUriWithVersion
      sourceVault: {
        id: keyVault.id
      }
    }
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: true
  }
}

resource desAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2021-10-01' = {
  name: 'add'
  parent: keyVault
  properties: {
    accessPolicies: [
      {
        permissions: {
          keys: [
            'get'
            'wrapKey'
            'unwrapKey'
          ]
        }
        tenantId: tenant().tenantId
        objectId: diskEncryptionSet.identity.principalId
      }
    ]
  }
}
