

param webAppName string
param serverFarmId string
param instrumentationKey string
param containerSpec string
param location string = resourceGroup().location
param costCenter string
param environment string

var resourceTags = {
  CostCenter: costCenter
  Environment: environment
  Kind: 'Managed-Service'
}

resource app 'Microsoft.Web/sites@2020-06-01' = {
  name: '${webAppName}'
  location: '${location}'
  tags: resourceTags
  properties: {
    httpsOnly: true
    clientAffinityEnabled: false
    serverFarmId: '${serverFarmId}'
    siteConfig: {
      linuxFxVersion: '${containerSpec}'
      appSettings:[
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {          
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: '${instrumentationKey}'
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~2'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'default'
        }
      ]
    }
  }
}

output appId string = app.id