param location string = resourceGroup().location
@minLength(3)
@maxLength(24)
@description('Globally unique, lowercase letters/numbers')
param storageAccountName string

resource sa 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    supportsHttpsTrafficOnly: true
    staticWebsite: {
      enabled: true
      indexDocument: 'index.html'
      error404Document: '404.html'
    }
  }
}

output staticSiteUrl string = 'https://' + sa.name + '.z13.web.core.windows.net/'
