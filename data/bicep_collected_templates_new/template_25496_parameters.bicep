// param <name> <type> = <default>

param myParam string

param myParam2 string = 'mydefaultValue'


@minLength(3)
@maxLength(24)
@description('This is the name of the storage account')
param myStorageAccount string


@secure()
@minLength(6)
param myPassword string = 'hereismypwd'

@allowed(
  [
    2
    3
    4
  ]
)
param vmCounts int

@allowed([
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_RAGRS'
])
param skuName string

param storageAccount object = {

  location: 'aus es'
  sku: 'Standard_GR'
  kind: 'StorageV2'

}


resource myAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 
  location: 
  sku: {
    name: storageAccount.sku
  }
  kind: storageAccount.kind
}

