// =============================================================================
// Cognitive Services Module - Azure OpenAI + Speech Services
// =============================================================================

@description('Azure region')
param location string

@description('Resource prefix')
param prefix string

@description('Environment name')
param environmentName string

@description('OpenAI deployment name')
param openAIDeploymentName string

@description('OpenAI model name')
param openAIModelName string

@description('OpenAI model version')
param openAIModelVersion string

@description('Log Analytics Workspace ID')
param logAnalyticsWorkspaceId string

@description('Resource tags')
param tags object

// =============================================================================
// VARIABLES
// =============================================================================

var openAIName = '${prefix}-openai-${environmentName}'
var speechName = '${prefix}-speech-${environmentName}'

// =============================================================================
// AZURE OPENAI
// =============================================================================

resource openAI 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openAIName
  location: location
  tags: tags
  kind: 'OpenAI'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: openAIName
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

// =============================================================================
// AZURE OPENAI MODEL DEPLOYMENT
// =============================================================================

resource openAIDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openAI
  name: openAIDeploymentName
  sku: {
    name: 'Standard'
    capacity: 10 // 10K TPM
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: openAIModelName
      version: openAIModelVersion
    }
  }
}

// =============================================================================
// AZURE SPEECH SERVICES
// =============================================================================

resource speech 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: speechName
  location: location
  tags: tags
  kind: 'SpeechServices'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: speechName
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

// =============================================================================
// DIAGNOSTIC SETTINGS
// =============================================================================

resource openAIDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: openAI
  name: 'OpenAI-Diagnostics'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'Audit'
        enabled: true
      }
      {
        category: 'RequestResponse'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

resource speechDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: speech
  name: 'Speech-Diagnostics'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'Audit'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

// =============================================================================
// OUTPUTS
// =============================================================================

@description('Azure OpenAI ID')
output openAIId string = openAI.id

@description('Azure OpenAI Name')
output openAIName string = openAI.name

@description('Azure OpenAI Endpoint')
output openAIEndpoint string = openAI.properties.endpoint

@description('Azure OpenAI Deployment Name')
output openAIDeploymentName string = openAIDeployment.name

@description('Azure Speech ID')
output speechId string = speech.id

@description('Azure Speech Name')
output speechName string = speech.name

@description('Azure Speech Endpoint')
output speechEndpoint string = speech.properties.endpoint

@description('Azure Speech Region')
output speechRegion string = location
