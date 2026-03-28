param location string = 'japaneast'
param namePrefix string = 'demo'
param globalRedundancy bool = false
param currentYear string = utcNow('yyyy') // format utc time to year only

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

resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = if (currentYear == '2021') {
  name: '${testStorage.name}/default/logs'
  // dependsOn will be added when the template is compiled
}

output storageId string = testStorage.id
output storageName string = testStorage.name
output endpoint string = testStorage.properties.primaryEndpoints.blob
