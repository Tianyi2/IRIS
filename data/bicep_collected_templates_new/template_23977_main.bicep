param location string = 'japaneast'
param namePrefix string = 'demo'
param globalRedundancy bool = false

var storageSku = globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'
var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'

resource testStorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: storageSku
  }
}

// auto depends-on
resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${testStorage.name}/default/logs'
}

output storageId string = testStorage.id
output storageName string = testStorage.name
output endpoint string = testStorage.properties.primaryEndpoints.blob
