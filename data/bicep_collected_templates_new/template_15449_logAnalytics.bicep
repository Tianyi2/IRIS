@description('Location for the Log Analytics workspace.')
param location string

@description('Name for the Log Analytics workspace.')
param logAnalyticsName string = 'cloudMonitor-log'

@description('Common tags for all resources.')
param tags object

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsName
  location: location
  tags: tags
  properties: {  
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
       dailyQuotaGb: 1 
    }
  }
}

output workspaceId string = logAnalytics.id
