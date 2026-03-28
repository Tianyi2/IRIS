@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for Corelight_v2_conn_CL
// ============================================================================
// Generated: 2025-09-19 14:20:02
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 46, DCR columns: 43 (Type column always filtered)
// Output stream: Custom-Corelight_v2_conn_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_conn_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_conn_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'ts_t'
            type: 'string'
          }
          {
            name: 'suri_ids_s'
            type: 'string'
          }
          {
            name: 'spcap_url_s'
            type: 'string'
          }
          {
            name: 'spcap_rule_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'orig_shunted_pkts_d'
            type: 'string'
          }
          {
            name: 'orig_shunted_bytes_d'
            type: 'string'
          }
          {
            name: 'resp_shunted_pkts_d'
            type: 'string'
          }
          {
            name: 'resp_shunted_bytes_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'id_resp_h_s'
            type: 'string'
          }
          {
            name: 'id_resp_p_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'inner_vlan_d'
            type: 'string'
          }
          {
            name: 'orig_bytes_d'
            type: 'string'
          }
          {
            name: 'conn_state_s'
            type: 'string'
          }
          {
            name: 'local_orig_b'
            type: 'string'
          }
          {
            name: 'local_resp_b'
            type: 'string'
          }
          {
            name: 'missed_bytes_d'
            type: 'string'
          }
          {
            name: 'history_s'
            type: 'string'
          }
          {
            name: 'orig_pkts_d'
            type: 'string'
          }
          {
            name: 'orig_ip_bytes_d'
            type: 'string'
          }
          {
            name: 'resp_pkts_d'
            type: 'string'
          }
          {
            name: 'resp_bytes_d'
            type: 'string'
          }
          {
            name: 'community_id_s'
            type: 'string'
          }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-Corelight_v2_conn_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_conn_CL']
        destinations: ['Sentinel-Corelight_v2_conn_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), suri_ids_s = tostring(suri_ids_s), spcap_url_s = tostring(spcap_url_s), spcap_rule_d = toreal(spcap_rule_d), spcap_trigger_s = tostring(spcap_trigger_s), app_s = tostring(app_s), corelight_shunted_b = tobool(corelight_shunted_b), orig_shunted_pkts_d = toreal(orig_shunted_pkts_d), orig_shunted_bytes_d = toreal(orig_shunted_bytes_d), resp_shunted_pkts_d = toreal(resp_shunted_pkts_d), resp_shunted_bytes_d = toreal(resp_shunted_bytes_d), orig_l2_addr_s = tostring(orig_l2_addr_s), resp_l2_addr_s = tostring(resp_l2_addr_s), id_orig_h_n_src_s = tostring(id_orig_h_n_src_s), id_orig_h_n_vals_s = tostring(id_orig_h_n_vals_s), id_resp_h_n_src_s = tostring(id_resp_h_n_src_s), id_resp_h_n_vals_s = tostring(id_resp_h_n_vals_s), vlan_d = toreal(vlan_d), resp_cc_s = tostring(resp_cc_s), orig_cc_s = tostring(orig_cc_s), tunnel_parents_s = tostring(tunnel_parents_s), resp_ip_bytes_d = toreal(resp_ip_bytes_d), uid_s = tostring(uid_s), id_orig_h_s = tostring(id_orig_h_s), id_orig_p_d = toreal(id_orig_p_d), id_resp_h_s = tostring(id_resp_h_s), id_resp_p_d = toreal(id_resp_p_d), proto_s = tostring(proto_s), service_s = tostring(service_s), duration_d = toreal(duration_d), inner_vlan_d = toreal(inner_vlan_d), orig_bytes_d = toreal(orig_bytes_d), conn_state_s = tostring(conn_state_s), local_orig_b = tobool(local_orig_b), local_resp_b = tobool(local_resp_b), missed_bytes_d = toreal(missed_bytes_d), history_s = tostring(history_s), orig_pkts_d = toreal(orig_pkts_d), orig_ip_bytes_d = toreal(orig_ip_bytes_d), resp_pkts_d = toreal(resp_pkts_d), resp_bytes_d = toreal(resp_bytes_d), community_id_s = tostring(community_id_s)'
        outputStream: 'Custom-Corelight_v2_conn_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
