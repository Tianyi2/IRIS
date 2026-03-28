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
// Data Collection Rule for NetskopeWebtxData_CL
// ============================================================================
// Generated: 2025-09-19 14:20:26
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 159, DCR columns: 157 (Type column always filtered)
// Output stream: Custom-NetskopeWebtxData_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-NetskopeWebtxData_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-NetskopeWebtxData_CL': {
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
            name: 'x_cs_ssl_cipher_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_version_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_cipher_s'
            type: 'string'
          }
          {
            name: 'x_cs_src_ip_egress_s'
            type: 'string'
          }
          {
            name: 'x_s_dp_name_s'
            type: 'string'
          }
          {
            name: 'x_cs_src_ip_s'
            type: 'string'
          }
          {
            name: 'x_cs_src_port_s'
            type: 'string'
          }
          {
            name: 'x_cs_dst_ip_s'
            type: 'string'
          }
          {
            name: 'x_cs_dst_port_s'
            type: 'string'
          }
          {
            name: 'x_sr_src_ip_s'
            type: 'string'
          }
          {
            name: 'x_sr_src_port_s'
            type: 'string'
          }
          {
            name: 'x_sr_dst_ip_s'
            type: 'string'
          }
          {
            name: 'x_sr_dst_port_s'
            type: 'string'
          }
          {
            name: 'x_cs_ip_connect_xff_s'
            type: 'string'
          }
          {
            name: 'x_cs_ip_xff_s'
            type: 'string'
          }
          {
            name: 'x_cs_ssl_version_s'
            type: 'string'
          }
          {
            name: 'x_ssl_policy_name_s'
            type: 'string'
          }
          {
            name: 'x_ssl_policy_action_s'
            type: 'string'
          }
          {
            name: 'x_ssl_policy_categories_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_revocation_check_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_mismatch_s'
            type: 'string'
          }
          {
            name: 'x_cs_ssl_fronting_error_s'
            type: 'string'
          }
          {
            name: 'x_cs_ssl_handshake_error_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_handshake_error_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_client_certificate_error_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_malformed_ssl_s'
            type: 'string'
          }
          {
            name: 'x_cs_connect_host_s'
            type: 'string'
          }
          {
            name: 'x_s_custom_signing_ca_error_s'
            type: 'string'
          }
          {
            name: 'x_cs_ssl_engine_action_reason_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_engine_action_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_engine_action_reason_s'
            type: 'string'
          }
          {
            name: 'x_ssl_policy_src_ip_s'
            type: 'string'
          }
          {
            name: 'x_ssl_policy_dst_ip_s'
            type: 'string'
          }
          {
            name: 'x_ssl_policy_dst_host_s'
            type: 'string'
          }
          {
            name: 'x_ssl_policy_dst_host_source_s'
            type: 'string'
          }
          {
            name: 'x_cs_ssl_engine_action_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_revoked_s'
            type: 'string'
          }
          {
            name: 'x_cs_connect_port_s'
            type: 'string'
          }
          {
            name: 'x_cs_url_s'
            type: 'string'
          }
          {
            name: 'x_rs_file_size_s'
            type: 'string'
          }
          {
            name: 'x_rs_file_md5_s'
            type: 'string'
          }
          {
            name: 'x_rs_file_sha256_s'
            type: 'string'
          }
          {
            name: 'x_error_s'
            type: 'string'
          }
          {
            name: 'x_c_local_time_s'
            type: 'string'
          }
          {
            name: 'x_policy_action_s'
            type: 'string'
          }
          {
            name: 'x_policy_name_s'
            type: 'string'
          }
          {
            name: 'x_policy_src_ip_s'
            type: 'string'
          }
          {
            name: 'x_policy_dst_ip_s'
            type: 'string'
          }
          {
            name: 'x_policy_dst_host_s'
            type: 'string'
          }
          {
            name: 'x_policy_dst_host_source_s'
            type: 'string'
          }
          {
            name: 'x_policy_justification_type_s'
            type: 'string'
          }
          {
            name: 'x_policy_justification_reason_s'
            type: 'string'
          }
          {
            name: 'x_sc_notification_name_s'
            type: 'string'
          }
          {
            name: 'netskope_api_host_name_s'
            type: 'string'
          }
          {
            name: 'x_rs_file_language_s'
            type: 'string'
          }
          {
            name: 'x_rs_file_category_s'
            type: 'string'
          }
          {
            name: 'x_rs_file_type_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_object_id_s'
            type: 'string'
          }
          {
            name: 'x_cs_uri_path_s'
            type: 'string'
          }
          {
            name: 'x_cs_http_version_s'
            type: 'string'
          }
          {
            name: 'rs_status_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_category_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_cci_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_ccl_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_tags_s'
            type: 'string'
          }
          {
            name: 'x_cs_connect_user_agent_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_suite_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_instance_name_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_instance_tag_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_activity_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_from_user_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_to_user_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_object_type_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_object_name_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_instance_id_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_self_signed_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_incomplete_chain_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_untrusted_root_s'
            type: 'string'
          }
          {
            name: 'sc_status_s'
            type: 'string'
          }
          {
            name: 'sc_content_type_s'
            type: 'string'
          }
          {
            name: 'cs_dns_s'
            type: 'string'
          }
          {
            name: 'cs_host_s'
            type: 'string'
          }
          {
            name: 'cs_uri_s'
            type: 'string'
          }
          {
            name: 'cs_uri_port_s'
            type: 'string'
          }
          {
            name: 'cs_referer_s'
            type: 'string'
          }
          {
            name: 'x_cs_session_id_s'
            type: 'string'
          }
          {
            name: 'x_cs_access_method_s'
            type: 'string'
          }
          {
            name: 'x_cs_app_s'
            type: 'string'
          }
          {
            name: 'x_s_country_s'
            type: 'string'
          }
          {
            name: 'x_s_latitude_s'
            type: 'string'
          }
          {
            name: 'x_s_longitude_s'
            type: 'string'
          }
          {
            name: 'x_s_location_s'
            type: 'string'
          }
          {
            name: 'x_s_region_s'
            type: 'string'
          }
          {
            name: 'cs_content_type_s'
            type: 'string'
          }
          {
            name: 'cs_user_agent_s'
            type: 'string'
          }
          {
            name: 'cs_uri_query_s'
            type: 'string'
          }
          {
            name: 'cs_uri_scheme_s'
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
            name: 'cs_uri_query_g'
            type: 'string'
          }
          {
            name: 'date_s'
            type: 'string'
          }
          {
            name: 'x_s_zipcode_s'
            type: 'string'
          }
          {
            name: 'time_s'
            type: 'string'
          }
          {
            name: 'cs_bytes_s'
            type: 'string'
          }
          {
            name: 'sc_bytes_s'
            type: 'string'
          }
          {
            name: 'bytes_s'
            type: 'string'
          }
          {
            name: 'c_ip_s'
            type: 'string'
          }
          {
            name: 's_ip_s'
            type: 'string'
          }
          {
            name: 'cs_username_s'
            type: 'string'
          }
          {
            name: 'cs_method_s'
            type: 'string'
          }
          {
            name: 'time_taken_s'
            type: 'string'
          }
          {
            name: 'x_c_country_s'
            type: 'string'
          }
          {
            name: 'x_c_latitude_s'
            type: 'string'
          }
          {
            name: 'x_c_longitude_s'
            type: 'string'
          }
          {
            name: 'x_cs_sni_s'
            type: 'string'
          }
          {
            name: 'x_cs_domain_fronted_sni_s'
            type: 'string'
          }
          {
            name: 'x_category_id_s'
            type: 'string'
          }
          {
            name: 'x_other_category_id_s'
            type: 'string'
          }
          {
            name: 'x_sr_headers_name_s'
            type: 'string'
          }
          {
            name: 'x_sr_headers_value_s'
            type: 'string'
          }
          {
            name: 'x_cs_ssl_ja3_g'
            type: 'string'
          }
          {
            name: 'x_request_id_s'
            type: 'string'
          }
          {
            name: 'x_sr_ssl_ja3s_s'
            type: 'string'
          }
          {
            name: 'x_ssl_bypass_reason_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_subject_cn_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_issuer_cn_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_startdate_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_enddate_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_valid_s'
            type: 'string'
          }
          {
            name: 'x_r_cert_expired_s'
            type: 'string'
          }
          {
            name: 'x_ssl_bypass_s'
            type: 'string'
          }
          {
            name: 'x_cs_ssl_ja3_s'
            type: 'string'
          }
          {
            name: 'x_transaction_id_s'
            type: 'string'
          }
          {
            name: 'x_server_ssl_err_s'
            type: 'string'
          }
          {
            name: 'x_c_location_s'
            type: 'string'
          }
          {
            name: 'x_c_region_s'
            type: 'string'
          }
          {
            name: 'x_c_zipcode_s'
            type: 'string'
          }
          {
            name: 'x_c_os_s'
            type: 'string'
          }
          {
            name: 'x_c_browser_s'
            type: 'string'
          }
          {
            name: 'x_c_browser_version_s'
            type: 'string'
          }
          {
            name: 'x_c_device_s'
            type: 'string'
          }
          {
            name: 'x_client_ssl_err_s'
            type: 'string'
          }
          {
            name: 'x_cs_site_s'
            type: 'string'
          }
          {
            name: 'x_cs_page_id_s'
            type: 'string'
          }
          {
            name: 'x_cs_userip_s'
            type: 'string'
          }
          {
            name: 'x_cs_traffic_type_s'
            type: 'string'
          }
          {
            name: 'x_cs_tunnel_id_s'
            type: 'string'
          }
          {
            name: 'x_category_s'
            type: 'string'
          }
          {
            name: 'x_other_category_s'
            type: 'string'
          }
          {
            name: 'x_type_s'
            type: 'string'
          }
          {
            name: 'x_cs_timestamp_s'
            type: 'string'
          }
          {
            name: 'x_rs_file_md5_g'
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
          name: 'Sentinel-NetskopeWebtxData_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-NetskopeWebtxData_CL']
        destinations: ['Sentinel-NetskopeWebtxData_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), x_cs_ssl_cipher_s = tostring(x_cs_ssl_cipher_s), x_sr_ssl_version_s = tostring(x_sr_ssl_version_s), x_sr_ssl_cipher_s = tostring(x_sr_ssl_cipher_s), x_cs_src_ip_egress_s = tostring(x_cs_src_ip_egress_s), x_s_dp_name_s = tostring(x_s_dp_name_s), x_cs_src_ip_s = tostring(x_cs_src_ip_s), x_cs_src_port_s = tostring(x_cs_src_port_s), x_cs_dst_ip_s = tostring(x_cs_dst_ip_s), x_cs_dst_port_s = tostring(x_cs_dst_port_s), x_sr_src_ip_s = tostring(x_sr_src_ip_s), x_sr_src_port_s = tostring(x_sr_src_port_s), x_sr_dst_ip_s = tostring(x_sr_dst_ip_s), x_sr_dst_port_s = tostring(x_sr_dst_port_s), x_cs_ip_connect_xff_s = tostring(x_cs_ip_connect_xff_s), x_cs_ip_xff_s = tostring(x_cs_ip_xff_s), x_cs_ssl_version_s = tostring(x_cs_ssl_version_s), x_ssl_policy_name_s = tostring(x_ssl_policy_name_s), x_ssl_policy_action_s = tostring(x_ssl_policy_action_s), x_ssl_policy_categories_s = tostring(x_ssl_policy_categories_s), x_r_cert_revocation_check_s = tostring(x_r_cert_revocation_check_s), x_r_cert_mismatch_s = tostring(x_r_cert_mismatch_s), x_cs_ssl_fronting_error_s = tostring(x_cs_ssl_fronting_error_s), x_cs_ssl_handshake_error_s = tostring(x_cs_ssl_handshake_error_s), x_sr_ssl_handshake_error_s = tostring(x_sr_ssl_handshake_error_s), x_sr_ssl_client_certificate_error_s = tostring(x_sr_ssl_client_certificate_error_s), x_sr_ssl_malformed_ssl_s = tostring(x_sr_ssl_malformed_ssl_s), x_cs_connect_host_s = tostring(x_cs_connect_host_s), x_s_custom_signing_ca_error_s = tostring(x_s_custom_signing_ca_error_s), x_cs_ssl_engine_action_reason_s = tostring(x_cs_ssl_engine_action_reason_s), x_sr_ssl_engine_action_s = tostring(x_sr_ssl_engine_action_s), x_sr_ssl_engine_action_reason_s = tostring(x_sr_ssl_engine_action_reason_s), x_ssl_policy_src_ip_s = tostring(x_ssl_policy_src_ip_s), x_ssl_policy_dst_ip_s = tostring(x_ssl_policy_dst_ip_s), x_ssl_policy_dst_host_s = tostring(x_ssl_policy_dst_host_s), x_ssl_policy_dst_host_source_s = tostring(x_ssl_policy_dst_host_source_s), x_cs_ssl_engine_action_s = tostring(x_cs_ssl_engine_action_s), x_r_cert_revoked_s = tostring(x_r_cert_revoked_s), x_cs_connect_port_s = tostring(x_cs_connect_port_s), x_cs_url_s = tostring(x_cs_url_s), x_rs_file_size_s = tostring(x_rs_file_size_s), x_rs_file_md5_s = tostring(x_rs_file_md5_s), x_rs_file_sha256_s = tostring(x_rs_file_sha256_s), x_error_s = tostring(x_error_s), x_c_local_time_s = tostring(x_c_local_time_s), x_policy_action_s = tostring(x_policy_action_s), x_policy_name_s = tostring(x_policy_name_s), x_policy_src_ip_s = tostring(x_policy_src_ip_s), x_policy_dst_ip_s = tostring(x_policy_dst_ip_s), x_policy_dst_host_s = tostring(x_policy_dst_host_s), x_policy_dst_host_source_s = tostring(x_policy_dst_host_source_s), x_policy_justification_type_s = tostring(x_policy_justification_type_s), x_policy_justification_reason_s = tostring(x_policy_justification_reason_s), x_sc_notification_name_s = tostring(x_sc_notification_name_s), netskope_api_host_name_s = tostring(netskope_api_host_name_s), x_rs_file_language_s = tostring(x_rs_file_language_s), x_rs_file_category_s = tostring(x_rs_file_category_s), x_rs_file_type_s = tostring(x_rs_file_type_s), x_cs_app_object_id_s = tostring(x_cs_app_object_id_s), x_cs_uri_path_s = tostring(x_cs_uri_path_s), x_cs_http_version_s = tostring(x_cs_http_version_s), rs_status_s = tostring(rs_status_s), x_cs_app_category_s = tostring(x_cs_app_category_s), x_cs_app_cci_s = tostring(x_cs_app_cci_s), x_cs_app_ccl_s = tostring(x_cs_app_ccl_s), x_cs_app_tags_s = tostring(x_cs_app_tags_s), x_cs_connect_user_agent_s = tostring(x_cs_connect_user_agent_s), x_cs_app_suite_s = tostring(x_cs_app_suite_s), x_cs_app_instance_name_s = tostring(x_cs_app_instance_name_s), x_cs_app_instance_tag_s = tostring(x_cs_app_instance_tag_s), x_cs_app_activity_s = tostring(x_cs_app_activity_s), x_cs_app_from_user_s = tostring(x_cs_app_from_user_s), x_cs_app_to_user_s = tostring(x_cs_app_to_user_s), x_cs_app_object_type_s = tostring(x_cs_app_object_type_s), x_cs_app_object_name_s = tostring(x_cs_app_object_name_s), x_cs_app_instance_id_s = tostring(x_cs_app_instance_id_s), x_r_cert_self_signed_s = tostring(x_r_cert_self_signed_s), x_r_cert_incomplete_chain_s = tostring(x_r_cert_incomplete_chain_s), x_r_cert_untrusted_root_s = tostring(x_r_cert_untrusted_root_s), sc_status_s = tostring(sc_status_s), sc_content_type_s = tostring(sc_content_type_s), cs_dns_s = tostring(cs_dns_s), cs_host_s = tostring(cs_host_s), cs_uri_s = tostring(cs_uri_s), cs_uri_port_s = tostring(cs_uri_port_s), cs_referer_s = tostring(cs_referer_s), x_cs_session_id_s = tostring(x_cs_session_id_s), x_cs_access_method_s = tostring(x_cs_access_method_s), x_cs_app_s = tostring(x_cs_app_s), x_s_country_s = tostring(x_s_country_s), x_s_latitude_s = tostring(x_s_latitude_s), x_s_longitude_s = tostring(x_s_longitude_s), x_s_location_s = tostring(x_s_location_s), x_s_region_s = tostring(x_s_region_s), cs_content_type_s = tostring(cs_content_type_s), cs_user_agent_s = tostring(cs_user_agent_s), cs_uri_query_s = tostring(cs_uri_query_s), cs_uri_scheme_s = tostring(cs_uri_scheme_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), cs_uri_query_g = tostring(cs_uri_query_g), date_s = tostring(date_s), x_s_zipcode_s = tostring(x_s_zipcode_s), time_s = tostring(time_s), cs_bytes_s = tostring(cs_bytes_s), sc_bytes_s = tostring(sc_bytes_s), bytes_s = tostring(bytes_s), c_ip_s = tostring(c_ip_s), s_ip_s = tostring(s_ip_s), cs_username_s = tostring(cs_username_s), cs_method_s = tostring(cs_method_s), time_taken_s = tostring(time_taken_s), x_c_country_s = tostring(x_c_country_s), x_c_latitude_s = tostring(x_c_latitude_s), x_c_longitude_s = tostring(x_c_longitude_s), x_cs_sni_s = tostring(x_cs_sni_s), x_cs_domain_fronted_sni_s = tostring(x_cs_domain_fronted_sni_s), x_category_id_s = tostring(x_category_id_s), x_other_category_id_s = tostring(x_other_category_id_s), x_sr_headers_name_s = tostring(x_sr_headers_name_s), x_sr_headers_value_s = tostring(x_sr_headers_value_s), x_cs_ssl_ja3_g = tostring(x_cs_ssl_ja3_g), x_request_id_s = tostring(x_request_id_s), x_sr_ssl_ja3s_s = tostring(x_sr_ssl_ja3s_s), x_ssl_bypass_reason_s = tostring(x_ssl_bypass_reason_s), x_r_cert_subject_cn_s = tostring(x_r_cert_subject_cn_s), x_r_cert_issuer_cn_s = tostring(x_r_cert_issuer_cn_s), x_r_cert_startdate_s = tostring(x_r_cert_startdate_s), x_r_cert_enddate_s = tostring(x_r_cert_enddate_s), x_r_cert_valid_s = tostring(x_r_cert_valid_s), x_r_cert_expired_s = tostring(x_r_cert_expired_s), x_ssl_bypass_s = tostring(x_ssl_bypass_s), x_cs_ssl_ja3_s = tostring(x_cs_ssl_ja3_s), x_transaction_id_s = tostring(x_transaction_id_s), x_server_ssl_err_s = tostring(x_server_ssl_err_s), x_c_location_s = tostring(x_c_location_s), x_c_region_s = tostring(x_c_region_s), x_c_zipcode_s = tostring(x_c_zipcode_s), x_c_os_s = tostring(x_c_os_s), x_c_browser_s = tostring(x_c_browser_s), x_c_browser_version_s = tostring(x_c_browser_version_s), x_c_device_s = tostring(x_c_device_s), x_client_ssl_err_s = tostring(x_client_ssl_err_s), x_cs_site_s = tostring(x_cs_site_s), x_cs_page_id_s = tostring(x_cs_page_id_s), x_cs_userip_s = tostring(x_cs_userip_s), x_cs_traffic_type_s = tostring(x_cs_traffic_type_s), x_cs_tunnel_id_s = tostring(x_cs_tunnel_id_s), x_category_s = tostring(x_category_s), x_other_category_s = tostring(x_other_category_s), x_type_s = tostring(x_type_s), x_cs_timestamp_s = tostring(x_cs_timestamp_s), x_rs_file_md5_g = tostring(x_rs_file_md5_g)'
        outputStream: 'Custom-NetskopeWebtxData_CL'
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
