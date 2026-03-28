// Bicep template for Log Analytics custom table: OneLogin_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 30 (Type column filtered)
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

resource oneloginclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'OneLogin_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'OneLogin_CL'
      description: 'Custom table OneLogin_CL - imported from JSON schema'
      displayName: 'OneLogin_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'app_name_s'
          type: 'string'
        }
        {
          name: 'event_type_id_d'
          type: 'real'
        }
        {
          name: 'actor_user_name_s'
          type: 'string'
        }
        {
          name: 'ipaddr_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'event_timestamp_s'
          type: 'string'
        }
        {
          name: 'account_id_d'
          type: 'real'
        }
        {
          name: 'custom_message_s'
          type: 'string'
        }
        {
          name: 'actor_system_s'
          type: 'string'
        }
        {
          name: 'uuid_g'
          type: 'string'
        }
        {
          name: 'create__id_g'
          type: 'string'
        }
        {
          name: 'user_name_s'
          type: 'string'
        }
        {
          name: 'user_attributes_lastname_s'
          type: 'string'
        }
        {
          name: 'user_attributes_title_s'
          type: 'string'
        }
        {
          name: 'actor_user_id_d'
          type: 'real'
        }
        {
          name: 'user_attributes_openid_name_s'
          type: 'string'
        }
        {
          name: 'user_attributes_email_s'
          type: 'string'
        }
        {
          name: 'user_attributes_firstname_s'
          type: 'string'
        }
        {
          name: 'user_attributes_department_s'
          type: 'string'
        }
        {
          name: 'user_attributes_account_id_d'
          type: 'real'
        }
        {
          name: 'user_id_d'
          type: 'real'
        }
        {
          name: 'user_agent_s'
          type: 'string'
        }
        {
          name: 'policy_id_d'
          type: 'real'
        }
        {
          name: 'policy_type_s'
          type: 'string'
        }
        {
          name: 'policy_name_s'
          type: 'string'
        }
        {
          name: 'role_id_d'
          type: 'real'
        }
        {
          name: 'role_name_s'
          type: 'string'
        }
        {
          name: 'app_id_d'
          type: 'real'
        }
        {
          name: 'user_attributes_username_s'
          type: 'string'
        }
        {
          name: 'notes_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = oneloginclTable.name
output tableId string = oneloginclTable.id
output provisioningState string = oneloginclTable.properties.provisioningState
