// Bicep template for Log Analytics custom table: Corelight_v2_ssl_CL
// Generated on 2025-09-19 14:13:53 UTC
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

resource corelightv2sslclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_ssl_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_ssl_CL'
      description: 'Custom table Corelight_v2_ssl_CL - imported from JSON schema'
      displayName: 'Corelight_v2_ssl_CL'
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
          name: 'resumed_b'
          type: 'boolean'
        }
        {
          name: 'sni_matches_cert_b'
          type: 'boolean'
        }
        {
          name: 'server_name_s'
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
          name: 'curve_s'
          type: 'string'
        }
        {
          name: 'validation_status_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2sslclTable.name
output tableId string = corelightv2sslclTable.id
output provisioningState string = corelightv2sslclTable.properties.provisioningState
