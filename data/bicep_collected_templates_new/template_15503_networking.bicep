@description('Location for networking resources.')
param location string

@description('VNet name to create.')
param vnetName string

@description('Subnet name to create.')
param subnetName string

@description('VNet address prefix, e.g., 10.20.0.0/16.')
param vnetAddressPrefix string

@description('Subnet prefix, e.g., 10.20.1.0/24.')
param subnetPrefix string

@description('Tags to apply to resources.')
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix

          // Required for Dev Box / Dev Center unmanaged networking scenarios
          delegations: [
            {
              name: 'devcenter-delegation'
              properties: {
                serviceName: 'Microsoft.DevCenter/networkConnections'
              }
            }
          ]
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output subnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
