param storageAccountName string = 'cloudstoragelensprod'
param containerName string = 'demo-container'
param location string = resourceGroup().location

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storage
  name: '${storageAccountName}/default/${containerName}'
  properties: {
    publicAccess: 'Container'
  }
}
