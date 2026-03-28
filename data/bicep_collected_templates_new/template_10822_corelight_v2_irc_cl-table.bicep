// Bicep template for Log Analytics custom table: Corelight_v2_irc_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 19, Deployed columns: 16 (Type column filtered)
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

resource corelightv2ircclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_irc_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_irc_CL'
      description: 'Custom table Corelight_v2_irc_CL - imported from JSON schema'
      displayName: 'Corelight_v2_irc_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'nick_s'
          type: 'string'
        }
        {
          name: 'user_s'
          type: 'string'
        }
        {
          name: 'command_s'
          type: 'string'
        }
        {
          name: 'value_s'
          type: 'string'
        }
        {
          name: 'addl_s'
          type: 'string'
        }
        {
          name: 'dcc_file_name_s'
          type: 'string'
        }
        {
          name: 'dcc_file_size_d'
          type: 'real'
        }
        {
          name: 'dcc_mime_type_s'
          type: 'string'
        }
        {
          name: 'fuid_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2ircclTable.name
output tableId string = corelightv2ircclTable.id
output provisioningState string = corelightv2ircclTable.properties.provisioningState
