// Bicep template for Log Analytics custom table: MimecastSIEM_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 18, Deployed columns: 18 (Type column filtered)
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

resource mimecastsiemclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MimecastSIEM_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MimecastSIEM_CL'
      description: 'Custom table MimecastSIEM_CL - imported from JSON schema'
      displayName: 'MimecastSIEM_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'datetime_d'
          type: 'dateTime'
        }
        {
          name: 'mimecastEventId_s'
          type: 'string'
        }
        {
          name: 'reason_s'
          type: 'string'
        }
        {
          name: 'logType_s'
          type: 'string'
        }
        {
          name: 'Subject_s'
          type: 'string'
        }
        {
          name: 'MsgId_s'
          type: 'string'
        }
        {
          name: 'MsgSize_s'
          type: 'string'
        }
        {
          name: 'mimecastEventCategory_s'
          type: 'string'
        }
        {
          name: 'AttNames_s'
          type: 'string'
        }
        {
          name: 'Act_s'
          type: 'string'
        }
        {
          name: 'AttSize_s'
          type: 'string'
        }
        {
          name: 'Hld_s'
          type: 'string'
        }
        {
          name: 'Sender_s'
          type: 'string'
        }
        {
          name: 'acc_s'
          type: 'string'
        }
        {
          name: 'aCode_s'
          type: 'string'
        }
        {
          name: 'AttCnt_s'
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

output tableName string = mimecastsiemclTable.name
output tableId string = mimecastsiemclTable.id
output provisioningState string = mimecastsiemclTable.properties.provisioningState
