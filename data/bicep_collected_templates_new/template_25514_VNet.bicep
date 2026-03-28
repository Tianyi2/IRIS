param vnetName string
param location string = resourceGroup().location
param environment string

var var_vnetName = '${vnetName}-${environment}'


resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: var_vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/28'
        }
      }
    ]
  }
}


// Output the subnet Id so can be referenced by other resources
output subnetId string = vnet.id
