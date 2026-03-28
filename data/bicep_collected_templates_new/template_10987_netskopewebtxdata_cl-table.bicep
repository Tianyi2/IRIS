// Bicep template for Log Analytics custom table: NetskopeWebtxData_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 159, Deployed columns: 157 (Type column filtered)
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

resource netskopewebtxdataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'NetskopeWebtxData_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'NetskopeWebtxData_CL'
      description: 'Custom table NetskopeWebtxData_CL - imported from JSON schema'
      displayName: 'NetskopeWebtxData_CL'
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
          dataTypeHint: 0
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
          dataTypeHint: 0
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
          dataTypeHint: 0
        }
        {
          name: 'cs_uri_port_s'
          type: 'string'
          dataTypeHint: 0
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
          dataTypeHint: 0
        }
        {
          name: 'cs_uri_scheme_s'
          type: 'string'
          dataTypeHint: 0
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
          dataTypeHint: 0
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
}

output tableName string = netskopewebtxdataclTable.name
output tableId string = netskopewebtxdataclTable.id
output provisioningState string = netskopewebtxdataclTable.properties.provisioningState
