// Bicep template for Log Analytics custom table: Corelight_v2_ssl_red_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 25, Deployed columns: 22 (Type column filtered)
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

resource corelightv2sslredclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_ssl_red_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_ssl_red_CL'
      description: 'Custom table Corelight_v2_ssl_red_CL - imported from JSON schema'
      displayName: 'Corelight_v2_ssl_red_CL'
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
          name: 'validation_status_s'
          type: 'string'
        }
        {
          name: 'sni_matches_cert_b'
          type: 'boolean'
        }
        {
          name: 'client_cert_chain_fps_s'
          type: 'string'
        }
        {
          name: 'cert_chain_fps_s'
          type: 'string'
        }
        {
          name: 'ssl_history_s'
          type: 'string'
        }
        {
          name: 'established_b'
          type: 'boolean'
        }
        {
          name: 'next_protocol_s'
          type: 'string'
        }
        {
          name: 'last_alert_s'
          type: 'string'
        }
        {
          name: 'ja3_s'
          type: 'string'
        }
        {
          name: 'resumed_b'
          type: 'boolean'
        }
        {
          name: 'curve_s'
          type: 'string'
        }
        {
          name: 'cipher_s'
          type: 'string'
        }
        {
          name: 'version_s'
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
          name: 'server_name_s'
          type: 'string'
        }
        {
          name: 'ja3s_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2sslredclTable.name
output tableId string = corelightv2sslredclTable.id
output provisioningState string = corelightv2sslredclTable.properties.provisioningState
