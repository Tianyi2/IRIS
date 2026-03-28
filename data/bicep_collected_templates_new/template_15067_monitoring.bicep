// =============================================================================
// Monitoring Module - Log Analytics + Application Insights
// =============================================================================

@description('Azure region')
param location string

@description('Resource prefix')
param prefix string

@description('Environment name')
param environmentName string

@description('Resource tags')
param tags object

// =============================================================================
// VARIABLES
// =============================================================================

var logAnalyticsName = '${prefix}-law-${environmentName}'
var appInsightsName = '${prefix}-appi-${environmentName}'

// =============================================================================
// LOG ANALYTICS WORKSPACE
// =============================================================================

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsName
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 90
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

// =============================================================================
// APPLICATION INSIGHTS
// =============================================================================

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Bluefield'
    Request_Source: 'rest'
    RetentionInDays: 90
    WorkspaceResourceId: logAnalytics.id
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
    SamplingPercentage: 100
  }
}

// =============================================================================
// OUTPUTS
// =============================================================================

@description('Log Analytics Workspace ID')
output logAnalyticsWorkspaceId string = logAnalytics.id

@description('Log Analytics Workspace Name')
output logAnalyticsWorkspaceName string = logAnalytics.name

@description('Log Analytics Workspace Customer ID')
output logAnalyticsCustomerId string = logAnalytics.properties.customerId

@description('Application Insights ID')
output appInsightsId string = appInsights.id

@description('Application Insights Name')
output appInsightsName string = appInsights.name

@description('Application Insights Instrumentation Key')
output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey

@description('Application Insights Connection String')
output appInsightsConnectionString string = appInsights.properties.ConnectionString
