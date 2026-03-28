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
// Data Collection Rule for CiscoSDWANNetflow_CL
// ============================================================================
// Generated: 2025-09-19 14:19:59
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 167, DCR columns: 163 (Type column always filtered)
// Output stream: Custom-CiscoSDWANNetflow_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CiscoSDWANNetflow_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CiscoSDWANNetflow_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'netflow_flow_end_milliseconds_t'
            type: 'string'
          }
          {
            name: 'netflow_fw_protocol_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_options_fw_action_rule_s'
            type: 'string'
          }
          {
            name: 'netflow_scope_element_9_2239_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_post_ip_diff_serv_code_point_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_src_port_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_policy_d'
            type: 'string'
          }
          {
            name: 'netflow_ip_diff_serv_code_point_d'
            type: 'string'
          }
          {
            name: 'netflow_application_tag_s'
            type: 'string'
          }
          {
            name: 'netflow_element_9_2239_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_xlate_dst_port_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_action_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_fw_src_addr_ipv4_s'
            type: 'string'
          }
          {
            name: 'netflow_fw_tcp_flags_d'
            type: 'string'
          }
          {
            name: 'netflow_flow_end_reason_d'
            type: 'string'
          }
          {
            name: 'netflow_bytes_in_d'
            type: 'string'
          }
          {
            name: 'netflow_flow_start_milliseconds_t'
            type: 'string'
          }
          {
            name: 'netflow_fw_xlate_dst_addr_ipv4_s'
            type: 'string'
          }
          {
            name: 'netflow_src_tos_d'
            type: 'string'
          }
          {
            name: 'netflow_options_application_description_s'
            type: 'string'
          }
          {
            name: 'netflow_options_fw_ext_event_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_exporter_timestamp_t'
            type: 'string'
          }
          {
            name: 'netflow_exporter_uptime_millis_d'
            type: 'string'
          }
          {
            name: 'netflow_exporter_source_id_d'
            type: 'string'
          }
          {
            name: 'netflow_exporter_version_d'
            type: 'string'
          }
          {
            name: 'netflow_exporter_address_s'
            type: 'string'
          }
          {
            name: 'host_containerized_b'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_utd_urlf_url_hash_s'
            type: 'string'
          }
          {
            name: 'netflow_utd_ips_action_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_urlf_url_category_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_amp_action_d'
            type: 'string'
          }
          {
            name: 'netflow_sdvt_drop_reason_id_s'
            type: 'string'
          }
          {
            name: 'netflow_utd_ips_gid_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_drop_reason_id_s'
            type: 'string'
          }
          {
            name: 'netflow_utd_amp_dispos_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_urlf_action_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_amp_file_type_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_urlf_reason_id_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_ips_cid_d'
            type: 'string'
          }
          {
            name: 'netflow_options_utd_amp_filetype_name_s'
            type: 'string'
          }
          {
            name: 'netflow_scope_utd_amp_file_type_d'
            type: 'string'
          }
          {
            name: 'netflow_options_utd_urlf_category_name_s'
            type: 'string'
          }
          {
            name: 'netflow_scope_utd_urlf_url_category_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_amp_malname_hash_s'
            type: 'string'
          }
          {
            name: 'netflow_utd_urlf_url_reputation_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_amp_filename_hash_s'
            type: 'string'
          }
          {
            name: 'netflow_utd_ips_pri_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_options_utd_urlf_url_str_s'
            type: 'string'
          }
          {
            name: 'netflow_scope_utd_urlf_url_hash_s'
            type: 'string'
          }
          {
            name: 'netflow_options_utd_policy_name_s'
            type: 'string'
          }
          {
            name: 'netflow_scope_utd_ips_policy_id_d'
            type: 'string'
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
          }
          {
            name: 'netflow_utd_ips_policy_id_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_ips_sid_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_urlf_policy_id_d'
            type: 'string'
          }
          {
            name: 'netflow_utd_amp_policy_id_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_input_snmpidx_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_tcp_seq_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_event_time_msec_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_tcp_ack_d'
            type: 'string'
          }
          {
            name: 'netflow_flow_field_dst_dsa_id_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_ipv4_ident_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_initiator_octets_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_icmp_type_d'
            type: 'string'
          }
          {
            name: 'netflow_flow_field_sgt_d'
            type: 'string'
          }
          {
            name: 'netflow_firewall_event_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_zonepair_id_d'
            type: 'string'
          }
          {
            name: 'netflow_ingress_vrf_id_d'
            type: 'string'
          }
          {
            name: 'netflow_egress_vrf_id_d'
            type: 'string'
          }
          {
            name: 'netflow_flow_field_src_dsa_id_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_responder_octets_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_ext_event_d'
            type: 'string'
          }
          {
            name: 'netflow_output_snmpidx_d'
            type: 'string'
          }
          {
            name: 'netflow_fw_icmp_code_d'
            type: 'string'
          }
          {
            name: 'netflow_bytes_in_but_not_coming_in_hsl_data_d'
            type: 'string'
          }
          {
            name: 'netflow_packets_in_but_not_coming_in_hsl_data_d'
            type: 'string'
          }
          {
            name: 'netflow_options_utd_amp_dispos_name_s'
            type: 'string'
          }
          {
            name: 'netflow_scope_utd_amp_dispos_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_scope_utd_urlf_action_d'
            type: 'string'
          }
          {
            name: 'netflow_scope_utd_amp_action_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'netflow_options_flow_class_id_d'
            type: 'string'
          }
          {
            name: 'netflow_scope_ip_diff_serv_code_point_d'
            type: 'string'
          }
          {
            name: 'netflow_options_utd_urlf_webfilter_name_s'
            type: 'string'
          }
          {
            name: 'tags_s'
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
          name: 'Sentinel-CiscoSDWANNetflow_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CiscoSDWANNetflow_CL']
        destinations: ['Sentinel-CiscoSDWANNetflow_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), netflow_flow_end_milliseconds_t = todatetime(netflow_flow_end_milliseconds_t), netflow_fw_protocol_d = toreal(netflow_fw_protocol_d), flow_id_s = tostring(flow_id_s), flow_locality_s = tostring(flow_locality_s), network_direction_s = tostring(network_direction_s), network_community_id_s = tostring(network_community_id_s), netflow_scope_fw_policy_d = toreal(netflow_scope_fw_policy_d), netflow_fw_dest_addr_ipv4_s = tostring(netflow_fw_dest_addr_ipv4_s), netflow_options_fw_policy_type_s = tostring(netflow_options_fw_policy_type_s), netflow_options_interface_description_s = tostring(netflow_options_interface_description_s), netflow_scope_fw_action_d = toreal(netflow_scope_fw_action_d), netflow_options_fw_action_rule_s = tostring(netflow_options_fw_action_rule_s), netflow_scope_element_9_2239_d = toreal(netflow_scope_element_9_2239_d), netflow_scope_application_tag_s = tostring(netflow_scope_application_tag_s), netflow_options_encrypted_technology_s = tostring(netflow_options_encrypted_technology_s), netflow_options_p2p_technology_s = tostring(netflow_options_p2p_technology_s), netflow_options_interface_name_s = tostring(netflow_options_interface_name_s), netflow_options_tunnel_technology_s = tostring(netflow_options_tunnel_technology_s), netflow_packets_in_d = toreal(netflow_packets_in_d), netflow_post_ip_diff_serv_code_point_d = toreal(netflow_post_ip_diff_serv_code_point_d), netflow_fw_src_port_d = toreal(netflow_fw_src_port_d), netflow_fw_policy_d = toreal(netflow_fw_policy_d), netflow_ip_diff_serv_code_point_d = toreal(netflow_ip_diff_serv_code_point_d), netflow_application_tag_s = tostring(netflow_application_tag_s), netflow_element_9_2239_d = toreal(netflow_element_9_2239_d), netflow_fw_xlate_dst_port_d = toreal(netflow_fw_xlate_dst_port_d), netflow_fw_action_d = toreal(netflow_fw_action_d), netflow_username_s = tostring(netflow_username_s), netflow_fw_xlate_src_addr_ipv4_s = tostring(netflow_fw_xlate_src_addr_ipv4_s), netflow_fw_dest_port_d = toreal(netflow_fw_dest_port_d), netflow_fw_src_addr_ipv4_s = tostring(netflow_fw_src_addr_ipv4_s), netflow_fw_tcp_flags_d = toreal(netflow_fw_tcp_flags_d), netflow_flow_end_reason_d = toreal(netflow_flow_end_reason_d), netflow_bytes_in_d = toreal(netflow_bytes_in_d), netflow_flow_start_milliseconds_t = todatetime(netflow_flow_start_milliseconds_t), netflow_fw_xlate_dst_addr_ipv4_s = tostring(netflow_fw_xlate_dst_addr_ipv4_s), netflow_src_tos_d = toreal(netflow_src_tos_d), netflow_options_application_description_s = tostring(netflow_options_application_description_s), netflow_options_fw_ext_event_d = toreal(netflow_options_fw_ext_event_d), netflow_options_fw_ext_event_desc_s = tostring(netflow_options_fw_ext_event_desc_s), host_os_codename_s = tostring(host_os_codename_s), host_os_family_s = tostring(host_os_family_s), host_os_platform_s = tostring(host_os_platform_s), host_ip_s = tostring(host_ip_s), host_name_s = tostring(host_name_s), host_mac_s = tostring(host_mac_s), host_hostname_s = tostring(host_hostname_s), host_os_kernel_s = tostring(host_os_kernel_s), host_id_g = tostring(host_id_g), netflow_options_fw_zonepair_name_s = tostring(netflow_options_fw_zonepair_name_s), netflow_options_fw_zonepair_id_d = toreal(netflow_options_fw_zonepair_id_d), netflow_exporter_timestamp_t = todatetime(netflow_exporter_timestamp_t), netflow_exporter_uptime_millis_d = toreal(netflow_exporter_uptime_millis_d), netflow_exporter_source_id_d = toreal(netflow_exporter_source_id_d), netflow_exporter_version_d = toreal(netflow_exporter_version_d), netflow_exporter_address_s = tostring(netflow_exporter_address_s), host_containerized_b = tobool(host_containerized_b), host_os_name_s = tostring(host_os_name_s), host_os_type_s = tostring(host_os_type_s), host_os_version_s = tostring(host_os_version_s), netflow_options_application_tag_s = tostring(netflow_options_application_tag_s), netflow_options_fw_policy_d = toreal(netflow_options_fw_policy_d), netflow_options_fw_policy_rule_s = tostring(netflow_options_fw_policy_rule_s), netflow_options_application_name_s = tostring(netflow_options_application_name_s), agent_ephemeral_id_g = tostring(agent_ephemeral_id_g), agent_version_s = tostring(agent_version_s), agent_id_g = tostring(agent_id_g), agent_type_s = tostring(agent_type_s), agent_name_s = tostring(agent_name_s), input_type_s = tostring(input_type_s), event_created_t = todatetime(event_created_t), event_action_s = tostring(event_action_s), event_category_s = tostring(event_category_s), event_kind_s = tostring(event_kind_s), observer_ip_s = tostring(observer_ip_s), ecs_version_s = tostring(ecs_version_s), host_architecture_s = tostring(host_architecture_s), netflow_fw_xlate_src_port_d = toreal(netflow_fw_xlate_src_port_d), event_type_s = tostring(event_type_s), netflow_fw_username_s = tostring(netflow_fw_username_s), netflow_fw_summary_pkt_cnt_d = toreal(netflow_fw_summary_pkt_cnt_d), netflow_utd_urlf_url_hash_s = tostring(netflow_utd_urlf_url_hash_s), netflow_utd_ips_action_d = toreal(netflow_utd_ips_action_d), netflow_utd_urlf_url_category_d = toreal(netflow_utd_urlf_url_category_d), netflow_utd_amp_action_d = toreal(netflow_utd_amp_action_d), netflow_sdvt_drop_reason_id_s = tostring(netflow_sdvt_drop_reason_id_s), netflow_utd_ips_gid_d = toreal(netflow_utd_ips_gid_d), netflow_utd_drop_reason_id_s = tostring(netflow_utd_drop_reason_id_s), netflow_utd_amp_dispos_d = toreal(netflow_utd_amp_dispos_d), netflow_utd_urlf_action_d = toreal(netflow_utd_urlf_action_d), netflow_utd_amp_file_type_d = toreal(netflow_utd_amp_file_type_d), netflow_utd_urlf_reason_id_d = toreal(netflow_utd_urlf_reason_id_d), netflow_utd_ips_cid_d = toreal(netflow_utd_ips_cid_d), netflow_options_utd_amp_filetype_name_s = tostring(netflow_options_utd_amp_filetype_name_s), netflow_scope_utd_amp_file_type_d = toreal(netflow_scope_utd_amp_file_type_d), netflow_options_utd_urlf_category_name_s = tostring(netflow_options_utd_urlf_category_name_s), netflow_scope_utd_urlf_url_category_d = toreal(netflow_scope_utd_urlf_url_category_d), netflow_utd_amp_malname_hash_s = tostring(netflow_utd_amp_malname_hash_s), netflow_utd_urlf_url_reputation_d = toreal(netflow_utd_urlf_url_reputation_d), netflow_utd_amp_filename_hash_s = tostring(netflow_utd_amp_filename_hash_s), netflow_utd_ips_pri_d = toreal(netflow_utd_ips_pri_d), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), netflow_biflow_direction_d = toreal(netflow_biflow_direction_d), netflow_options_utd_urlf_url_str_s = tostring(netflow_options_utd_urlf_url_str_s), netflow_scope_utd_urlf_url_hash_s = tostring(netflow_scope_utd_urlf_url_hash_s), netflow_options_utd_policy_name_s = tostring(netflow_options_utd_policy_name_s), netflow_scope_utd_ips_policy_id_d = toreal(netflow_scope_utd_ips_policy_id_d), netflow_options_utd_amp_filename_s = tostring(netflow_options_utd_amp_filename_s), netflow_scope_utd_amp_filename_hash_s = tostring(netflow_scope_utd_amp_filename_hash_s), netflow_utd_urlf_app_name_s = tostring(netflow_utd_urlf_app_name_s), netflow_utd_ips_policy_id_d = toreal(netflow_utd_ips_policy_id_d), netflow_utd_ips_sid_d = toreal(netflow_utd_ips_sid_d), netflow_utd_urlf_policy_id_d = toreal(netflow_utd_urlf_policy_id_d), netflow_utd_amp_policy_id_d = toreal(netflow_utd_amp_policy_id_d), netflow_options_utd_drop_reason_name_s = tostring(netflow_options_utd_drop_reason_name_s), netflow_type_s = tostring(netflow_type_s), netflow_scope_utd_drop_reason_id_s = tostring(netflow_scope_utd_drop_reason_id_s), netflow_scope_utd_urlf_reason_id_d = toreal(netflow_scope_utd_urlf_reason_id_d), netflow_input_snmpidx_d = toreal(netflow_input_snmpidx_d), netflow_fw_tcp_seq_d = toreal(netflow_fw_tcp_seq_d), netflow_fw_event_time_msec_d = toreal(netflow_fw_event_time_msec_d), netflow_fw_tcp_ack_d = toreal(netflow_fw_tcp_ack_d), netflow_flow_field_dst_dsa_id_d = toreal(netflow_flow_field_dst_dsa_id_d), netflow_fw_ipv4_ident_d = toreal(netflow_fw_ipv4_ident_d), netflow_fw_initiator_octets_d = toreal(netflow_fw_initiator_octets_d), netflow_fw_icmp_type_d = toreal(netflow_fw_icmp_type_d), netflow_flow_field_sgt_d = toreal(netflow_flow_field_sgt_d), netflow_firewall_event_d = toreal(netflow_firewall_event_d), netflow_fw_zonepair_id_d = toreal(netflow_fw_zonepair_id_d), netflow_ingress_vrf_id_d = toreal(netflow_ingress_vrf_id_d), netflow_egress_vrf_id_d = toreal(netflow_egress_vrf_id_d), netflow_flow_field_src_dsa_id_d = toreal(netflow_flow_field_src_dsa_id_d), netflow_fw_responder_octets_d = toreal(netflow_fw_responder_octets_d), netflow_fw_ext_event_d = toreal(netflow_fw_ext_event_d), netflow_output_snmpidx_d = toreal(netflow_output_snmpidx_d), netflow_fw_icmp_code_d = toreal(netflow_fw_icmp_code_d), netflow_bytes_in_but_not_coming_in_hsl_data_d = toreal(netflow_bytes_in_but_not_coming_in_hsl_data_d), netflow_packets_in_but_not_coming_in_hsl_data_d = toreal(netflow_packets_in_but_not_coming_in_hsl_data_d), netflow_options_utd_amp_dispos_name_s = tostring(netflow_options_utd_amp_dispos_name_s), netflow_scope_utd_amp_dispos_d = toreal(netflow_scope_utd_amp_dispos_d), netflow_options_sdvt_drop_reason_name_s = tostring(netflow_options_sdvt_drop_reason_name_s), netflow_scope_sdvt_drop_reason_id_s = tostring(netflow_scope_sdvt_drop_reason_id_s), netflow_options_utd_action_name_s = tostring(netflow_options_utd_action_name_s), netflow_scope_utd_ips_action_d = toreal(netflow_scope_utd_ips_action_d), netflow_scope_utd_urlf_action_d = toreal(netflow_scope_utd_urlf_action_d), netflow_scope_utd_amp_action_d = toreal(netflow_scope_utd_amp_action_d), cloud_service_name_s = tostring(cloud_service_name_s), cloud_provider_s = tostring(cloud_provider_s), cloud_machine_type_s = tostring(cloud_machine_type_s), cloud_availability_zone_s = tostring(cloud_availability_zone_s), cloud_instance_id_s = tostring(cloud_instance_id_s), cloud_instance_name_s = tostring(cloud_instance_name_s), netflow_flow_class_id_d = toreal(netflow_flow_class_id_d), netflow_options_flow_class_id_d = toreal(netflow_options_flow_class_id_d), netflow_scope_ip_diff_serv_code_point_d = toreal(netflow_scope_ip_diff_serv_code_point_d), netflow_options_utd_urlf_webfilter_name_s = tostring(netflow_options_utd_urlf_webfilter_name_s), tags_s = tostring(tags_s)'
        outputStream: 'Custom-CiscoSDWANNetflow_CL'
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
