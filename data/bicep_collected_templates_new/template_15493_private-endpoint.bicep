@description('Name of the private endpoint.')
param name string

@description('Location of the private endpoint.')
param location string

@description('Subnet ID where the private endpoint will be created.')
param subnetId string

@description('Private link groupId (e.g. vault, registry).')
param groupId string

@description('Resource ID of the target service (Key Vault, ACR, etc.).')
param targetResourceId string

@description('Private DNS zone ID to associate with the private endpoint.')
param privateDnsZoneId string

@description('Tags applied to the private endpoint and DNS zone group.')
param tags object = {}

resource pe 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: '${name}-pls'
        properties: {
          privateLinkServiceId: targetResourceId
          groupIds: [
            groupId
          ]
          requestMessage: 'Private Endpoint for ${groupId}'
        }
      }
    ]
  }
}

resource pdzg 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-04-01' = {
  name: 'pdzg'
  parent: pe
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'cfg'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
  }
}
