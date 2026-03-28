// Bicep template for Log Analytics custom table: VMware_VECO_EventLogs_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 7, Deployed columns: 7 (Type column filtered)
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

resource vmwarevecoeventlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'VMware_VECO_EventLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'VMware_VECO_EventLogs_CL'
      description: 'Custom table VMware_VECO_EventLogs_CL - imported from JSON schema'
      displayName: 'VMware_VECO_EventLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'category'
          type: 'string'
        }
        {
          name: 'detail'
          type: 'string'
        }
        {
          name: 'event'
          type: 'string'
        }
        {
          name: 'eventTime'
          type: 'dateTime'
        }
        {
          name: 'message'
          type: 'string'
        }
        {
          name: 'severity'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = vmwarevecoeventlogsclTable.name
output tableId string = vmwarevecoeventlogsclTable.id
output provisioningState string = vmwarevecoeventlogsclTable.properties.provisioningState
