// Bicep template for Log Analytics custom table: Corelight_v2_ftp_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 20 (Type column filtered)
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

resource corelightv2ftpclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_ftp_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_ftp_CL'
      description: 'Custom table Corelight_v2_ftp_CL - imported from JSON schema'
      displayName: 'Corelight_v2_ftp_CL'
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
          name: 'data_channel_resp_h_s'
          type: 'string'
        }
        {
          name: 'data_channel_orig_h_s'
          type: 'string'
        }
        {
          name: 'data_channel_passive_b'
          type: 'boolean'
        }
        {
          name: 'reply_msg_s'
          type: 'string'
        }
        {
          name: 'reply_code_d'
          type: 'real'
        }
        {
          name: 'file_size_d'
          type: 'real'
        }
        {
          name: 'mime_type_s'
          type: 'string'
        }
        {
          name: 'data_channel_resp_p_d'
          type: 'real'
        }
        {
          name: 'arg_s'
          type: 'string'
        }
        {
          name: 'password_s'
          type: 'string'
        }
        {
          name: 'user_s'
          type: 'string'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'command_s'
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

output tableName string = corelightv2ftpclTable.name
output tableId string = corelightv2ftpclTable.id
output provisioningState string = corelightv2ftpclTable.properties.provisioningState
