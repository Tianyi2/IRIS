@description('Private DNS zone name, e.g. privatelink.vaultcore.azure.net')
param zoneName string

@description('Virtual network resource ID to link with this Private DNS zone.')
param vnetId string

@description('Tags applied to the Private DNS zone and its virtual network link.')
param tags object = {}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: zoneName
  // Private DNS zones are always created in the "global" location
  location: 'global'
  tags: tags
}

resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  name: '${zoneName}/vnet-link'
  location: 'global'
  tags: tags
  properties: {
    virtualNetwork: {
      id: vnetId
    }
    registrationEnabled: false
  }
  dependsOn: [
    privateDnsZone
  ]
}

output zoneId string = privateDnsZone.id
