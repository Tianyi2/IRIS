@minLength(3)
@maxLength(8)
param storageAccountName string

param storageAccountSku string
param environment string

param storageAccountLocation string = resourceGroup().location
param debugMode bool = false

var var_storageName = '${storageAccountName}${uniqueString(subscription().id)}${environment}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: var_storageName
  location: storageAccountLocation
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
}

output storageAccountOutput string = storageAccount.id


output logMessage string =  debugMode ? 'name:${storageAccount.name}, location:${storageAccount.location}' : 'LoggingDisable'
