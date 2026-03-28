@description('Azure App Service deployment for ByteBark web application')

// Parameters
param appServicePlanName string
param webAppName string
param location string
param tags object
param environmentName string
param cosmosDbEndpoint string
param openAiEndpoint string
param appConfigConnectionString string
param keyVaultName string

// Variables
var appServicePlanSku = environmentName == 'prod' ? 'P1v3' : 'B1'
var nodeVersion = '~18'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: appServicePlanSku
  }
  kind: 'linux'
  properties: {
    reserved: true // Required for Linux
  }
}

// Web App
resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: webAppName
  location: location
  tags: tags
  kind: 'app,linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|${nodeVersion}'
      alwaysOn: environmentName == 'prod'
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      http20Enabled: true
      nodeVersion: nodeVersion
      appCommandLine: 'npm run start'
      appSettings: [
        {
          name: 'NODE_ENV'
          value: environmentName
        }
        {
          name: 'PORT'
          value: '80'
        }
        {
          name: 'AZURE_OPENAI_ENDPOINT'
          value: openAiEndpoint
        }
        {
          name: 'AZURE_OPENAI_API_KEY'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/openai-api-key/)'
        }
        {
          name: 'AZURE_OPENAI_DEPLOYMENT_NAME'
          value: 'gpt-35-turbo'
        }
        {
          name: 'AZURE_OPENAI_API_VERSION'
          value: '2024-02-01'
        }
        {
          name: 'COSMOS_DB_ENDPOINT'
          value: cosmosDbEndpoint
        }
        {
          name: 'COSMOS_DB_KEY'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/cosmos-db-key/)'
        }
        {
          name: 'COSMOS_DB_DATABASE_ID'
          value: 'bytebark'
        }
        {
          name: 'COSMOS_DB_CONTAINER_ID'
          value: 'datasets'
        }
        {
          name: 'ENABLE_AUTHENTICATION'
          value: 'true'
        }
        {
          name: 'AZURE_AD_CLIENT_ID'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/azure-ad-client-id/)'
        }
        {
          name: 'AZURE_AD_CLIENT_SECRET'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/azure-ad-client-secret/)'
        }
        {
          name: 'AZURE_AD_TENANT_ID'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/azure-ad-tenant-id/)'
        }
        {
          name: 'AZURE_AD_REDIRECT_URI'
          value: 'https://${webAppName}.azurewebsites.net/auth/callback'
        }
        {
          name: 'SESSION_SECRET'
          value: '@Microsoft.KeyVault(SecretUri=https://${keyVaultName}.vault.azure.net/secrets/session-secret/)'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsights.properties.ConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
      ]
      connectionStrings: [
        {
          name: 'AppConfig'
          connectionString: appConfigConnectionString
          type: 'Custom'
        }
      ]
    }
    httpsOnly: true
    clientAffinityEnabled: false
  }
}

// Application Insights
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${webAppName}-insights'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

// Log Analytics Workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: '${webAppName}-logs'
  location: location
  tags: tags
  properties: {
    sku: {
      name: environmentName == 'prod' ? 'PerGB2018' : 'PerGB2018'
    }
    retentionInDays: environmentName == 'prod' ? 90 : 30
  }
}

// Deployment slot for staging (production only)
resource stagingSlot 'Microsoft.Web/sites/slots@2023-01-01' = if (environmentName == 'prod') {
  parent: webApp
  name: 'staging'
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|${nodeVersion}'
      alwaysOn: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      http20Enabled: true
      nodeVersion: nodeVersion
      appCommandLine: 'npm run start'
      // Inherit app settings from production slot
    }
    httpsOnly: true
    clientAffinityEnabled: false
  }
}

// Grant Key Vault access to the web app's managed identity
// This is handled by the deployment scripts after the resources are created

// Outputs
output webAppName string = webApp.name
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output principalId string = webApp.identity.principalId
output stagingUrl string = environmentName == 'prod' ? 'https://${webAppName}-staging.azurewebsites.net' : ''
output appInsightsInstrumentationKey string = applicationInsights.properties.InstrumentationKey
output appInsightsConnectionString string = applicationInsights.properties.ConnectionString