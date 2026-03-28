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
// Data Collection Rule for Corelight_v2_openflow_CL
// ============================================================================
// Generated: 2025-09-19 14:20:09
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 38, DCR columns: 35 (Type column always filtered)
// Output stream: Custom-Corelight_v2_openflow_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_openflow_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_openflow_CL': {
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
            name: 'flow_mod_actions_nw_dst_s'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_nw_src_s'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_nw_tos_d'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_dl_dst_s'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_dl_src_s'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_vlan_strip_b'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_vlan_pcp_d'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_vlan_vid_d'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_out_ports_s'
            type: 'string'
          }
          {
            name: 'flow_mod_flags_d'
            type: 'string'
          }
          {
            name: 'flow_mod_out_group_d'
            type: 'string'
          }
          {
            name: 'flow_mod_out_port_d'
            type: 'string'
          }
          {
            name: 'flow_mod_priority_d'
            type: 'string'
          }
          {
            name: 'flow_mod_hard_timeout_d'
            type: 'string'
          }
          {
            name: 'flow_mod_idle_timeout_d'
            type: 'string'
          }
          {
            name: 'flow_mod_command_s'
            type: 'string'
          }
          {
            name: 'flow_mod_table_id_d'
            type: 'string'
          }
          {
            name: 'dpid_d'
            type: 'string'
          }
          {
            name: 'match_in_port_d'
            type: 'string'
          }
          {
            name: 'match_dl_src_s'
            type: 'string'
          }
          {
            name: 'match_dl_dst_s'
            type: 'string'
          }
          {
            name: 'match_dl_vlan_d'
            type: 'string'
          }
          {
            name: 'match_dl_vlan_pcp_d'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_tp_src_d'
            type: 'string'
          }
          {
            name: 'match_dl_type_d'
            type: 'string'
          }
          {
            name: 'match_nw_proto_d'
            type: 'string'
          }
          {
            name: 'match_nw_src_s'
            type: 'string'
          }
          {
            name: 'match_nw_dst_s'
            type: 'string'
          }
          {
            name: 'match_tp_src_d'
            type: 'string'
          }
          {
            name: 'match_tp_dst_d'
            type: 'string'
          }
          {
            name: 'flow_mod_cookie_d'
            type: 'string'
          }
          {
            name: 'match_nw_tos_d'
            type: 'string'
          }
          {
            name: 'flow_mod_actions_tp_dst_d'
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
          name: 'Sentinel-Corelight_v2_openflow_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_openflow_CL']
        destinations: ['Sentinel-Corelight_v2_openflow_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), flow_mod_actions_nw_dst_s = tostring(flow_mod_actions_nw_dst_s), flow_mod_actions_nw_src_s = tostring(flow_mod_actions_nw_src_s), flow_mod_actions_nw_tos_d = toreal(flow_mod_actions_nw_tos_d), flow_mod_actions_dl_dst_s = tostring(flow_mod_actions_dl_dst_s), flow_mod_actions_dl_src_s = tostring(flow_mod_actions_dl_src_s), flow_mod_actions_vlan_strip_b = tobool(flow_mod_actions_vlan_strip_b), flow_mod_actions_vlan_pcp_d = toreal(flow_mod_actions_vlan_pcp_d), flow_mod_actions_vlan_vid_d = toreal(flow_mod_actions_vlan_vid_d), flow_mod_actions_out_ports_s = tostring(flow_mod_actions_out_ports_s), flow_mod_flags_d = toreal(flow_mod_flags_d), flow_mod_out_group_d = toreal(flow_mod_out_group_d), flow_mod_out_port_d = toreal(flow_mod_out_port_d), flow_mod_priority_d = toreal(flow_mod_priority_d), flow_mod_hard_timeout_d = toreal(flow_mod_hard_timeout_d), flow_mod_idle_timeout_d = toreal(flow_mod_idle_timeout_d), flow_mod_command_s = tostring(flow_mod_command_s), flow_mod_table_id_d = toreal(flow_mod_table_id_d), dpid_d = toreal(dpid_d), match_in_port_d = toreal(match_in_port_d), match_dl_src_s = tostring(match_dl_src_s), match_dl_dst_s = tostring(match_dl_dst_s), match_dl_vlan_d = toreal(match_dl_vlan_d), match_dl_vlan_pcp_d = toreal(match_dl_vlan_pcp_d), flow_mod_actions_tp_src_d = toreal(flow_mod_actions_tp_src_d), match_dl_type_d = toreal(match_dl_type_d), match_nw_proto_d = toreal(match_nw_proto_d), match_nw_src_s = tostring(match_nw_src_s), match_nw_dst_s = tostring(match_nw_dst_s), match_tp_src_d = toreal(match_tp_src_d), match_tp_dst_d = toreal(match_tp_dst_d), flow_mod_cookie_d = toreal(flow_mod_cookie_d), match_nw_tos_d = toreal(match_nw_tos_d), flow_mod_actions_tp_dst_d = toreal(flow_mod_actions_tp_dst_d)'
        outputStream: 'Custom-Corelight_v2_openflow_CL'
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
