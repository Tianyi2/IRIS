// Bicep template for Log Analytics custom table: ProofPointTAPClicksBlocked_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 24, Deployed columns: 22 (Type column filtered)
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

resource proofpointtapclicksblockedclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ProofPointTAPClicksBlocked_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ProofPointTAPClicksBlocked_CL'
      description: 'Custom table ProofPointTAPClicksBlocked_CL - imported from JSON schema'
      displayName: 'ProofPointTAPClicksBlocked_CL'
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
          name: 'threatID_s'
          type: 'string'
        }
        {
          name: 'campaignId_s'
          type: 'string'
        }
        {
          name: 'userAgent_s'
          type: 'string'
        }
        {
          name: 'threatTime_t'
          type: 'dateTime'
        }
        {
          name: 'classification_s'
          type: 'string'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'GUID_s'
          type: 'string'
        }
        {
          name: 'clickIP_s'
          type: 'real'
        }
        {
          name: 'threatURL_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'messageID_s'
          type: 'string'
        }
        {
          name: 'recipient_s'
          type: 'string'
        }
        {
          name: 'sender_s'
          type: 'string'
        }
        {
          name: 'clickTime_t'
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
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'senderIP_s'
          type: 'string'
        }
        {
          name: 'threatStatus_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = proofpointtapclicksblockedclTable.name
output tableId string = proofpointtapclicksblockedclTable.id
output provisioningState string = proofpointtapclicksblockedclTable.properties.provisioningState
