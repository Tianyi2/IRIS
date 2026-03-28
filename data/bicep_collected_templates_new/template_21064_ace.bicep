@description('Name of the Container Apps Environment')
param aceName string

@description('Location for the environment')
param location string

@description('Tags to apply to the environment')
param tags object = {}

@description('Virtual Network Resource Group')
param vNetRG string

@description('Container Apps Subnet ID')
param containerAppsSubnetId string

@description('Log Analytics Workspace Name')
param logAnalyticsWorkspaceName string

// Create the Container Apps Environment with internal ingress
resource containerAppsEnvironment 'Microsoft.App/managedEnvironments@2023-11-02-preview' = {
  name: aceName
  location: location
  tags: union(tags, { 'azd-service-name': 'ace' })
  properties: {
    vnetConfiguration: {
      infrastructureSubnetId: containerAppsSubnetId
      internal: false
    }
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: reference('/subscriptions/${subscription().subscriptionId}/resourceGroups/${vNetRG}/providers/Microsoft.OperationalInsights/workspaces/${logAnalyticsWorkspaceName}', '2021-12-01-preview').customerId
        sharedKey: listKeys('/subscriptions/${subscription().subscriptionId}/resourceGroups/${vNetRG}/providers/Microsoft.OperationalInsights/workspaces/${logAnalyticsWorkspaceName}', '2021-12-01-preview').primarySharedKey
      }
    }
  }
}

output aceId string = containerAppsEnvironment.id
output aceName string = containerAppsEnvironment.name
output aceStaticIp string = containerAppsEnvironment.properties.staticIp
output aceDefaultDomain string = containerAppsEnvironment.properties.defaultDomain
