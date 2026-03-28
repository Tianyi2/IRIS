// Bicep template for Log Analytics custom table: Armorblox_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 28, Deployed columns: 26 (Type column filtered)
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

resource armorbloxclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Armorblox_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Armorblox_CL'
      description: 'Custom table Armorblox_CL - imported from JSON schema'
      displayName: 'Armorblox_CL'
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
          name: 'status_counts_process_count_s'
          type: 'string'
        }
        {
          name: 'status_counts_done_count_s'
          type: 'string'
        }
        {
          name: 'folder_categories_s'
          type: 'string'
        }
        {
          name: 'external_senders_s'
          type: 'string'
        }
        {
          name: 'external_users_s'
          type: 'string'
        }
        {
          name: 'app_name_s'
          type: 'string'
        }
        {
          name: 'research_status_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'object_type_s'
          type: 'string'
        }
        {
          name: 'resolution_state_s'
          type: 'string'
        }
        {
          name: 'status_counts_error_count_s'
          type: 'string'
        }
        {
          name: 'remediation_actions_s'
          type: 'string'
        }
        {
          name: 'policy_names_s'
          type: 'string'
        }
        {
          name: 'users_s'
          type: 'string'
        }
        {
          name: 'date_t'
          type: 'dateTime'
        }
        {
          name: 'tagged_b'
          type: 'boolean'
        }
        {
          name: 'priority_s'
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
          name: 'title_s'
          type: 'string'
        }
        {
          name: 'attachment_list_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = armorbloxclTable.name
output tableId string = armorbloxclTable.id
output provisioningState string = armorbloxclTable.properties.provisioningState
