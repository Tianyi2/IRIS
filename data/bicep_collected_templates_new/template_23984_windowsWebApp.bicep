targetScope = 'resourceGroup'

param webAppName string
param location string
param appServicePlanId string
param userAssignedIdentityId string = ''

resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: webAppName
  location: location
  kind: 'app'
  identity: empty(userAssignedIdentityId) ? null : {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityId}': {}
    }
  }
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      alwaysOn: true
      netFrameworkVersion: 'v6.0'
      ftpsState: 'Disabled'
    }
  }
}

output name string = webApp.name
output id string = webApp.id
