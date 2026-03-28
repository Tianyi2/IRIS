param location string
param logAnalyticsName string
param appInsightsName string
param apimName string
param apimEmail string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: { 
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
  }
}

resource apim 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: apimName
  location: location
  sku: {
    capacity: 1
    name: 'Developer'
  }
  properties: {
    publisherEmail: apimEmail
    publisherName: apimName
  }
  resource appins 'loggers@2021-08-01' = {
    name: 'appins'
    properties: {
      loggerType: 'applicationInsights'
      credentials: {
        instrumentationKey: appInsights.properties.InstrumentationKey
      }
    }
  }
}
