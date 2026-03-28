@description('Deploys a Log Analytics workspace')
param workspaceName string
param location string
param tags object
@description('Workspace SKU (e.g., PerGB2018, PerNode, Free)')
param sku string = 'PerGB2018'
@description('Daily data retention in days')
param retentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  tags: tags
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

output workspaceId string = workspace.id
output workspaceName string = workspace.name
