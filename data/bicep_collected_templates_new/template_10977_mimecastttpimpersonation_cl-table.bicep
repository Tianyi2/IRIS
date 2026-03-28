// Bicep template for Log Analytics custom table: MimecastTTPImpersonation_CL
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

resource mimecastttpimpersonationclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MimecastTTPImpersonation_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MimecastTTPImpersonation_CL'
      description: 'Custom table MimecastTTPImpersonation_CL - imported from JSON schema'
      displayName: 'MimecastTTPImpersonation_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'mimecastEventId_s'
          type: 'string'
        }
        {
          name: 'messageId_s'
          type: 'string'
        }
        {
          name: 'impersonationResults_s'
          type: 'string'
        }
        {
          name: 'eventTime_t'
          type: 'dateTime'
        }
        {
          name: 'senderIpAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'taggedMalicious_b'
          type: 'boolean'
        }
        {
          name: 'mimecastEventCategory_s'
          type: 'string'
        }
        {
          name: 'taggedExternal_b'
          type: 'boolean'
        }
        {
          name: 'identifiers_s'
          type: 'string'
        }
        {
          name: 'hits_s'
          type: 'string'
        }
        {
          name: 'definition_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'recipientAddress_s'
          type: 'string'
        }
        {
          name: 'senderAddress_s'
          type: 'string'
        }
        {
          name: 'action_s'
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

output tableName string = mimecastttpimpersonationclTable.name
output tableId string = mimecastttpimpersonationclTable.id
output provisioningState string = mimecastttpimpersonationclTable.properties.provisioningState
