// Bicep template for Log Analytics custom table: eset_CL
// Generated on 2025-09-19 14:13:55 UTC
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

resource esetclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'eset_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'eset_CL'
      description: 'Custom table eset_CL - imported from JSON schema'
      displayName: 'eset_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'username_s'
          type: 'string'
        }
        {
          name: 'object_uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'hostname_s'
          type: 'string'
        }
        {
          name: 'ipv4_s'
          type: 'string'
        }
        {
          name: 'scanner_id_s'
          type: 'string'
        }
        {
          name: 'threat_name_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = esetclTable.name
output tableId string = esetclTable.id
output provisioningState string = esetclTable.properties.provisioningState
