// =============================================================================
// Availability Tests Module - Synthetic Monitoring
// =============================================================================

@description('Azure region')
param location string

@description('Resource prefix')
param prefix string

@description('Environment name')
param environmentName string

@description('Custom domain name (optional)')
param customDomain string

@description('Public IP Address')
param publicIPAddress string

@description('Application Insights ID')
param appInsightsId string

@description('Action Group ID for alerts')
param actionGroupId string

@description('Resource tags')
param tags object

// =============================================================================
// VARIABLES
// =============================================================================

var testUrl = customDomain != '' ? customDomain : publicIPAddress

// =============================================================================
// AVAILABILITY TEST: Health Check
// =============================================================================

resource healthCheckTest 'Microsoft.Insights/webtests@2022-06-15' = {
  name: '${prefix}-avtest-health-${environmentName}'
  location: location
  tags: union(tags, {
    'hidden-link:${appInsightsId}': 'Resource'
  })
  properties: {
    SyntheticMonitorId: '${prefix}-avtest-health-${environmentName}'
    Name: 'Jarvis Health Check'
    Description: 'Tests /healthz endpoint every 5 minutes from multiple locations'
    Enabled: true
    Frequency: 300 // 5 minutes
    Timeout: 30
    Kind: 'ping'
    RetryEnabled: true
    Locations: [
      { Id: 'us-va-ash-azr' }      // East US
      { Id: 'us-ca-sjc-azr' }      // West US
      { Id: 'emea-nl-ams-azr' }    // West Europe
      { Id: 'apac-sg-sin-azr' }    // Southeast Asia
      { Id: 'apac-au-syd-azr' }    // Australia East
    ]
    Configuration: {
      WebTest: '<WebTest Name="Health Check" Id="${guid(testUrl, 'health')}" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="30" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale=""><Items><Request Method="GET" Guid="${guid(testUrl, 'health', 'request')}" Version="1.1" Url="https://${testUrl}/healthz" ThinkTime="0" Timeout="30" ParseDependentRequests="False" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" /></Items></WebTest>'
    }
  }
}

// =============================================================================
// AVAILABILITY TEST: Bot Messaging Endpoint
// =============================================================================

resource botEndpointTest 'Microsoft.Insights/webtests@2022-06-15' = {
  name: '${prefix}-avtest-botmsg-${environmentName}'
  location: location
  tags: union(tags, {
    'hidden-link:${appInsightsId}': 'Resource'
  })
  properties: {
    SyntheticMonitorId: '${prefix}-avtest-botmsg-${environmentName}'
    Name: 'Jarvis Bot Messaging Endpoint'
    Description: 'Tests /api/messages endpoint every 15 minutes (expects 405 Method Not Allowed)'
    Enabled: true
    Frequency: 900 // 15 minutes
    Timeout: 30
    Kind: 'ping'
    RetryEnabled: true
    Locations: [
      { Id: 'us-va-ash-azr' }      // East US
      { Id: 'us-ca-sjc-azr' }      // West US
      { Id: 'emea-nl-ams-azr' }    // West Europe
    ]
    Configuration: {
      WebTest: '<WebTest Name="Bot Endpoint" Id="${guid(testUrl, 'botmsg')}" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="30" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale=""><Items><Request Method="GET" Guid="${guid(testUrl, 'botmsg', 'request')}" Version="1.1" Url="https://${testUrl}/api/messages" ThinkTime="0" Timeout="30" ParseDependentRequests="False" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="405" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" /></Items></WebTest>'
    }
  }
}

// =============================================================================
// ALERT: Health Check Failures
// =============================================================================

resource healthCheckAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: '${prefix}-alert-healthcheck-${environmentName}'
  location: 'Global'
  tags: tags
  properties: {
    severity: 0
    enabled: true
    scopes: [
      healthCheckTest.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria'
      webTestId: healthCheckTest.id
      componentId: appInsightsId
      failedLocationCount: 2
    }
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
    description: 'Alert when health check fails from 2 or more locations'
  }
}

// =============================================================================
// OUTPUTS
// =============================================================================

@description('Health Check Test ID')
output healthCheckTestId string = healthCheckTest.id

@description('Bot Endpoint Test ID')
output botEndpointTestId string = botEndpointTest.id
