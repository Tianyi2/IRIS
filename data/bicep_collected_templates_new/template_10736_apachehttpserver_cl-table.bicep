// Bicep template for Log Analytics custom table: ApacheHTTPServer_CL
// Generated on 2025-09-19 14:13:48 UTC
// Source: JSON schema export
// Original columns: 8, Deployed columns: 5 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource apachehttpserverclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ApacheHTTPServer_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ApacheHTTPServer_CL'
      description: 'Custom table ApacheHTTPServer_CL - imported from JSON schema'
      displayName: 'ApacheHTTPServer_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ResourceId'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'ItemId'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = apachehttpserverclTable.name
output tableId string = apachehttpserverclTable.id
output provisioningState string = apachehttpserverclTable.properties.provisioningState
