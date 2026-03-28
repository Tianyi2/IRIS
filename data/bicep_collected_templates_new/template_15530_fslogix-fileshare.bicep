@description('Name of the storage account')
param storageAccountName string = 'fslogixstorage${uniqueString(resourceGroup().id)}'

@description('Azure location')
param location string = resourceGroup().location

@description('Name of the file share')
param fileShareName string = 'profileshare'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = {
  name: '${storageAccount.name}/default/${fileShareName}'
  properties: {
    shareQuota: 100
  }
  dependsOn: [
    storageAccount
  ]
}
