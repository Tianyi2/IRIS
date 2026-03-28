import {getApplication} from 'br:nandanmathure-gmguavccehhqfvhv.azurecr.io/authsvr/authorization-server:2025-06-27'

@description('Tenant that will be suffixed to each resource in Azure')
@minLength(1)
@maxLength(5)
param tenant string

@description('Azure Location Name')
param location string

var application = getApplication(tenant, location, 'SharedResources', 'AzureShardResources')

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: application.applicationInsightsName
  location: application.location.name
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Bluefield'
    Request_Source: 'rest'
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: true
    WorkspaceResourceId: workspace.id
    RetentionInDays: application.logAnalyticsWorkspace.retentionInDays
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' = {
  name: application.logAnalyticsWorkspace.name
  location: application.location.name
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

