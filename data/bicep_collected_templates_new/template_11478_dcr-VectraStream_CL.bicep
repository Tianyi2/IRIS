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
// Data Collection Rule for VectraStream_CL
// ============================================================================
// Generated: 2025-09-19 14:20:36
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 214, DCR columns: 211 (Type column always filtered)
// Output stream: Custom-VectraStream_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-VectraStream_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-VectraStream_CL': {
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
            name: 'saw_query_b'
            type: 'string'
          }
          {
            name: 'saw_reply_b'
            type: 'string'
          }
          {
            name: 'total_answers_d'
            type: 'string'
          }
          {
            name: 'total_replies_d'
            type: 'string'
          }
          {
            name: 'trans_id_d'
            type: 'string'
          }
          {
            name: 'issuer_s'
            type: 'string'
          }
          {
            name: 'next_protocol_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'basic_constraints_ca_b'
            type: 'string'
          }
          {
            name: 'basic_constraints_path_len_d'
            type: 'string'
          }
          {
            name: 'rejected_b'
            type: 'string'
          }
          {
            name: 'certificate_cn_s'
            type: 'string'
          }
          {
            name: 'certificate_issuer_s'
            type: 'string'
          }
          {
            name: 'certificate_key_alg_s'
            type: 'string'
          }
          {
            name: 'certificate_key_length_s'
            type: 'string'
          }
          {
            name: 'certificate_key_type_s'
            type: 'string'
          }
          {
            name: 'certificate_not_valid_after_d'
            type: 'string'
          }
          {
            name: 'certificate_not_valid_before_d'
            type: 'string'
          }
          {
            name: 'certificate_self_issued_b'
            type: 'string'
          }
          {
            name: 'certificate_serial_s'
            type: 'string'
          }
          {
            name: 'certificate_sig_alg_s'
            type: 'string'
          }
          {
            name: 'certificate_subject_s'
            type: 'string'
          }
          {
            name: 'certificate_exponent_s'
            type: 'string'
          }
          {
            name: 'certificate_version_d'
            type: 'string'
          }
          {
            name: 'rcode_name_s'
            type: 'string'
          }
          {
            name: 'query_s'
            type: 'string'
          }
          {
            name: 'host_multihomed_b'
            type: 'string'
          }
          {
            name: 'is_proxied_b'
            type: 'string'
          }
          {
            name: 'method_s'
            type: 'string'
          }
          {
            name: 'request_body_len_d'
            type: 'string'
          }
          {
            name: 'request_header_count_d'
            type: 'string'
          }
          {
            name: 'response_body_len_d'
            type: 'string'
          }
          {
            name: 'response_header_count_d'
            type: 'string'
          }
          {
            name: 'status_code_d'
            type: 'string'
          }
          {
            name: 'status_msg_s'
            type: 'string'
          }
          {
            name: 'uri_s'
            type: 'string'
          }
          {
            name: 'rcode_d'
            type: 'string'
          }
          {
            name: 'certificate_curve_s'
            type: 'string'
          }
          {
            name: 'RA_b'
            type: 'string'
          }
          {
            name: 'RD_b'
            type: 'string'
          }
          {
            name: 'TC_b'
            type: 'string'
          }
          {
            name: 'TTLs_s'
            type: 'string'
          }
          {
            name: 'answers_s'
            type: 'string'
          }
          {
            name: 'auth_s'
            type: 'string'
          }
          {
            name: 'qclass_d'
            type: 'string'
          }
          {
            name: 'qclass_name_s'
            type: 'string'
          }
          {
            name: 'qtype_d'
            type: 'string'
          }
          {
            name: 'qtype_name_s'
            type: 'string'
          }
          {
            name: 'AA_b'
            type: 'string'
          }
          {
            name: 'san_dns_s'
            type: 'string'
          }
          {
            name: 'san_other_fields_b'
            type: 'string'
          }
          {
            name: 'community_id_s'
            type: 'string'
          }
          {
            name: 'resp_pkts_d'
            type: 'string'
          }
          {
            name: 'resp_vlan_id_d'
            type: 'string'
          }
          {
            name: 'sensor_uid_s'
            type: 'string'
          }
          {
            name: 'service_s'
            type: 'string'
          }
          {
            name: 'session_start_time_d'
            type: 'string'
          }
          {
            name: 'ts_d'
            type: 'string'
          }
          {
            name: 'uid_s'
            type: 'string'
          }
          {
            name: 'cipher_s'
            type: 'string'
          }
          {
            name: 'client_curve_num_s'
            type: 'string'
          }
          {
            name: 'client_ec_point_format_s'
            type: 'string'
          }
          {
            name: 'resp_multihomed_b'
            type: 'string'
          }
          {
            name: 'client_extension_s'
            type: 'string'
          }
          {
            name: 'client_version_num_d'
            type: 'string'
          }
          {
            name: 'curve_s'
            type: 'string'
          }
          {
            name: 'established_b'
            type: 'string'
          }
          {
            name: 'ja3_g'
            type: 'string'
          }
          {
            name: 'ja3s_g'
            type: 'string'
          }
          {
            name: 'server_extensions_s'
            type: 'string'
          }
          {
            name: 'server_name_s'
            type: 'string'
          }
          {
            name: 'version_s'
            type: 'string'
          }
          {
            name: 'version_num_d'
            type: 'string'
          }
          {
            name: 'resp_hostname_s'
            type: 'string'
          }
          {
            name: 'client_version_s'
            type: 'string'
          }
          {
            name: 'resp_ip_bytes_s'
            type: 'string'
          }
          {
            name: 'resp_domain_s'
            type: 'string'
          }
          {
            name: 'protoName_s'
            type: 'string'
          }
          {
            name: 'conn_state_s'
            type: 'string'
          }
          {
            name: 'duration_d'
            type: 'string'
          }
          {
            name: 'first_orig_resp_data_pkt_s'
            type: 'string'
          }
          {
            name: 'first_orig_resp_data_pkt_time_d'
            type: 'string'
          }
          {
            name: 'first_orig_resp_pkt_time_d'
            type: 'string'
          }
          {
            name: 'first_resp_orig_data_pkt_s'
            type: 'string'
          }
          {
            name: 'first_resp_orig_data_pkt_time_d'
            type: 'string'
          }
          {
            name: 'first_resp_orig_pkt_time_d'
            type: 'string'
          }
          {
            name: 'id_ip_ver_s'
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
            name: 'local_orig_b'
            type: 'string'
          }
          {
            name: 'local_resp_b'
            type: 'string'
          }
          {
            name: 'metadata_type_s'
            type: 'string'
          }
          {
            name: 'orig_hostname_s'
            type: 'string'
          }
          {
            name: 'orig_huid_s'
            type: 'string'
          }
          {
            name: 'orig_ip_bytes_s'
            type: 'string'
          }
          {
            name: 'orig_pkts_d'
            type: 'string'
          }
          {
            name: 'orig_sluid_s'
            type: 'string'
          }
          {
            name: 'orig_vlan_id_d'
            type: 'string'
          }
          {
            name: 'proto_d'
            type: 'string'
          }
          {
            name: 'host_s'
            type: 'string'
          }
          {
            name: 'path_s'
            type: 'string'
          }
          {
            name: 'user_agent_s'
            type: 'string'
          }
          {
            name: 'response_expires_s'
            type: 'string'
          }
          {
            name: 'tls_b'
            type: 'string'
          }
          {
            name: 'proxied_s'
            type: 'string'
          }
          {
            name: 'error_s'
            type: 'string'
          }
          {
            name: 'matched_dn_s'
            type: 'string'
          }
          {
            name: 'referrer_s'
            type: 'string'
          }
          {
            name: 'client_build_s'
            type: 'string'
          }
          {
            name: 'desktop_height_d'
            type: 'string'
          }
          {
            name: 'desktop_width_d'
            type: 'string'
          }
          {
            name: 'keyboard_layout_s'
            type: 'string'
          }
          {
            name: 'beacon_type_s'
            type: 'string'
          }
          {
            name: 'msgid_s'
            type: 'string'
          }
          {
            name: 'beacon_uid_s'
            type: 'string'
          }
          {
            name: 'last_event_time_d'
            type: 'string'
          }
          {
            name: 'orig_ip_bytes_d'
            type: 'string'
          }
          {
            name: 'resp_domains_s'
            type: 'string'
          }
          {
            name: 'resp_ip_bytes_d'
            type: 'string'
          }
          {
            name: 'session_count_d'
            type: 'string'
          }
          {
            name: 'resp_filename_s'
            type: 'string'
          }
          {
            name: 'response_content_disposition_s'
            type: 'string'
          }
          {
            name: 'cookie_s'
            type: 'string'
          }
          {
            name: 'cookie_vars_s'
            type: 'string'
          }
          {
            name: 'orig_mime_types_s'
            type: 'string'
          }
          {
            name: 'first_event_time_d'
            type: 'string'
          }
          {
            name: 'mail_from_s'
            type: 'string'
          }
          {
            name: 'helo_s'
            type: 'string'
          }
          {
            name: 'from_s'
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
            name: 'client_dig_product_id_s'
            type: 'string'
          }
          {
            name: 'client_dig_protocol_id_s'
            type: 'string'
          }
          {
            name: 'client_name_s'
            type: 'string'
          }
          {
            name: 'dir_confidence_d'
            type: 'string'
          }
          {
            name: 'san_ip_s'
            type: 'string'
          }
          {
            name: 'host_key_s'
            type: 'string'
          }
          {
            name: 'application_s'
            type: 'string'
          }
          {
            name: 'error_msg_s'
            type: 'string'
          }
          {
            name: 'reply_to_s'
            type: 'string'
          }
          {
            name: 'useragent_s'
            type: 'string'
          }
          {
            name: 'second_received_s'
            type: 'string'
          }
          {
            name: 'spf_mailfrom_s'
            type: 'string'
          }
          {
            name: 'x_originating_ip_s'
            type: 'string'
          }
          {
            name: 'first_received_s'
            type: 'string'
          }
          {
            name: 'in_reply_to_s'
            type: 'string'
          }
          {
            name: 'rcpt_to_s'
            type: 'string'
          }
          {
            name: 'to_s'
            type: 'string'
          }
          {
            name: 'date_s'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'resp_huid_s'
            type: 'string'
          }
          {
            name: 'status_d'
            type: 'string'
          }
          {
            name: 'cipher_alg_s'
            type: 'string'
          }
          {
            name: 'result_s'
            type: 'string'
          }
          {
            name: 'result_code_s'
            type: 'string'
          }
          {
            name: 'result_count_d'
            type: 'string'
          }
          {
            name: 'base_object_s'
            type: 'string'
          }
          {
            name: 'endpoint_s'
            type: 'string'
          }
          {
            name: 'operation_s'
            type: 'string'
          }
          {
            name: 'rtt_d'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'delete_on_close_b'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'response_bytes_s'
            type: 'string'
          }
          {
            name: 'hostname_s'
            type: 'string'
          }
          {
            name: 'client_subject_s'
            type: 'string'
          }
          {
            name: 'certificate_serial_g'
            type: 'string'
          }
          {
            name: 'resp_mime_types_s'
            type: 'string'
          }
          {
            name: 'response_cache_control_s'
            type: 'string'
          }
          {
            name: 'lease_time_d'
            type: 'string'
          }
          {
            name: 'mac_s'
            type: 'string'
          }
          {
            name: 'assigned_ip_s'
            type: 'string'
          }
          {
            name: 'dhcp_server_ip_s'
            type: 'string'
          }
          {
            name: 'dns_server_ips_s'
            type: 'string'
          }
          {
            name: 'request_cache_control_s'
            type: 'string'
          }
          {
            name: 'client_issuer_s'
            type: 'string'
          }
          {
            name: 'request_bytes_s'
            type: 'string'
          }
          {
            name: 'query_scope_s'
            type: 'string'
          }
          {
            name: 'message_id_d'
            type: 'string'
          }
          {
            name: 'compression_alg_s'
            type: 'string'
          }
          {
            name: 'hassh_g'
            type: 'string'
          }
          {
            name: 'hasshServer_g'
            type: 'string'
          }
          {
            name: 'host_key_alg_s'
            type: 'string'
          }
          {
            name: 'kex_alg_s'
            type: 'string'
          }
          {
            name: 'mac_alg_s'
            type: 'string'
          }
          {
            name: 'server_s'
            type: 'string'
          }
          {
            name: 'client_s'
            type: 'string'
          }
          {
            name: 'data_source_s'
            type: 'string'
          }
          {
            name: 'error_code_s'
            type: 'string'
          }
          {
            name: 'orig_host_observed_privilege_d'
            type: 'string'
          }
          {
            name: 'protocol_d'
            type: 'string'
          }
          {
            name: 'rep_cipher_s'
            type: 'string'
          }
          {
            name: 'reply_timestamp_d'
            type: 'string'
          }
          {
            name: 'req_ciphers_s'
            type: 'string'
          }
          {
            name: 'request_type_s'
            type: 'string'
          }
          {
            name: 'success_b'
            type: 'string'
          }
          {
            name: 'attributes_s'
            type: 'string'
          }
          {
            name: 'bind_error_count_d'
            type: 'string'
          }
          {
            name: 'encrypted_sasl_payload_count_d'
            type: 'string'
          }
          {
            name: 'is_close_b'
            type: 'string'
          }
          {
            name: 'is_query_b'
            type: 'string'
          }
          {
            name: 'logon_failure_error_count_d'
            type: 'string'
          }
          {
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'resp_sluid_s'
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
          name: 'Sentinel-VectraStream_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-VectraStream_CL']
        destinations: ['Sentinel-VectraStream_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), saw_query_b = tostring(saw_query_b), saw_reply_b = tostring(saw_reply_b), total_answers_d = toreal(total_answers_d), total_replies_d = toreal(total_replies_d), trans_id_d = toreal(trans_id_d), issuer_s = tostring(issuer_s), next_protocol_s = tostring(next_protocol_s), subject_s = tostring(subject_s), basic_constraints_ca_b = tostring(basic_constraints_ca_b), basic_constraints_path_len_d = toreal(basic_constraints_path_len_d), rejected_b = tostring(rejected_b), certificate_cn_s = tostring(certificate_cn_s), certificate_issuer_s = tostring(certificate_issuer_s), certificate_key_alg_s = tostring(certificate_key_alg_s), certificate_key_length_s = tostring(certificate_key_length_s), certificate_key_type_s = tostring(certificate_key_type_s), certificate_not_valid_after_d = toreal(certificate_not_valid_after_d), certificate_not_valid_before_d = toreal(certificate_not_valid_before_d), certificate_self_issued_b = tostring(certificate_self_issued_b), certificate_serial_s = tostring(certificate_serial_s), certificate_sig_alg_s = tostring(certificate_sig_alg_s), certificate_subject_s = tostring(certificate_subject_s), certificate_exponent_s = tostring(certificate_exponent_s), certificate_version_d = toreal(certificate_version_d), rcode_name_s = tostring(rcode_name_s), query_s = tostring(query_s), host_multihomed_b = tostring(host_multihomed_b), is_proxied_b = tostring(is_proxied_b), method_s = tostring(method_s), request_body_len_d = toreal(request_body_len_d), request_header_count_d = toreal(request_header_count_d), response_body_len_d = toreal(response_body_len_d), response_header_count_d = toreal(response_header_count_d), status_code_d = toreal(status_code_d), status_msg_s = tostring(status_msg_s), uri_s = tostring(uri_s), rcode_d = toreal(rcode_d), certificate_curve_s = tostring(certificate_curve_s), RA_b = tostring(RA_b), RD_b = tostring(RD_b), TC_b = tostring(TC_b), TTLs_s = tostring(TTLs_s), answers_s = tostring(answers_s), auth_s = tostring(auth_s), qclass_d = toreal(qclass_d), qclass_name_s = tostring(qclass_name_s), qtype_d = toreal(qtype_d), qtype_name_s = tostring(qtype_name_s), AA_b = tostring(AA_b), san_dns_s = tostring(san_dns_s), san_other_fields_b = tostring(san_other_fields_b), community_id_s = tostring(community_id_s), resp_pkts_d = toreal(resp_pkts_d), resp_vlan_id_d = toreal(resp_vlan_id_d), sensor_uid_s = tostring(sensor_uid_s), service_s = tostring(service_s), session_start_time_d = toreal(session_start_time_d), ts_d = toreal(ts_d), uid_s = tostring(uid_s), cipher_s = tostring(cipher_s), client_curve_num_s = tostring(client_curve_num_s), client_ec_point_format_s = tostring(client_ec_point_format_s), resp_multihomed_b = tostring(resp_multihomed_b), client_extension_s = tostring(client_extension_s), client_version_num_d = toreal(client_version_num_d), curve_s = tostring(curve_s), established_b = tostring(established_b), ja3_g = tostring(ja3_g), ja3s_g = tostring(ja3s_g), server_extensions_s = tostring(server_extensions_s), server_name_s = tostring(server_name_s), version_s = tostring(version_s), version_num_d = toreal(version_num_d), resp_hostname_s = tostring(resp_hostname_s), client_version_s = tostring(client_version_s), resp_ip_bytes_s = tostring(resp_ip_bytes_s), resp_domain_s = tostring(resp_domain_s), protoName_s = tostring(protoName_s), conn_state_s = tostring(conn_state_s), duration_d = toreal(duration_d), first_orig_resp_data_pkt_s = tostring(first_orig_resp_data_pkt_s), first_orig_resp_data_pkt_time_d = toreal(first_orig_resp_data_pkt_time_d), first_orig_resp_pkt_time_d = toreal(first_orig_resp_pkt_time_d), first_resp_orig_data_pkt_s = tostring(first_resp_orig_data_pkt_s), first_resp_orig_data_pkt_time_d = toreal(first_resp_orig_data_pkt_time_d), first_resp_orig_pkt_time_d = toreal(first_resp_orig_pkt_time_d), id_ip_ver_s = tostring(id_ip_ver_s), id_orig_h_s = tostring(id_orig_h_s), id_orig_p_d = toreal(id_orig_p_d), id_resp_h_s = tostring(id_resp_h_s), id_resp_p_d = toreal(id_resp_p_d), local_orig_b = tostring(local_orig_b), local_resp_b = tostring(local_resp_b), metadata_type_s = tostring(metadata_type_s), orig_hostname_s = tostring(orig_hostname_s), orig_huid_s = tostring(orig_huid_s), orig_ip_bytes_s = tostring(orig_ip_bytes_s), orig_pkts_d = toreal(orig_pkts_d), orig_sluid_s = tostring(orig_sluid_s), orig_vlan_id_d = toreal(orig_vlan_id_d), proto_d = toreal(proto_d), host_s = tostring(host_s), path_s = tostring(path_s), user_agent_s = tostring(user_agent_s), response_expires_s = tostring(response_expires_s), tls_b = tostring(tls_b), proxied_s = tostring(proxied_s), error_s = tostring(error_s), matched_dn_s = tostring(matched_dn_s), referrer_s = tostring(referrer_s), client_build_s = tostring(client_build_s), desktop_height_d = toreal(desktop_height_d), desktop_width_d = toreal(desktop_width_d), keyboard_layout_s = tostring(keyboard_layout_s), beacon_type_s = tostring(beacon_type_s), msgid_s = tostring(msgid_s), beacon_uid_s = tostring(beacon_uid_s), last_event_time_d = toreal(last_event_time_d), orig_ip_bytes_d = toreal(orig_ip_bytes_d), resp_domains_s = tostring(resp_domains_s), resp_ip_bytes_d = toreal(resp_ip_bytes_d), session_count_d = toreal(session_count_d), resp_filename_s = tostring(resp_filename_s), response_content_disposition_s = tostring(response_content_disposition_s), cookie_s = tostring(cookie_s), cookie_vars_s = tostring(cookie_vars_s), orig_mime_types_s = tostring(orig_mime_types_s), first_event_time_d = toreal(first_event_time_d), mail_from_s = tostring(mail_from_s), helo_s = tostring(helo_s), from_s = tostring(from_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), client_dig_product_id_s = tostring(client_dig_product_id_s), client_dig_protocol_id_s = tostring(client_dig_protocol_id_s), client_name_s = tostring(client_name_s), dir_confidence_d = toreal(dir_confidence_d), san_ip_s = tostring(san_ip_s), host_key_s = tostring(host_key_s), application_s = tostring(application_s), error_msg_s = tostring(error_msg_s), reply_to_s = tostring(reply_to_s), useragent_s = tostring(useragent_s), second_received_s = tostring(second_received_s), spf_mailfrom_s = tostring(spf_mailfrom_s), x_originating_ip_s = tostring(x_originating_ip_s), first_received_s = tostring(first_received_s), in_reply_to_s = tostring(in_reply_to_s), rcpt_to_s = tostring(rcpt_to_s), to_s = tostring(to_s), date_s = tostring(date_s), domain_s = tostring(domain_s), resp_huid_s = tostring(resp_huid_s), status_d = toreal(status_d), cipher_alg_s = tostring(cipher_alg_s), result_s = tostring(result_s), result_code_s = tostring(result_code_s), result_count_d = toreal(result_count_d), base_object_s = tostring(base_object_s), endpoint_s = tostring(endpoint_s), operation_s = tostring(operation_s), rtt_d = toreal(rtt_d), action_s = tostring(action_s), delete_on_close_b = tostring(delete_on_close_b), name_s = tostring(name_s), response_bytes_s = tostring(response_bytes_s), hostname_s = tostring(hostname_s), client_subject_s = tostring(client_subject_s), certificate_serial_g = tostring(certificate_serial_g), resp_mime_types_s = tostring(resp_mime_types_s), response_cache_control_s = tostring(response_cache_control_s), lease_time_d = toreal(lease_time_d), mac_s = tostring(mac_s), assigned_ip_s = tostring(assigned_ip_s), dhcp_server_ip_s = tostring(dhcp_server_ip_s), dns_server_ips_s = tostring(dns_server_ips_s), request_cache_control_s = tostring(request_cache_control_s), client_issuer_s = tostring(client_issuer_s), request_bytes_s = tostring(request_bytes_s), query_scope_s = tostring(query_scope_s), message_id_d = toreal(message_id_d), compression_alg_s = tostring(compression_alg_s), hassh_g = tostring(hassh_g), hasshServer_g = tostring(hasshServer_g), host_key_alg_s = tostring(host_key_alg_s), kex_alg_s = tostring(kex_alg_s), mac_alg_s = tostring(mac_alg_s), server_s = tostring(server_s), client_s = tostring(client_s), data_source_s = tostring(data_source_s), error_code_s = tostring(error_code_s), orig_host_observed_privilege_d = toreal(orig_host_observed_privilege_d), protocol_d = toreal(protocol_d), rep_cipher_s = tostring(rep_cipher_s), reply_timestamp_d = toreal(reply_timestamp_d), req_ciphers_s = tostring(req_ciphers_s), request_type_s = tostring(request_type_s), success_b = tostring(success_b), attributes_s = tostring(attributes_s), bind_error_count_d = toreal(bind_error_count_d), encrypted_sasl_payload_count_d = toreal(encrypted_sasl_payload_count_d), is_close_b = tostring(is_close_b), is_query_b = tostring(is_query_b), logon_failure_error_count_d = toreal(logon_failure_error_count_d), username_s = tostring(username_s), resp_sluid_s = tostring(resp_sluid_s)'
        outputStream: 'Custom-VectraStream_CL'
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
