// Bicep template for Log Analytics custom table: CiscoSDWANNetflow_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 167, Deployed columns: 163 (Type column filtered)
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

resource ciscosdwannetflowclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CiscoSDWANNetflow_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CiscoSDWANNetflow_CL'
      description: 'Custom table CiscoSDWANNetflow_CL - imported from JSON schema'
      displayName: 'CiscoSDWANNetflow_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'netflow_flow_end_milliseconds_t'
          type: 'dateTime'
        }
        {
          name: 'netflow_fw_protocol_d'
          type: 'real'
        }
        {
          name: 'flow_id_s'
          type: 'string'
        }
        {
          name: 'flow_locality_s'
          type: 'string'
        }
        {
          name: 'network_direction_s'
          type: 'string'
        }
        {
          name: 'network_community_id_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_fw_policy_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_dest_addr_ipv4_s'
          type: 'string'
        }
        {
          name: 'netflow_options_fw_policy_type_s'
          type: 'string'
        }
        {
          name: 'netflow_options_interface_description_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_fw_action_d'
          type: 'real'
        }
        {
          name: 'netflow_options_fw_action_rule_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_element_9_2239_d'
          type: 'real'
        }
        {
          name: 'netflow_scope_application_tag_s'
          type: 'string'
        }
        {
          name: 'netflow_options_encrypted_technology_s'
          type: 'string'
        }
        {
          name: 'netflow_options_p2p_technology_s'
          type: 'string'
        }
        {
          name: 'netflow_options_interface_name_s'
          type: 'string'
        }
        {
          name: 'netflow_options_tunnel_technology_s'
          type: 'string'
        }
        {
          name: 'netflow_packets_in_d'
          type: 'real'
        }
        {
          name: 'netflow_post_ip_diff_serv_code_point_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_src_port_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_policy_d'
          type: 'real'
        }
        {
          name: 'netflow_ip_diff_serv_code_point_d'
          type: 'real'
        }
        {
          name: 'netflow_application_tag_s'
          type: 'string'
        }
        {
          name: 'netflow_element_9_2239_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_xlate_dst_port_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_action_d'
          type: 'real'
        }
        {
          name: 'netflow_username_s'
          type: 'string'
        }
        {
          name: 'netflow_fw_xlate_src_addr_ipv4_s'
          type: 'string'
        }
        {
          name: 'netflow_fw_dest_port_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_src_addr_ipv4_s'
          type: 'string'
        }
        {
          name: 'netflow_fw_tcp_flags_d'
          type: 'real'
        }
        {
          name: 'netflow_flow_end_reason_d'
          type: 'real'
        }
        {
          name: 'netflow_bytes_in_d'
          type: 'real'
        }
        {
          name: 'netflow_flow_start_milliseconds_t'
          type: 'dateTime'
        }
        {
          name: 'netflow_fw_xlate_dst_addr_ipv4_s'
          type: 'string'
        }
        {
          name: 'netflow_src_tos_d'
          type: 'real'
        }
        {
          name: 'netflow_options_application_description_s'
          type: 'string'
        }
        {
          name: 'netflow_options_fw_ext_event_d'
          type: 'real'
        }
        {
          name: 'netflow_options_fw_ext_event_desc_s'
          type: 'string'
        }
        {
          name: 'host_os_codename_s'
          type: 'string'
        }
        {
          name: 'host_os_family_s'
          type: 'string'
        }
        {
          name: 'host_os_platform_s'
          type: 'string'
        }
        {
          name: 'host_ip_s'
          type: 'string'
        }
        {
          name: 'host_name_s'
          type: 'string'
        }
        {
          name: 'host_mac_s'
          type: 'string'
        }
        {
          name: 'host_hostname_s'
          type: 'string'
        }
        {
          name: 'host_os_kernel_s'
          type: 'string'
        }
        {
          name: 'host_id_g'
          type: 'string'
        }
        {
          name: 'netflow_options_fw_zonepair_name_s'
          type: 'string'
        }
        {
          name: 'netflow_options_fw_zonepair_id_d'
          type: 'real'
        }
        {
          name: 'netflow_exporter_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'netflow_exporter_uptime_millis_d'
          type: 'real'
        }
        {
          name: 'netflow_exporter_source_id_d'
          type: 'real'
        }
        {
          name: 'netflow_exporter_version_d'
          type: 'real'
        }
        {
          name: 'netflow_exporter_address_s'
          type: 'string'
        }
        {
          name: 'host_containerized_b'
          type: 'boolean'
        }
        {
          name: 'host_os_name_s'
          type: 'string'
        }
        {
          name: 'host_os_type_s'
          type: 'string'
        }
        {
          name: 'host_os_version_s'
          type: 'string'
        }
        {
          name: 'netflow_options_application_tag_s'
          type: 'string'
        }
        {
          name: 'netflow_options_fw_policy_d'
          type: 'real'
        }
        {
          name: 'netflow_options_fw_policy_rule_s'
          type: 'string'
        }
        {
          name: 'netflow_options_application_name_s'
          type: 'string'
        }
        {
          name: 'agent_ephemeral_id_g'
          type: 'string'
        }
        {
          name: 'agent_version_s'
          type: 'string'
        }
        {
          name: 'agent_id_g'
          type: 'string'
        }
        {
          name: 'agent_type_s'
          type: 'string'
        }
        {
          name: 'agent_name_s'
          type: 'string'
        }
        {
          name: 'input_type_s'
          type: 'string'
        }
        {
          name: 'event_created_t'
          type: 'dateTime'
        }
        {
          name: 'event_action_s'
          type: 'string'
        }
        {
          name: 'event_category_s'
          type: 'string'
        }
        {
          name: 'event_kind_s'
          type: 'string'
        }
        {
          name: 'observer_ip_s'
          type: 'string'
        }
        {
          name: 'ecs_version_s'
          type: 'string'
        }
        {
          name: 'host_architecture_s'
          type: 'string'
        }
        {
          name: 'netflow_fw_xlate_src_port_d'
          type: 'real'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'netflow_fw_username_s'
          type: 'string'
        }
        {
          name: 'netflow_fw_summary_pkt_cnt_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_urlf_url_hash_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'netflow_utd_ips_action_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_urlf_url_category_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_amp_action_d'
          type: 'real'
        }
        {
          name: 'netflow_sdvt_drop_reason_id_s'
          type: 'string'
        }
        {
          name: 'netflow_utd_ips_gid_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_drop_reason_id_s'
          type: 'string'
        }
        {
          name: 'netflow_utd_amp_dispos_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_urlf_action_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_amp_file_type_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_urlf_reason_id_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_ips_cid_d'
          type: 'real'
        }
        {
          name: 'netflow_options_utd_amp_filetype_name_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_utd_amp_file_type_d'
          type: 'real'
        }
        {
          name: 'netflow_options_utd_urlf_category_name_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'netflow_scope_utd_urlf_url_category_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_amp_malname_hash_s'
          type: 'string'
        }
        {
          name: 'netflow_utd_urlf_url_reputation_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_amp_filename_hash_s'
          type: 'string'
        }
        {
          name: 'netflow_utd_ips_pri_d'
          type: 'real'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'netflow_biflow_direction_d'
          type: 'real'
        }
        {
          name: 'netflow_options_utd_urlf_url_str_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'netflow_scope_utd_urlf_url_hash_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'netflow_options_utd_policy_name_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_utd_ips_policy_id_d'
          type: 'real'
        }
        {
          name: 'netflow_options_utd_amp_filename_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_utd_amp_filename_hash_s'
          type: 'string'
        }
        {
          name: 'netflow_utd_urlf_app_name_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'netflow_utd_ips_policy_id_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_ips_sid_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_urlf_policy_id_d'
          type: 'real'
        }
        {
          name: 'netflow_utd_amp_policy_id_d'
          type: 'real'
        }
        {
          name: 'netflow_options_utd_drop_reason_name_s'
          type: 'string'
        }
        {
          name: 'netflow_type_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_utd_drop_reason_id_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_utd_urlf_reason_id_d'
          type: 'real'
        }
        {
          name: 'netflow_input_snmpidx_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_tcp_seq_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_event_time_msec_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_tcp_ack_d'
          type: 'real'
        }
        {
          name: 'netflow_flow_field_dst_dsa_id_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_ipv4_ident_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_initiator_octets_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_icmp_type_d'
          type: 'real'
        }
        {
          name: 'netflow_flow_field_sgt_d'
          type: 'real'
        }
        {
          name: 'netflow_firewall_event_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_zonepair_id_d'
          type: 'real'
        }
        {
          name: 'netflow_ingress_vrf_id_d'
          type: 'real'
        }
        {
          name: 'netflow_egress_vrf_id_d'
          type: 'real'
        }
        {
          name: 'netflow_flow_field_src_dsa_id_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_responder_octets_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_ext_event_d'
          type: 'real'
        }
        {
          name: 'netflow_output_snmpidx_d'
          type: 'real'
        }
        {
          name: 'netflow_fw_icmp_code_d'
          type: 'real'
        }
        {
          name: 'netflow_bytes_in_but_not_coming_in_hsl_data_d'
          type: 'real'
        }
        {
          name: 'netflow_packets_in_but_not_coming_in_hsl_data_d'
          type: 'real'
        }
        {
          name: 'netflow_options_utd_amp_dispos_name_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_utd_amp_dispos_d'
          type: 'real'
        }
        {
          name: 'netflow_options_sdvt_drop_reason_name_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_sdvt_drop_reason_id_s'
          type: 'string'
        }
        {
          name: 'netflow_options_utd_action_name_s'
          type: 'string'
        }
        {
          name: 'netflow_scope_utd_ips_action_d'
          type: 'real'
        }
        {
          name: 'netflow_scope_utd_urlf_action_d'
          type: 'real'
        }
        {
          name: 'netflow_scope_utd_amp_action_d'
          type: 'real'
        }
        {
          name: 'cloud_service_name_s'
          type: 'string'
        }
        {
          name: 'cloud_provider_s'
          type: 'string'
        }
        {
          name: 'cloud_machine_type_s'
          type: 'string'
        }
        {
          name: 'cloud_availability_zone_s'
          type: 'string'
        }
        {
          name: 'cloud_instance_id_s'
          type: 'string'
        }
        {
          name: 'cloud_instance_name_s'
          type: 'string'
        }
        {
          name: 'netflow_flow_class_id_d'
          type: 'real'
        }
        {
          name: 'netflow_options_flow_class_id_d'
          type: 'real'
        }
        {
          name: 'netflow_scope_ip_diff_serv_code_point_d'
          type: 'real'
        }
        {
          name: 'netflow_options_utd_urlf_webfilter_name_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'tags_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ciscosdwannetflowclTable.name
output tableId string = ciscosdwannetflowclTable.id
output provisioningState string = ciscosdwannetflowclTable.properties.provisioningState
