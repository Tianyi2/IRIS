// =============================================================================
// Bot Service Module - Bot Framework Service
// =============================================================================

@description('Resource prefix')
param prefix string

@description('Environment name')
param environmentName string

@description('Bot App ID from Entra ID')
param botAppId string

@description('Custom domain name')
param customDomain string

@description('Resource tags')
param tags object

// =============================================================================
// VARIABLES
// =============================================================================

var botServiceName = '${prefix}-bot-${environmentName}'
var messagingEndpoint = customDomain != '' ? 'https://${customDomain}/api/messages' : ''

// =============================================================================
// BOT SERVICE
// =============================================================================

resource botService 'Microsoft.BotService/botServices@2023-09-15-preview' = if (botAppId != '') {
  name: botServiceName
  location: 'global'
  tags: tags
  sku: {
    name: 'S1'
  }
  kind: 'azurebot'
  properties: {
    displayName: 'Jarvis Meeting Bot'
    description: 'AI-powered meeting assistant for Microsoft Teams'
    endpoint: messagingEndpoint
    msaAppId: botAppId
    msaAppType: 'MultiTenant'
    msaAppTenantId: subscription().tenantId
    developerAppInsightKey: ''
    developerAppInsightsApiKey: ''
    developerAppInsightsApplicationId: ''
    luisAppIds: []
    luisKey: ''
    iconUrl: 'https://docs.botframework.com/static/devportal/client/images/bot-framework-default.png'
    openWithHint: 'bfcomposer'
    schemaTransformationVersion: '1.3'
  }
}

// =============================================================================
// TEAMS CHANNEL
// =============================================================================

resource teamsChannel 'Microsoft.BotService/botServices/channels@2023-09-15-preview' = if (botAppId != '') {
  parent: botService
  name: 'MsTeamsChannel'
  location: 'global'
  properties: {
    channelName: 'MsTeamsChannel'
    properties: {
      enableCalling: true
      isEnabled: true
      callingWebhook: customDomain != '' ? 'https://${customDomain}/api/calling' : null
    }
  }
}

// =============================================================================
// OUTPUTS
// =============================================================================

@description('Bot Service ID')
output botServiceId string = botAppId != '' ? botService.id : ''

@description('Bot Service Name')
output botServiceName string = botAppId != '' ? botService.name : ''

@description('Teams Channel Enabled')
output teamsChannelEnabled bool = botAppId != ''
