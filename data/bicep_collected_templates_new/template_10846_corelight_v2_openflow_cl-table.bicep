// Bicep template for Log Analytics custom table: Corelight_v2_openflow_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 38, Deployed columns: 35 (Type column filtered)
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

resource corelightv2openflowclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_openflow_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_openflow_CL'
      description: 'Custom table Corelight_v2_openflow_CL - imported from JSON schema'
      displayName: 'Corelight_v2_openflow_CL'
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
          name: 'flow_mod_actions_nw_dst_s'
          type: 'string'
        }
        {
          name: 'flow_mod_actions_nw_src_s'
          type: 'string'
        }
        {
          name: 'flow_mod_actions_nw_tos_d'
          type: 'real'
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
          type: 'boolean'
        }
        {
          name: 'flow_mod_actions_vlan_pcp_d'
          type: 'real'
        }
        {
          name: 'flow_mod_actions_vlan_vid_d'
          type: 'real'
        }
        {
          name: 'flow_mod_actions_out_ports_s'
          type: 'string'
        }
        {
          name: 'flow_mod_flags_d'
          type: 'real'
        }
        {
          name: 'flow_mod_out_group_d'
          type: 'real'
        }
        {
          name: 'flow_mod_out_port_d'
          type: 'real'
        }
        {
          name: 'flow_mod_priority_d'
          type: 'real'
        }
        {
          name: 'flow_mod_hard_timeout_d'
          type: 'real'
        }
        {
          name: 'flow_mod_idle_timeout_d'
          type: 'real'
        }
        {
          name: 'flow_mod_command_s'
          type: 'string'
        }
        {
          name: 'flow_mod_table_id_d'
          type: 'real'
        }
        {
          name: 'dpid_d'
          type: 'real'
        }
        {
          name: 'match_in_port_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'match_dl_vlan_pcp_d'
          type: 'real'
        }
        {
          name: 'flow_mod_actions_tp_src_d'
          type: 'real'
        }
        {
          name: 'match_dl_type_d'
          type: 'real'
        }
        {
          name: 'match_nw_proto_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'match_tp_dst_d'
          type: 'real'
        }
        {
          name: 'flow_mod_cookie_d'
          type: 'real'
        }
        {
          name: 'match_nw_tos_d'
          type: 'real'
        }
        {
          name: 'flow_mod_actions_tp_dst_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2openflowclTable.name
output tableId string = corelightv2openflowclTable.id
output provisioningState string = corelightv2openflowclTable.properties.provisioningState
