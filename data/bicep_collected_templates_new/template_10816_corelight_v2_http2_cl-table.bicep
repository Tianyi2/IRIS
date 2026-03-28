// Bicep template for Log Analytics custom table: Corelight_v2_http2_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 28, Deployed columns: 25 (Type column filtered)
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

resource corelightv2http2clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_http2_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_http2_CL'
      description: 'Custom table Corelight_v2_http2_CL - imported from JSON schema'
      displayName: 'Corelight_v2_http2_CL'
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
          name: 'password_s'
          type: 'string'
        }
        {
          name: 'username_s'
          type: 'string'
        }
        {
          name: 'encoding_s'
          type: 'string'
        }
        {
          name: 'info_msg_s'
          type: 'string'
        }
        {
          name: 'info_code_d'
          type: 'real'
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
          name: 'response_body_len_d'
          type: 'real'
        }
        {
          name: 'request_body_len_d'
          type: 'real'
        }
        {
          name: 'user_agent_s'
          type: 'string'
        }
        {
          name: 'version_s'
          type: 'string'
        }
        {
          name: 'referrer_s'
          type: 'string'
        }
        {
          name: 'uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'host_s'
          type: 'string'
        }
        {
          name: 'method_s'
          type: 'string'
        }
        {
          name: 'stream_id_d'
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
          name: 'proxied_s'
          type: 'string'
        }
        {
          name: 'push_b'
          type: 'boolean'
        }
      ]
    }
  }
}

output tableName string = corelightv2http2clTable.name
output tableId string = corelightv2http2clTable.id
output provisioningState string = corelightv2http2clTable.properties.provisioningState
