param name string
param location string
param skuName string
param retentionInDays int

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2025-02-01' = {
  name: name
  location: location
  properties: {
    retentionInDays: retentionInDays
    sku: {
      name: skuName
    }
  }
}

output resourceId string = logAnalytics.id
