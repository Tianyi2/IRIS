// Bicep template for Log Analytics custom table: Sonrai_Tickets_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 36, Deployed columns: 36 (Type column filtered)
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

resource sonraiticketsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Sonrai_Tickets_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Sonrai_Tickets_CL'
      description: 'Custom table Sonrai_Tickets_CL - imported from JSON schema'
      displayName: 'Sonrai_Tickets_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'digest_ticketSignature_s'
          type: 'string'
        }
        {
          name: 'digest_ticketKeyDescription_s'
          type: 'string'
        }
        {
          name: 'digest_ticketSrn_s'
          type: 'string'
        }
        {
          name: 'digest_createdDate_d'
          type: 'real'
        }
        {
          name: 'digest_createdBy_s'
          type: 'string'
        }
        {
          name: 'digest_assignedTo_s'
          type: 'string'
        }
        {
          name: 'digest_transitionedBy_s'
          type: 'string'
        }
        {
          name: 'digest_criticalResourceName_s'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'digest_transitionDate_d'
          type: 'real'
        }
        {
          name: 'digest_title_s'
          type: 'string'
        }
        {
          name: 'digest_severityNumeric_d'
          type: 'real'
        }
        {
          name: 'digest_severityCategory_s'
          type: 'string'
        }
        {
          name: 'digest_status_s'
          type: 'string'
        }
        {
          name: 'digest_lastReopenDate_d'
          type: 'real'
        }
        {
          name: 'digest_lastSeenDate_d'
          type: 'real'
        }
        {
          name: 'digest_description_s'
          type: 'string'
        }
        {
          name: 'action_d'
          type: 'real'
        }
        {
          name: 'digest_ticketKeyName_s'
          type: 'string'
        }
        {
          name: 'digest_account_s'
          type: 'string'
        }
        {
          name: 'digest_timestamp_s'
          type: 'string'
        }
        {
          name: 'digest_org_s'
          type: 'string'
        }
        {
          name: 'digest_ticketType_s'
          type: 'string'
        }
        {
          name: 'digest_ticketKey_s'
          type: 'string'
        }
        {
          name: 'digest_swimlanes_s'
          type: 'string'
        }
        {
          name: 'digest_severity_d'
          type: 'real'
        }
        {
          name: 'digest_actionClassification_s'
          type: 'string'
        }
        {
          name: 'digest_evidence_resourceSet_s'
          type: 'string'
        }
        {
          name: 'digest_envidence_path_s'
          type: 'string'
        }
        {
          name: 'digest_evidence_count_d'
          type: 'real'
        }
        {
          name: 'digest_evidence_userAgentSet_s'
          type: 'string'
        }
        {
          name: 'digest_criticalResourceSRN_s'
          type: 'string'
        }
        {
          name: 'digest_resourceType_s'
          type: 'string'
        }
        {
          name: 'digest_resourceLabel_s'
          type: 'string'
        }
        {
          name: 'digest_evidence_conditions_s'
          type: 'string'
        }
        {
          name: 'actor_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = sonraiticketsclTable.name
output tableId string = sonraiticketsclTable.id
output provisioningState string = sonraiticketsclTable.properties.provisioningState
