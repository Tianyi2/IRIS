// Bicep template for Log Analytics custom table: Corelight_v2_conn_long_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 46, Deployed columns: 43 (Type column filtered)
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

resource corelightv2connlongclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_conn_long_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_conn_long_CL'
      description: 'Custom table Corelight_v2_conn_long_CL - imported from JSON schema'
      displayName: 'Corelight_v2_conn_long_CL'
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
          name: 'suri_ids_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'spcap_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'spcap_rule_d'
          type: 'real'
        }
        {
          name: 'spcap_trigger_s'
          type: 'string'
        }
        {
          name: 'app_s'
          type: 'string'
        }
        {
          name: 'corelight_shunted_b'
          type: 'boolean'
        }
        {
          name: 'orig_shunted_pkts_d'
          type: 'real'
        }
        {
          name: 'orig_shunted_bytes_d'
          type: 'real'
        }
        {
          name: 'resp_shunted_pkts_d'
          type: 'real'
        }
        {
          name: 'resp_shunted_bytes_d'
          type: 'real'
        }
        {
          name: 'orig_l2_addr_s'
          type: 'string'
        }
        {
          name: 'resp_l2_addr_s'
          type: 'string'
        }
        {
          name: 'id_orig_h_n_src_s'
          type: 'string'
        }
        {
          name: 'id_orig_h_n_vals_s'
          type: 'string'
        }
        {
          name: 'id_resp_h_n_src_s'
          type: 'string'
        }
        {
          name: 'id_resp_h_n_vals_s'
          type: 'string'
        }
        {
          name: 'vlan_d'
          type: 'real'
        }
        {
          name: 'resp_cc_s'
          type: 'string'
        }
        {
          name: 'orig_cc_s'
          type: 'string'
        }
        {
          name: 'tunnel_parents_s'
          type: 'string'
        }
        {
          name: 'resp_ip_bytes_d'
          type: 'real'
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
          name: 'proto_s'
          type: 'string'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'duration_d'
          type: 'real'
        }
        {
          name: 'inner_vlan_d'
          type: 'real'
        }
        {
          name: 'orig_bytes_d'
          type: 'real'
        }
        {
          name: 'conn_state_s'
          type: 'string'
        }
        {
          name: 'local_orig_b'
          type: 'boolean'
        }
        {
          name: 'local_resp_b'
          type: 'boolean'
        }
        {
          name: 'missed_bytes_d'
          type: 'real'
        }
        {
          name: 'history_s'
          type: 'string'
        }
        {
          name: 'orig_pkts_d'
          type: 'real'
        }
        {
          name: 'orig_ip_bytes_d'
          type: 'real'
        }
        {
          name: 'resp_pkts_d'
          type: 'real'
        }
        {
          name: 'resp_bytes_d'
          type: 'real'
        }
        {
          name: 'community_id_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2connlongclTable.name
output tableId string = corelightv2connlongclTable.id
output provisioningState string = corelightv2connlongclTable.properties.provisioningState
