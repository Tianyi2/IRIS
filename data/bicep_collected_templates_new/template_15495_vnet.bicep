@description('Name of the virtual network.')
param name string

@description('Location of the virtual network.')
param location string

@description('Address space for the VNet.')
param addressSpace array

@description('Name of the subnet for Dev Box.')
param subnetName string

@description('CIDR of the subnet for Dev Box.')
param subnetCidr string

@description('Tags applied to the VNet.')
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressSpace
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetCidr
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

@description('VNet resource ID.')
output vnetId string = vnet.id

@description('VNet name.')
output vnetName string = vnet.name

@description('Subnet resource ID (first subnet).')
output subnetId string = vnet.properties.subnets[0].id
