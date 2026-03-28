// Bicep template for Log Analytics custom table: VectraStream_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 214, Deployed columns: 211 (Type column filtered)
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

resource vectrastreamclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'VectraStream_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'VectraStream_CL'
      description: 'Custom table VectraStream_CL - imported from JSON schema'
      displayName: 'VectraStream_CL'
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
          name: 'saw_query_b'
          type: 'string'
        }
        {
          name: 'saw_reply_b'
          type: 'string'
        }
        {
          name: 'total_answers_d'
          type: 'real'
        }
        {
          name: 'total_replies_d'
          type: 'real'
        }
        {
          name: 'trans_id_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'certificate_not_valid_before_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'request_header_count_d'
          type: 'real'
        }
        {
          name: 'response_body_len_d'
          type: 'real'
        }
        {
          name: 'response_header_count_d'
          type: 'real'
        }
        {
          name: 'status_code_d'
          type: 'real'
        }
        {
          name: 'status_msg_s'
          type: 'string'
        }
        {
          name: 'uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'rcode_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'qclass_name_s'
          type: 'string'
        }
        {
          name: 'qtype_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'resp_vlan_id_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'ts_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'first_orig_resp_data_pkt_s'
          type: 'string'
        }
        {
          name: 'first_orig_resp_data_pkt_time_d'
          type: 'real'
        }
        {
          name: 'first_orig_resp_pkt_time_d'
          type: 'real'
        }
        {
          name: 'first_resp_orig_data_pkt_s'
          type: 'string'
        }
        {
          name: 'first_resp_orig_data_pkt_time_d'
          type: 'real'
        }
        {
          name: 'first_resp_orig_pkt_time_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'orig_sluid_s'
          type: 'string'
        }
        {
          name: 'orig_vlan_id_d'
          type: 'real'
        }
        {
          name: 'proto_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'desktop_width_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'orig_ip_bytes_d'
          type: 'real'
        }
        {
          name: 'resp_domains_s'
          type: 'string'
        }
        {
          name: 'resp_ip_bytes_d'
          type: 'real'
        }
        {
          name: 'session_count_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'protocol_d'
          type: 'real'
        }
        {
          name: 'rep_cipher_s'
          type: 'string'
        }
        {
          name: 'reply_timestamp_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'encrypted_sasl_payload_count_d'
          type: 'real'
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
          type: 'real'
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
}

output tableName string = vectrastreamclTable.name
output tableId string = vectrastreamclTable.id
output provisioningState string = vectrastreamclTable.properties.provisioningState
