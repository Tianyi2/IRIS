@description('Azure OpenAI Service deployment for ByteBark')

// Parameters
param name string
param location string
param tags object
param environmentName string

param keyVaultName string

@description('Version for the gpt-35-turbo deployment (use 1106 or 0125).')
param chatModelVersion string = '0125'
@description('Embeddings model name (v3 family).')
param embeddingsModelName string = 'text-embedding-3-small'
@description('Embeddings model version.')
param embeddingsModelVersion string = '1'


// Variables
var skuName = environmentName == 'prod' ? 'S0' : 'S0' // Standard tier for all environments
var deploymentName = 'gpt-35-turbo'
var deploymentCapacity = environmentName == 'prod' ? 30 : 10

// Azure OpenAI Service Account
resource openAiAccount 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: name
  location: location
  tags: tags
  kind: 'OpenAI'
  sku: {
    name: skuName
  }
  properties: {
    customSubDomainName: name
    networkAcls: {
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    apiProperties: {
      statisticsEnabled: false
    }
  }
}

// Chat/completions deployment
resource chatDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openAiAccount
  name: deploymentName
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-35-turbo'
      version: chatModelVersion
    }
    raiPolicyName: 'Microsoft.Default'
  }
  sku: {
    name: 'Standard'
    capacity: deploymentCapacity
  }
}

// Embeddings deployment (replace ada-002 if present)
resource embeddingsDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openAiAccount
  name: 'text-embedding-3-small'
  properties: {
    model: {
      format: 'OpenAI'
      name: embeddingsModelName
      version: embeddingsModelVersion
    }
    raiPolicyName: 'Microsoft.Default'
  }
  sku: {
    name: 'Standard'
    capacity: deploymentCapacity
  }
  dependsOn: [
    chatDeployment
  ]
}

// Optional: Deploy GPT-4 model if in production environment
resource gpt4ModelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = if (environmentName == 'prod') {
  parent: openAiAccount
  name: 'gpt-4'
  dependsOn: [
    embeddingsDeployment
  ] // ensure strictly after embeddings -> chat -> account
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4'
      version: '0613'
    }
    raiPolicyName: 'Microsoft.Default'
  }
  sku: {
    name: 'Standard'
    capacity: 10
  }
}

// Reference to existing Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

// Store OpenAI API key in Key Vault
resource openAiKeySecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'openai-api-key'
  properties: {
    value: openAiAccount.listKeys().key1
  }
}

// Outputs
output name string = openAiAccount.name
output endpoint string = openAiAccount.properties.endpoint
output deploymentName string = deploymentName
output gpt4DeploymentName string = environmentName == 'prod' ? 'gpt-4' : ''
output resourceId string = openAiAccount.id
