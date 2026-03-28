// Bicep template for Log Analytics custom table: Ipinfo_Privacy_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 8, Deployed columns: 8 (Type column filtered)
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

resource ipinfoprivacyclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Ipinfo_Privacy_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Ipinfo_Privacy_CL'
      description: 'Custom table Ipinfo_Privacy_CL - imported from JSON schema'
      displayName: 'Ipinfo_Privacy_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'hosting'
          type: 'string'
        }
        {
          name: 'proxy'
          type: 'string'
        }
        {
          name: 'relay'
          type: 'string'
        }
        {
          name: 'service'
          type: 'string'
        }
        {
          name: 'tor'
          type: 'string'
        }
        {
          name: 'vpn'
          type: 'string'
        }
        {
          name: 'range'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ipinfoprivacyclTable.name
output tableId string = ipinfoprivacyclTable.id
output provisioningState string = ipinfoprivacyclTable.properties.provisioningState
