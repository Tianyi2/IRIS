
param par_storName string 


resource storageAccountExisting 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: par_storName
}


output storageId string = storageAccountExisting.kind


