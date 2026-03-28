@description('Log Analytics workspace name.')
param name string

@description('Location of the Log Analytics workspace.')
param location string

@description('Tags applied to the Log Analytics workspace.')
param tags object = {}

@description('Retention in days for Log Analytics workspace.')
@minValue(7)
@maxValue(730)
param retentionInDays int = 30

resource law 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    retentionInDays: retentionInDays
    sku: {
      name: 'PerGB2018'
    }
  }
}

@description('Log Analytics workspace resource ID.')
output workspaceId string = law.id
