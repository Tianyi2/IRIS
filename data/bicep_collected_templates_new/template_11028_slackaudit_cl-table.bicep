// Bicep template for Log Analytics custom table: SlackAudit_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 28 (Type column filtered)
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

resource slackauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SlackAudit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SlackAudit_CL'
      description: 'Custom table SlackAudit_CL - imported from JSON schema'
      displayName: 'SlackAudit_CL'
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
          name: 'context_ip_address_s'
          type: 'string'
        }
        {
          name: 'context_ua_s'
          type: 'string'
        }
        {
          name: 'context_location_domain_s'
          type: 'string'
        }
        {
          name: 'context_location_name_s'
          type: 'string'
        }
        {
          name: 'context_location_id_s'
          type: 'string'
        }
        {
          name: 'context_location_type_s'
          type: 'string'
        }
        {
          name: 'entity_file_title_s'
          type: 'string'
        }
        {
          name: 'entity_file_filetype_s'
          type: 'string'
        }
        {
          name: 'entity_file_name_s'
          type: 'string'
        }
        {
          name: 'entity_file_id_s'
          type: 'string'
        }
        {
          name: 'entity_type_s'
          type: 'string'
        }
        {
          name: 'context_session_id_d'
          type: 'real'
        }
        {
          name: 'actor_user_team_s'
          type: 'string'
        }
        {
          name: 'actor_user_name_s'
          type: 'string'
        }
        {
          name: 'actor_user_id_s'
          type: 'string'
        }
        {
          name: 'actor_type_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'date_create_d'
          type: 'real'
        }
        {
          name: 'id_g'
          type: 'string'
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
          name: 'actor_user_email_s'
          type: 'string'
        }
        {
          name: 'action_description_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = slackauditclTable.name
output tableId string = slackauditclTable.id
output provisioningState string = slackauditclTable.properties.provisioningState
