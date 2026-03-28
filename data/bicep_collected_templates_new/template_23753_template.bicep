resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'example-vnet-from-bicep'
  location: 'berlin'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet-1'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'subnet-2'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}