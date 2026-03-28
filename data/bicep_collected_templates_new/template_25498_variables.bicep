@minLength(3)
@maxLength(11)
param storageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param storageAccountSku string

param storageAccountLocation string = resourceGroup().location


// var <name> = <expression>

var myName = 'Bob'

var greeting = 'Howdy, ${myName}'

var myNullValue = null

var location = resourceGroup().location

var unqStoragename = '${storageAccountName}${uniqueString(subscription().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: unqStoragename
  location: storageAccountLocation
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
}

output storageAccountOutput string = storageAccount.id
