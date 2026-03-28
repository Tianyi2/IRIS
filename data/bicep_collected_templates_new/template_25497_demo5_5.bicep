@minLength(3)
@maxLength(24)
param storageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param storageAccountSku string

param storageAccountLocation string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: storageAccountLocation
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
}

output storageAccountOutput string = storageAccount.id
