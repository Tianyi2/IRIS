param storageAccountName string

resource testStorage 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: storageAccountName
}

// auto depends-on
resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${testStorage.name}/default/logs'
}

output storageId string = testStorage.id
output storageName string = testStorage.name
output endpoint string = testStorage.properties.primaryEndpoints.blob
