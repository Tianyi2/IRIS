param location string = 'japaneast'
@minLength(3)
@maxLength(24)
param storageAccountName string = 'uniquestorage0011111001' // must be globally unique

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}
