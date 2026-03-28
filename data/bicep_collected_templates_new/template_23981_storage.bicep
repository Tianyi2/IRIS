param location string = 'japaneast'
param namePrefix string = 'demo'
param globalRedundancy bool = false
param containerNames array = [
  'dogs'
  'cats'
  'fish'
]

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

resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for name in containerNames: {
  name: '${testStorage.name}/default/${name}'
  // dependsOn will be added when the template is compiled
}]

resource blob2 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for (name, index) in containerNames: {
  name: '${testStorage.name}/default/${name}-${index + 1}'
  // dependsOn will be added when the template is compiled
}]

output storageId string = testStorage.id
output storageName string = testStorage.name
output endpoint string = testStorage.properties.primaryEndpoints.blob

output containerProps array = [for i in range(0, length(containerNames)): blob[i].id]
output containerProps2 array = [for i in range(0, length(containerNames)): blob2[i].id]
