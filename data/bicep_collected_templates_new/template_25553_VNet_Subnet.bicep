param vnetName string
param subnetName string
param location string = resourceGroup().location
param environment string


var var_vnetName = '${vnetName}-${environment}'
var var_subNetName = '${vnetName}-${subnetName}'

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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: var_subNetName
  parent: vnet
  properties: {
    addressPrefix: '10.0.1.0/24'
  }
}

// Output the subnet Id so can be referenced by other resources
output subnetId string = subnet.id
