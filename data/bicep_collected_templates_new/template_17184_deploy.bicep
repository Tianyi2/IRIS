@allowed([
  'dev'
  'prd'
])
@description('Deployment environment.')
param deployEnvironment string = 'dev'

@description('Location for all resources.')
param location string = 'westeurope'

@description('Name of the application.')
param appName string 

// Identity

resource applicationIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: 'id-${appName}app-${deployEnvironment}-${location}-001'
  location: location
}

// Storage Account
resource storageAccountFun 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'st${substring(uniqueString('${subscription().subscriptionId}${appName}'),0,8)}01'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  properties: {
    supportsHttpsTrafficOnly: true
    defaultToOAuthAuthentication: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: [
      ]
      defaultAction: 'Allow'
    }
  }
}
resource fileservices 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  name: 'default'
  parent: storageAccountFun
  
}
resource fileService 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-05-01' = {
  parent: fileservices
  name: 'app'
}

// Web App Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: 'asp-${appName}-${location}-${deployEnvironment}-001'
  location: location
  sku: {
    name: 'B2'
  }
}

// Function App
resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
  name: 'fun-${appName}-${substring(uniqueString(subscription().subscriptionId),0,4)}-${location}-${deployEnvironment}-001'
  location: location
  kind: 'functionapp'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${applicationIdentity.id}': {}
    }
  }
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlan.id
    siteConfig: {
      alwaysOn: true
      powerShellVersion: '7.4'
      appSettings: [
        {
          name: 'AZURE_CLIENT_ID'
          value: applicationIdentity.properties.clientId 
        }
        {
          name: 'AZURE_TENANT_ID '
          value: tenant().tenantId
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountFun.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccountFun.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountFun.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccountFun.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: fileService.name
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'powershell'
        }
        { 
          name:'APPLICATIONINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
      ]
      
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
      cors: {
        allowedOrigins: [
          'https://portal.azure.com'
        ]
        supportCredentials: false
      }
    }
  }
}


resource scheduler 'Microsoft.Web/sites/functions@2022-03-01' = {
  parent: functionApp
  name: 'ScriptTimerFun'
  properties: {
    files: {
      'run.ps1' : loadTextContent('./ScriptTimerFun/run.ps1')
      'function.json' : loadTextContent('./ScriptTimerFun/function.json')
      '../requirements.psd1' : loadTextContent('./requirements.psd1')
      '../profile.ps1' : loadTextContent('./profile.ps1')
      '../host.json' : loadTextContent('./host.json')
    }
  }
}

resource http 'Microsoft.Web/sites/functions@2022-03-01' = {
  parent: functionApp
  name: 'ScriptHttpFun'
  properties: {
    files: {
      'run.ps1' : loadTextContent('./ScriptHttpFun/run.ps1')
      'function.json' : loadTextContent('./ScriptHttpFun/function.json')
    }
  }
}


resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'log-${appName}-${location}-${deployEnvironment}-001'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    workspaceCapping: {}
  }
}
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${appName}-${location}-${deployEnvironment}-001'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    ApplicationId: 'fun-${appName}-${substring(uniqueString(subscription().subscriptionId),0,4)}-${location}-${deployEnvironment}-001'
    Request_Source: 'IbizaAIExtensionEnablementBlade'
    Flow_Type: 'Redfield'
    WorkspaceResourceId: workspace.id
    RetentionInDays: 30
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource DiagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'LogAnalytics'
  scope: appServicePlan
  properties: {
    metrics: [
      {
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
        category: 'AllMetrics'
      }
    ]
    workspaceId: workspace.id
    logAnalyticsDestinationType: null
  }
}
