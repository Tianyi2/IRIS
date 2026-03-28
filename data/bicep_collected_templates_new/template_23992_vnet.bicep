targetScope = 'resourceGroup'

param vnetName string
param location string
param addressSpace array

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressSpace
    }
  }
}

output vnetName string = vnet.name
output vnetId string = vnet.id
