// Bicep template for Log Analytics custom table: ProofPointTAPMessagesDelivered_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 10, Deployed columns: 10 (Type column filtered)
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

resource proofpointtapmessagesdeliveredclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ProofPointTAPMessagesDelivered_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ProofPointTAPMessagesDelivered_CL'
      description: 'Custom table ProofPointTAPMessagesDelivered_CL - imported from JSON schema'
      displayName: 'ProofPointTAPMessagesDelivered_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'threatsInfoMap_s'
          type: 'dynamic'
        }
        {
          name: 'messageParts_s'
          type: 'dynamic'
        }
        {
          name: 'sender_s'
          type: 'string'
        }
        {
          name: 'senderIP_s'
          type: 'string'
        }
        {
          name: 'recipient_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'threatType'
          type: 'string'
        }
        {
          name: 'classification'
          type: 'string'
        }
        {
          name: 'filename'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = proofpointtapmessagesdeliveredclTable.name
output tableId string = proofpointtapmessagesdeliveredclTable.id
output provisioningState string = proofpointtapmessagesdeliveredclTable.properties.provisioningState
