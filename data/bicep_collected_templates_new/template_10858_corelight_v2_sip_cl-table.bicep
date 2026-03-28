// Bicep template for Log Analytics custom table: Corelight_v2_sip_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 31, Deployed columns: 28 (Type column filtered)
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

resource corelightv2sipclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_sip_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_sip_CL'
      description: 'Custom table Corelight_v2_sip_CL - imported from JSON schema'
      displayName: 'Corelight_v2_sip_CL'
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
          name: 'request_body_len_d'
          type: 'real'
        }
        {
          name: 'warning_s'
          type: 'string'
        }
        {
          name: 'status_msg_s'
          type: 'string'
        }
        {
          name: 'status_code_d'
          type: 'real'
        }
        {
          name: 'user_agent_s'
          type: 'string'
        }
        {
          name: 'response_path_s'
          type: 'string'
        }
        {
          name: 'request_path_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'seq_s'
          type: 'string'
        }
        {
          name: 'call_id_s'
          type: 'string'
        }
        {
          name: 'reply_to_s'
          type: 'string'
        }
        {
          name: 'response_body_len_d'
          type: 'real'
        }
        {
          name: 'response_to_s'
          type: 'string'
        }
        {
          name: 'request_to_s'
          type: 'string'
        }
        {
          name: 'request_from_s'
          type: 'string'
        }
        {
          name: 'date_s'
          type: 'string'
        }
        {
          name: 'uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'method_s'
          type: 'string'
        }
        {
          name: 'trans_depth_d'
          type: 'real'
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
          name: 'response_from_s'
          type: 'string'
        }
        {
          name: 'content_type_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2sipclTable.name
output tableId string = corelightv2sipclTable.id
output provisioningState string = corelightv2sipclTable.properties.provisioningState
