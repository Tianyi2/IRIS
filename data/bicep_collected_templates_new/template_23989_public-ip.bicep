param pipName string
param location string
param sku string = 'Standard'

resource pip 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: pipName
  location: location
  sku: {
    name: sku
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}


output name string = pip.name
output id string = pip.id
