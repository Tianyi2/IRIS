// Network connection for Dev Box
@description('The name for the Network Connection.')
param name string

@description('The Azure region.')
param location string

@description('The Subnet Resource ID where Dev Boxes will be deployed.')
param subnetId string

@description('Resource group name where Dev Box NICs will be placed.')
param networkingResourceGroupName string

@description('Common tags for resources.')
param tags object = {}

resource netc 'Microsoft.DevCenter/networkConnections@2024-02-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    domainJoinType: 'AzureADJoin'
    subnetId: subnetId
    networkingResourceGroupName: empty(networkingResourceGroupName) ? null : networkingResourceGroupName
  }
}

output id string = netc.id
output nameOut string = netc.name
