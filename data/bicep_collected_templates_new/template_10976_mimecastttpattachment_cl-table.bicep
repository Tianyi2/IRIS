// Bicep template for Log Analytics custom table: MimecastTTPAttachment_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 17 (Type column filtered)
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

resource mimecastttpattachmentclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MimecastTTPAttachment_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MimecastTTPAttachment_CL'
      description: 'Custom table MimecastTTPAttachment_CL - imported from JSON schema'
      displayName: 'MimecastTTPAttachment_CL'
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
          name: 'fileName_s'
          type: 'string'
        }
        {
          name: 'fileType_s'
          type: 'string'
        }
        {
          name: 'result_s'
          type: 'string'
        }
        {
          name: 'actionTriggered_s'
          type: 'string'
        }
        {
          name: 'date_t'
          type: 'dateTime'
        }
        {
          name: 'details_s'
          type: 'string'
        }
        {
          name: 'route_s'
          type: 'string'
        }
        {
          name: 'messageId_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'fileHash_s'
          type: 'string'
        }
        {
          name: 'definition_s'
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

output tableName string = mimecastttpattachmentclTable.name
output tableId string = mimecastttpattachmentclTable.id
output provisioningState string = mimecastttpattachmentclTable.properties.provisioningState
