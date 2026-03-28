param defaultSharePermission string
param storageAccountNamePrefix string
param storageCount int
param storageIndex int
param kind string
param skuName string
param location string
param sasExpirationPeriod string = '180.00:00:00'
param allowSharedKeyAccess bool = true
param allowBlobPublicAccess bool = false
param allowCrossTenantReplication bool = false
@allowed([
  ''
  'PrivateLink'
  'AAD'
])
param allowedCopyScope string = 'AAD'
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'
param networkAcls object = {
  bypass: 'AzureServices'
  defaultAction: 'Allow'
}
param minimumTlsVersion string = 'TLS1_2'
param requireInfrastructureEncryption bool = true
param encryption object = {}
param identity object = {}
param accessTier string = 'Hot'
param tags object = {}
param fslogixEncryptionKeyNameConv string = ''
param largeFileSharesState string = 'Disabled'
param dnsEndpointType string = 'Standard'

// Validate and provide defaults for encryption
var encryptionConfig = empty(encryption) ? {
  keySource: 'Microsoft.Storage'
  requireInfrastructureEncryption: requireInfrastructureEncryption
  services: {
    file: {
      keyType: 'Account'
      enabled: true
    }
    blob: kind == 'StorageV2' ? {
      keyType: 'Account'
      enabled: true
    } : null
  }
} : union(encryption, {
  requireInfrastructureEncryption: requireInfrastructureEncryption
})

resource configureEntraKerberosWithoutDomainInfo 'Microsoft.Storage/storageAccounts@2022-09-01' = [
  for i in range(0, storageCount): {
    name: '${storageAccountNamePrefix}${string(padLeft(i + storageIndex, 2, '0'))}'
    kind: kind
    location: location
    identity: !empty(identity) ? identity : null
    tags: tags
    properties: {
      accessTier: kind != 'Storage' ? accessTier : null
      allowBlobPublicAccess: allowBlobPublicAccess
      allowCrossTenantReplication: allowCrossTenantReplication
      allowedCopyScope: !empty(allowedCopyScope) ? allowedCopyScope : null
      allowSharedKeyAccess: allowSharedKeyAccess
      azureFilesIdentityBasedAuthentication: {
        defaultSharePermission: defaultSharePermission
        directoryServiceOptions: 'AADKERB'
      }
      defaultToOAuthAuthentication: false
      dnsEndpointType: dnsEndpointType
      encryption: !empty(encryption) && contains(encryption, 'keyvaultproperties') ? union(encryptionConfig, {
        keyvaultproperties: {
          keyname: !empty(fslogixEncryptionKeyNameConv) ? replace(fslogixEncryptionKeyNameConv, '##', padLeft(i + storageIndex, 2, '0')) : encryption.keyvaultproperties.keyname
          keyvaulturi: encryption.keyvaultproperties.keyvaulturi
        }
      }) : encryptionConfig
      largeFileSharesState: largeFileSharesState
      minimumTlsVersion: minimumTlsVersion
      networkAcls: networkAcls
      publicNetworkAccess: publicNetworkAccess
      sasPolicy: !empty(sasExpirationPeriod) ? {
        expirationAction: 'Log'
        sasExpirationPeriod: sasExpirationPeriod
      } : null
      supportsHttpsTrafficOnly: true
    }
    sku: {
      name: skuName
    }
  }
]
