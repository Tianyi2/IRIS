@description('The name for the Azure Dev Center.')
param name string

@description('The Azure region for the Dev Center.')
param location string

@description('Common tags for resources.')
param tags object = {}

resource dc 'Microsoft.DevCenter/devcenters@2024-02-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

output id string = dc.id
output nameOut string = dc.name
output principalId string = dc.identity.principalId
