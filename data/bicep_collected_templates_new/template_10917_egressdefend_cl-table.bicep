// Bicep template for Log Analytics custom table: EgressDefend_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 15 (Type column filtered)
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

resource egressdefendclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'EgressDefend_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'EgressDefend_CL'
      description: 'Custom table EgressDefend_CL - imported from JSON schema'
      displayName: 'EgressDefend_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'event_s'
          type: 'string'
        }
        {
          name: 'email_rcptTo_s'
          type: 'string'
        }
        {
          name: 'email_mailFrom_s'
          type: 'string'
        }
        {
          name: 'email_subject_s'
          type: 'string'
        }
        {
          name: 'email_attachments_s'
          type: 'string'
        }
        {
          name: 'email_messageId_s'
          type: 'string'
        }
        {
          name: 'email_threat_s'
          type: 'string'
        }
        {
          name: 'email_trust_s'
          type: 'string'
        }
        {
          name: 'email_firstTimeSender_b'
          type: 'boolean'
        }
        {
          name: 'email_payload_Type_s'
          type: 'string'
        }
        {
          name: 'email_linksClicked_d'
          type: 'real'
        }
        {
          name: 'email_senderIp_s'
          type: 'string'
        }
        {
          name: 'linkClicked_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'email_phishType_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = egressdefendclTable.name
output tableId string = egressdefendclTable.id
output provisioningState string = egressdefendclTable.properties.provisioningState
