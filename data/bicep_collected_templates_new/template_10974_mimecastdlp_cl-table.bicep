// Bicep template for Log Analytics custom table: MimecastDLP_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 12, Deployed columns: 12 (Type column filtered)
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

resource mimecastdlpclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MimecastDLP_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MimecastDLP_CL'
      description: 'Custom table MimecastDLP_CL - imported from JSON schema'
      displayName: 'MimecastDLP_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'senderAddress_s'
          type: 'string'
        }
        {
          name: 'recipientAddress_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'eventTime_d'
          type: 'dateTime'
        }
        {
          name: 'route_s'
          type: 'string'
        }
        {
          name: 'policy_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'messageId_s'
          type: 'string'
        }
        {
          name: 'mimecastEventId_s'
          type: 'string'
        }
        {
          name: 'mimecastEventCategory_s'
          type: 'string'
        }
        {
          name: 'time_generated'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = mimecastdlpclTable.name
output tableId string = mimecastdlpclTable.id
output provisioningState string = mimecastdlpclTable.properties.provisioningState
