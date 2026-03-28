// define parameters
param storageAccountName string = 'stgaccbicep${uniqueString(resourceGroup().id)}'
param location string = 'West Europe'

// in terminal you will asked, if the environment is prod or nonprod. Type 1 0r 2
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

// define the variables
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'


// create a Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSkuName
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountName string = storageAccount.name
