resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: 'example-public-ip-from-bicep'
  location: 'berlin'
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}