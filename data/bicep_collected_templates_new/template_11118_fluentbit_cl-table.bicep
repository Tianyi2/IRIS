// Bicep template for Log Analytics custom table: fluentbit_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 17 (Type column filtered)
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

resource fluentbitclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'fluentbit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'fluentbit_CL'
      description: 'Custom table fluentbit_CL - imported from JSON schema'
      displayName: 'fluentbit_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'pri_s'
          type: 'string'
        }
        {
          name: 'time_s'
          type: 'string'
        }
        {
          name: 'host_s'
          type: 'string'
        }
        {
          name: 'ident_s'
          type: 'string'
        }
        {
          name: 'Year_s'
          type: 'string'
        }
        {
          name: 'Month_s'
          type: 'string'
        }
        {
          name: 'Day_s'
          type: 'string'
        }
        {
          name: 'Hour_s'
          type: 'string'
        }
        {
          name: 'Min_s'
          type: 'string'
        }
        {
          name: 'Sec_s'
          type: 'string'
        }
        {
          name: 'Message'
          type: 'string'
        }
        {
          name: 'FirewallName_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'action'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = fluentbitclTable.name
output tableId string = fluentbitclTable.id
output provisioningState string = fluentbitclTable.properties.provisioningState
