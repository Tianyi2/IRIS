// Azure Storage Account (Blobs + Queues)

param location string
param tags object
param resourceToken string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'st${resourceToken}'
  location: location
  tags: tags
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
  }

  resource blobServices 'blobServices' = {
    name: 'default'

    resource packagesContainer 'containers' = {
      name: 'packages'
      properties: {
        publicAccess: 'None'
      }
    }
  }

  resource queueServices 'queueServices' = {
    name: 'default'

    resource scanQueue 'queues' = {
      name: 'package-scan'
    }
  }
}

output connectionString string = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=core.windows.net'
output accountName string = storageAccount.name
output blobEndpoint string = storageAccount.properties.primaryEndpoints.blob
output queueEndpoint string = storageAccount.properties.primaryEndpoints.queue
