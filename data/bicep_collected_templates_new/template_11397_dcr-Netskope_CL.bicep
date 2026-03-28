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
// Data Collection Rule for Netskope_CL
// ============================================================================
// Generated: 2025-09-19 14:20:26
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 339, DCR columns: 335 (Type column always filtered)
// Output stream: Custom-Netskope_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Netskope_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Netskope_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'access_method_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'quarantine_profile_s'
            type: 'string'
          }
          {
            name: 'quarantine_profile_id_s'
            type: 'string'
          }
          {
            name: 'quarantine_file_name_s'
            type: 'string'
          }
          {
            name: 'quarantine_file_id_s'
            type: 'string'
          }
          {
            name: 'q_original_version_s'
            type: 'string'
          }
          {
            name: 'q_original_shared_s'
            type: 'string'
          }
          {
            name: 'referer_s'
            type: 'string'
          }
          {
            name: 'q_original_filepath_s'
            type: 'string'
          }
          {
            name: 'q_instance_s'
            type: 'string'
          }
          {
            name: 'q_app_s'
            type: 'string'
          }
          {
            name: 'q_admin_s'
            type: 'string'
          }
          {
            name: 'protocol_s'
            type: 'string'
          }
          {
            name: 'profile_id_s'
            type: 'string'
          }
          {
            name: 'profile_emails_s'
            type: 'string'
          }
          {
            name: 'ProcessName_s'
            type: 'string'
          }
          {
            name: 'q_original_filename_s'
            type: 'string'
          }
          {
            name: 'region_id_s'
            type: 'string'
          }
          {
            name: 'region_name_s'
            type: 'string'
          }
          {
            name: 'request_id_d'
            type: 'string'
          }
          {
            name: 'scanner_result_s'
            type: 'string'
          }
          {
            name: 'scan_type_s'
            type: 'string'
          }
          {
            name: 'scan_time_d'
            type: 'string'
          }
          {
            name: 'sanctioned_instance_s'
            type: 'string'
          }
          {
            name: 'sa_rule_severity_s'
            type: 'string'
          }
          {
            name: 'sa_rule_remediation_s'
            type: 'string'
          }
          {
            name: 'sa_rule_name_s'
            type: 'string'
          }
          {
            name: 'sa_rule_id_s'
            type: 'string'
          }
          {
            name: 'sa_profile_name_s'
            type: 'string'
          }
          {
            name: 'sa_profile_id_d'
            type: 'string'
          }
          {
            name: 'role_s'
            type: 'string'
          }
          {
            name: 'retro_scan_name_s'
            type: 'string'
          }
          {
            name: 'resp_content_type_s'
            type: 'string'
          }
          {
            name: 'resp_content_len_d'
            type: 'string'
          }
          {
            name: 'resp_cnt_d'
            type: 'string'
          }
          {
            name: 'resource_category_s'
            type: 'string'
          }
          {
            name: 'requestid_s'
            type: 'string'
          }
          {
            name: 'ProcessID_s'
            type: 'string'
          }
          {
            name: 'pop_id_s'
            type: 'string'
          }
          {
            name: 'policy_s'
            type: 'string'
          }
          {
            name: 'policy_name_s'
            type: 'string'
          }
          {
            name: 'nsdeviceuid_g'
            type: 'string'
          }
          {
            name: 'notify_template_s'
            type: 'string'
          }
          {
            name: 'netskope_pop_s'
            type: 'string'
          }
          {
            name: 'netskope_activity_s'
            type: 'string'
          }
          {
            name: 'modified_date_d'
            type: 'string'
          }
          {
            name: 'modified_d'
            type: 'string'
          }
          {
            name: 'ml_detection_s'
            type: 'string'
          }
          {
            name: 'mime_type_s'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'metadata_service_s'
            type: 'string'
          }
          {
            name: 'metadata_policy_s'
            type: 'string'
          }
          {
            name: 'metadata_attack_severity_s'
            type: 'string'
          }
          {
            name: 'Message'
            type: 'string'
          }
          {
            name: 'matched_username_s'
            type: 'string'
          }
          {
            name: 'managementID_s'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'managed_app_s'
            type: 'string'
          }
          {
            name: 'numbytes_d'
            type: 'string'
          }
          {
            name: 'score_d'
            type: 'string'
          }
          {
            name: 'object_count_d'
            type: 'string'
          }
          {
            name: 'object_s'
            type: 'string'
          }
          {
            name: 'policy_id_s'
            type: 'string'
          }
          {
            name: 'policy_actions_s'
            type: 'string'
          }
          {
            name: 'path_id_s'
            type: 'string'
          }
          {
            name: 'password_type_s'
            type: 'string'
          }
          {
            name: 'parent_id_s'
            type: 'string'
          }
          {
            name: 'page_site_s'
            type: 'string'
          }
          {
            name: 'page_s'
            type: 'string'
          }
          {
            name: 'owner_s'
            type: 'string'
          }
          {
            name: 'outer_doc_type_d'
            type: 'string'
          }
          {
            name: 'other_categories_s'
            type: 'string'
          }
          {
            name: 'os_version_s'
            type: 'string'
          }
          {
            name: 'os_s'
            type: 'string'
          }
          {
            name: 'orignal_file_path_s'
            type: 'string'
          }
          {
            name: 'orig_ty_s'
            type: 'string'
          }
          {
            name: 'organization_unit_s'
            type: 'string'
          }
          {
            name: 'OpId_s'
            type: 'string'
          }
          {
            name: 'object_type_s'
            type: 'string'
          }
          {
            name: 'object_id_g'
            type: 'string'
          }
          {
            name: 'server_bytes_d'
            type: 'string'
          }
          {
            name: 'server_packets_d'
            type: 'string'
          }
          {
            name: 'service_identifier_s'
            type: 'string'
          }
          {
            name: 'tunnel_id_s'
            type: 'string'
          }
          {
            name: 'tunnel_id_g'
            type: 'string'
          }
          {
            name: 'TSS_scan_s'
            type: 'string'
          }
          {
            name: 'tss_mode_s'
            type: 'string'
          }
          {
            name: 'tss_license_s'
            type: 'string'
          }
          {
            name: 'trust_computer_checked_s'
            type: 'string'
          }
          {
            name: 'true_type_id_d'
            type: 'string'
          }
          {
            name: 'true_obj_type_s'
            type: 'string'
          }
          {
            name: 'true_obj_category_s'
            type: 'string'
          }
          {
            name: 'true_filetype_s'
            type: 'string'
          }
          {
            name: 'traffic_type_s'
            type: 'string'
          }
          {
            name: 'total_packets_d'
            type: 'string'
          }
          {
            name: 'total_collaborator_count_d'
            type: 'string'
          }
          {
            name: 'to_user_s'
            type: 'string'
          }
          {
            name: 'to_user_category_s'
            type: 'string'
          }
          {
            name: 'to_storage_s'
            type: 'string'
          }
          {
            name: 'to_object_s'
            type: 'string'
          }
          {
            name: 'tunnel_type_s'
            type: 'string'
          }
          {
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'tunnel_up_time_d'
            type: 'string'
          }
          {
            name: 'ur_normalized_s'
            type: 'string'
          }
          {
            name: 'windowId_d'
            type: 'string'
          }
          {
            name: 'web_url_s'
            type: 'string'
          }
          {
            name: 'web_universal_connector_s'
            type: 'string'
          }
          {
            name: 'violating_user_s'
            type: 'string'
          }
          {
            name: 'UserName_s'
            type: 'string'
          }
          {
            name: 'userkey_g'
            type: 'string'
          }
          {
            name: 'userip_s'
            type: 'string'
          }
          {
            name: 'useragent_s'
            type: 'string'
          }
          {
            name: 'User_SPACE_Name_s'
            type: 'string'
          }
          {
            name: 'User_SPACE_Id_s'
            type: 'string'
          }
          {
            name: 'user_s'
            type: 'string'
          }
          {
            name: 'user_role_s'
            type: 'string'
          }
          {
            name: 'user_name_s'
            type: 'string'
          }
          {
            name: 'user_id_g'
            type: 'string'
          }
          {
            name: 'user_generated_s'
            type: 'string'
          }
          {
            name: 'user_category_s'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'two_factor_auth_s'
            type: 'string'
          }
          {
            name: 'malware_type_s'
            type: 'string'
          }
          {
            name: 'threshold_time_d'
            type: 'string'
          }
          {
            name: 'threat_source_id_d'
            type: 'string'
          }
          {
            name: 'src_latitude_d'
            type: 'string'
          }
          {
            name: 'src_geoip_src_d'
            type: 'string'
          }
          {
            name: 'src_country_s'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'slc_longitude_d'
            type: 'string'
          }
          {
            name: 'slc_latitude_d'
            type: 'string'
          }
          {
            name: 'site_s'
            type: 'string'
          }
          {
            name: 'signature_s'
            type: 'string'
          }
          {
            name: 'signature_id_d'
            type: 'string'
          }
          {
            name: 'shared_with_s'
            type: 'string'
          }
          {
            name: 'shared_type_s'
            type: 'string'
          }
          {
            name: 'shared_domains_s'
            type: 'string'
          }
          {
            name: 'SeverityLevel_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'severity_level_d'
            type: 'string'
          }
          {
            name: 'severity_id_d'
            type: 'string'
          }
          {
            name: 'session_duration_d'
            type: 'string'
          }
          {
            name: 'src_location_s'
            type: 'string'
          }
          {
            name: 'threshold_d'
            type: 'string'
          }
          {
            name: 'src_longitude_d'
            type: 'string'
          }
          {
            name: 'src_time_s'
            type: 'string'
          }
          {
            name: 'threat_match_value_s'
            type: 'string'
          }
          {
            name: 'threat_match_field_s'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'telemetry_app_s'
            type: 'string'
          }
          {
            name: 'SyslogMessage_s'
            type: 'string'
          }
          {
            name: 'suppression_start_time_d'
            type: 'string'
          }
          {
            name: 'suppression_key_s'
            type: 'string'
          }
          {
            name: 'suppression_end_time_d'
            type: 'string'
          }
          {
            name: 'supporting_data_data_values_d'
            type: 'string'
          }
          {
            name: 'supporting_data_data_type_s'
            type: 'string'
          }
          {
            name: 'Sub_s'
            type: 'string'
          }
          {
            name: 'start_time_t'
            type: 'string'
          }
          {
            name: 'ssl_decrypt_policy_s'
            type: 'string'
          }
          {
            name: 'srcport_d'
            type: 'string'
          }
          {
            name: 'srcip_s'
            type: 'string'
          }
          {
            name: 'src_zipcode_s'
            type: 'string'
          }
          {
            name: 'src_timezone_s'
            type: 'string'
          }
          {
            name: 'src_region_s'
            type: 'string'
          }
          {
            name: 'malware_severity_s'
            type: 'string'
          }
          {
            name: 'malware_profile_s'
            type: 'string'
          }
          {
            name: 'malware_name_s'
            type: 'string'
          }
          {
            name: 'conn_starttime_d'
            type: 'string'
          }
          {
            name: 'conn_endtime_d'
            type: 'string'
          }
          {
            name: 'conn_duration_d'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'compliance_standards_s'
            type: 'string'
          }
          {
            name: 'collaborated_s'
            type: 'string'
          }
          {
            name: 'client_packets_d'
            type: 'string'
          }
          {
            name: 'client_bytes_d'
            type: 'string'
          }
          {
            name: 'channel_id_s'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'bypass_traffic_s'
            type: 'string'
          }
          {
            name: 'bypass_reason_s'
            type: 'string'
          }
          {
            name: 'browser_version_s'
            type: 'string'
          }
          {
            name: 'browser_sessionid_s'
            type: 'string'
          }
          {
            name: 'browser_session_id_d'
            type: 'string'
          }
          {
            name: 'browser_s'
            type: 'string'
          }
          {
            name: 'breach_target_references_s'
            type: 'string'
          }
          {
            name: 'connection_id_d'
            type: 'string'
          }
          {
            name: 'breach_score_d'
            type: 'string'
          }
          {
            name: 'connectionid_s'
            type: 'string'
          }
          {
            name: 'createdTime_s'
            type: 'string'
          }
          {
            name: 'dlp_rule_s'
            type: 'string'
          }
          {
            name: 'dlp_rule_count_d'
            type: 'string'
          }
          {
            name: 'dlp_profile_s'
            type: 'string'
          }
          {
            name: 'dlp_parent_id_d'
            type: 'string'
          }
          {
            name: 'dlp_mail_parent_id_s'
            type: 'string'
          }
          {
            name: 'dlp_is_unique_count_s'
            type: 'string'
          }
          {
            name: 'dlp_incidentid_s'
            type: 'string'
          }
          {
            name: 'dlp_incident_id_d'
            type: 'string'
          }
          {
            name: 'dlp_file_s'
            type: 'string'
          }
          {
            name: 'deviceClassification_s'
            type: 'string'
          }
          {
            name: 'device_s'
            type: 'string'
          }
          {
            name: 'device_classification_s'
            type: 'string'
          }
          {
            name: 'detection_type_s'
            type: 'string'
          }
          {
            name: 'detection_engine_s'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'data_type_s'
            type: 'string'
          }
          {
            name: 'data_center_s'
            type: 'string'
          }
          {
            name: 'count_d'
            type: 'string'
          }
          {
            name: 'dlp_rule_severity_s'
            type: 'string'
          }
          {
            name: 'breach_media_references_s'
            type: 'string'
          }
          {
            name: 'breach_description_s'
            type: 'string'
          }
          {
            name: 'anomalyData_histo_s'
            type: 'string'
          }
          {
            name: 'anomalyData_featureValue_s'
            type: 'string'
          }
          {
            name: 'anomalyData_convergenceFactor_d'
            type: 'string'
          }
          {
            name: 'anomalyData_binCount_d'
            type: 'string'
          }
          {
            name: 'anomaly_type_s'
            type: 'string'
          }
          {
            name: 'all_policy_matches_s'
            type: 'string'
          }
          {
            name: 'alert_type_s'
            type: 'string'
          }
          {
            name: 'alert_s'
            type: 'string'
          }
          {
            name: 'alert_name_s'
            type: 'string'
          }
          {
            name: 'alert_id_g'
            type: 'string'
          }
          {
            name: 'activity_type_s'
            type: 'string'
          }
          {
            name: 'activity_status_s'
            type: 'string'
          }
          {
            name: 'activity_s'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'act_user_s'
            type: 'string'
          }
          {
            name: 'account_name_s'
            type: 'string'
          }
          {
            name: 'account_id_s'
            type: 'string'
          }
          {
            name: 'anomalyData_modelId_s'
            type: 'string'
          }
          {
            name: 'breach_id_g'
            type: 'string'
          }
          {
            name: 'anomalyData_observationCount_d'
            type: 'string'
          }
          {
            name: 'anomalyData_probability_d'
            type: 'string'
          }
          {
            name: 'breach_date_d'
            type: 'string'
          }
          {
            name: 'audit_log_event_s'
            type: 'string'
          }
          {
            name: 'audit_category_s'
            type: 'string'
          }
          {
            name: 'asset_object_id_s'
            type: 'string'
          }
          {
            name: 'asset_id_s'
            type: 'string'
          }
          {
            name: 'appsuite_s'
            type: 'string'
          }
          {
            name: 'appcategory_s'
            type: 'string'
          }
          {
            name: 'app_sessionid_s'
            type: 'string'
          }
          {
            name: 'app_session_id_d'
            type: 'string'
          }
          {
            name: 'app_s'
            type: 'string'
          }
          {
            name: 'app_name_s'
            type: 'string'
          }
          {
            name: 'app_category_s'
            type: 'string'
          }
          {
            name: 'app_activity_s'
            type: 'string'
          }
          {
            name: 'api_command_s'
            type: 'string'
          }
          {
            name: 'anomalyData_scope_s'
            type: 'string'
          }
          {
            name: 'anomalyData_sampleCount_d'
            type: 'string'
          }
          {
            name: 'anomalyData_pValue_d'
            type: 'string'
          }
          {
            name: 'anomalyData_percentileThresholdCount_d'
            type: 'string'
          }
          {
            name: 'SrcUserName'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'dst_country_s'
            type: 'string'
          }
          {
            name: 'last_device_s'
            type: 'string'
          }
          {
            name: 'last_country_s'
            type: 'string'
          }
          {
            name: 'last_app_s'
            type: 'string'
          }
          {
            name: 'justification_type_s'
            type: 'string'
          }
          {
            name: 'justification_reason_s'
            type: 'string'
          }
          {
            name: 'ip_protocol_s'
            type: 'string'
          }
          {
            name: 'internal_collaborator_count_d'
            type: 'string'
          }
          {
            name: 'instance_type_s'
            type: 'string'
          }
          {
            name: 'instance_s'
            type: 'string'
          }
          {
            name: 'instance_id_s'
            type: 'string'
          }
          {
            name: 'incident_id_d'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'iaas_remediated_s'
            type: 'string'
          }
          {
            name: 'iaas_asset_tags_s'
            type: 'string'
          }
          {
            name: 'http_transaction_count_d'
            type: 'string'
          }
          {
            name: 'http_method_s'
            type: 'string'
          }
          {
            name: 'HostName_s'
            type: 'string'
          }
          {
            name: 'last_location_s'
            type: 'string'
          }
          {
            name: 'HostIP_s'
            type: 'string'
          }
          {
            name: 'last_region_s'
            type: 'string'
          }
          {
            name: 'logintype_s'
            type: 'string'
          }
          {
            name: 'malware_id_g'
            type: 'string'
          }
          {
            name: 'malsite_reputation_s'
            type: 'string'
          }
          {
            name: 'malsite_region_s'
            type: 'string'
          }
          {
            name: 'malsite_longitude_d'
            type: 'string'
          }
          {
            name: 'malsite_latitude_d'
            type: 'string'
          }
          {
            name: 'malsite_last_seen_d'
            type: 'string'
          }
          {
            name: 'malsite_ip_host_s'
            type: 'string'
          }
          {
            name: 'malsite_id_s'
            type: 'string'
          }
          {
            name: 'malsite_hostility_s'
            type: 'string'
          }
          {
            name: 'malsite_first_seen_d'
            type: 'string'
          }
          {
            name: 'malsite_country_s'
            type: 'string'
          }
          {
            name: 'malsite_consecutive_s'
            type: 'string'
          }
          {
            name: 'malsite_confidence_d'
            type: 'string'
          }
          {
            name: 'malsite_category_s'
            type: 'string'
          }
          {
            name: 'malsite_active_s'
            type: 'string'
          }
          {
            name: 'malicious_s'
            type: 'string'
          }
          {
            name: 'loginurl_s'
            type: 'string'
          }
          {
            name: 'last_timestamp_d'
            type: 'string'
          }
          {
            name: 'download_app_s'
            type: 'string'
          }
          {
            name: 'home_pop_s'
            type: 'string'
          }
          {
            name: 'gid_d'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'end_time_t'
            type: 'string'
          }
          {
            name: 'encrypt_failure_s'
            type: 'string'
          }
          {
            name: 'email_source_s'
            type: 'string'
          }
          {
            name: 'dynamic_classification_s'
            type: 'string'
          }
          {
            name: 'dstport_d'
            type: 'string'
          }
          {
            name: 'dstip_s'
            type: 'string'
          }
          {
            name: 'dsthost_s'
            type: 'string'
          }
          {
            name: 'dst_zipcode_s'
            type: 'string'
          }
          {
            name: 'dst_timezone_s'
            type: 'string'
          }
          {
            name: 'dst_region_s'
            type: 'string'
          }
          {
            name: 'dst_longitude_s'
            type: 'string'
          }
          {
            name: 'dst_longitude_d'
            type: 'string'
          }
          {
            name: 'dst_location_s'
            type: 'string'
          }
          {
            name: 'dst_latitude_s'
            type: 'string'
          }
          {
            name: 'dst_latitude_d'
            type: 'string'
          }
          {
            name: 'dst_geoip_src_d'
            type: 'string'
          }
          {
            name: 'EventTime_s'
            type: 'string'
          }
          {
            name: 'hold_until_proven_b'
            type: 'string'
          }
          {
            name: 'exposure_s'
            type: 'string'
          }
          {
            name: 'external_email_d'
            type: 'string'
          }
          {
            name: 'from_user_s'
            type: 'string'
          }
          {
            name: 'from_user_category_s'
            type: 'string'
          }
          {
            name: 'from_storage_s'
            type: 'string'
          }
          {
            name: 'from_object_s'
            type: 'string'
          }
          {
            name: 'forward_to_proxy_xau_s'
            type: 'string'
          }
          {
            name: 'flow_status_s'
            type: 'string'
          }
          {
            name: 'filename_s'
            type: 'string'
          }
          {
            name: 'file_type_s'
            type: 'string'
          }
          {
            name: 'file_size_d'
            type: 'string'
          }
          {
            name: 'file_path_s'
            type: 'string'
          }
          {
            name: 'file_password_protected_s'
            type: 'string'
          }
          {
            name: 'file_lang_s'
            type: 'string'
          }
          {
            name: 'file_id_g'
            type: 'string'
          }
          {
            name: 'file_category_s'
            type: 'string'
          }
          {
            name: 'fastscan_results_s'
            type: 'string'
          }
          {
            name: 'fastscan_req_id_d'
            type: 'string'
          }
          {
            name: 'Facility_s'
            type: 'string'
          }
          {
            name: 'external_collaborator_count_d'
            type: 'string'
          }
          {
            name: 'AlertName'
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
          name: 'Sentinel-Netskope_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Netskope_CL']
        destinations: ['Sentinel-Netskope_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), access_method_s = tostring(access_method_s), RawData = tostring(RawData), quarantine_profile_s = tostring(quarantine_profile_s), quarantine_profile_id_s = tostring(quarantine_profile_id_s), quarantine_file_name_s = tostring(quarantine_file_name_s), quarantine_file_id_s = tostring(quarantine_file_id_s), q_original_version_s = tostring(q_original_version_s), q_original_shared_s = tostring(q_original_shared_s), referer_s = tostring(referer_s), q_original_filepath_s = tostring(q_original_filepath_s), q_instance_s = tostring(q_instance_s), q_app_s = tostring(q_app_s), q_admin_s = tostring(q_admin_s), protocol_s = tostring(protocol_s), profile_id_s = tostring(profile_id_s), profile_emails_s = tostring(profile_emails_s), ProcessName_s = tostring(ProcessName_s), q_original_filename_s = tostring(q_original_filename_s), region_id_s = tostring(region_id_s), region_name_s = tostring(region_name_s), request_id_d = toreal(request_id_d), scanner_result_s = tostring(scanner_result_s), scan_type_s = tostring(scan_type_s), scan_time_d = toreal(scan_time_d), sanctioned_instance_s = tostring(sanctioned_instance_s), sa_rule_severity_s = tostring(sa_rule_severity_s), sa_rule_remediation_s = tostring(sa_rule_remediation_s), sa_rule_name_s = tostring(sa_rule_name_s), sa_rule_id_s = tostring(sa_rule_id_s), sa_profile_name_s = tostring(sa_profile_name_s), sa_profile_id_d = toreal(sa_profile_id_d), role_s = tostring(role_s), retro_scan_name_s = tostring(retro_scan_name_s), resp_content_type_s = tostring(resp_content_type_s), resp_content_len_d = toreal(resp_content_len_d), resp_cnt_d = toreal(resp_cnt_d), resource_category_s = tostring(resource_category_s), requestid_s = tostring(requestid_s), ProcessID_s = tostring(ProcessID_s), pop_id_s = tostring(pop_id_s), policy_s = tostring(policy_s), policy_name_s = tostring(policy_name_s), nsdeviceuid_g = tostring(nsdeviceuid_g), notify_template_s = tostring(notify_template_s), netskope_pop_s = tostring(netskope_pop_s), netskope_activity_s = tostring(netskope_activity_s), modified_date_d = toreal(modified_date_d), modified_d = toreal(modified_d), ml_detection_s = tostring(ml_detection_s), mime_type_s = tostring(mime_type_s), MG = tostring(MG), metadata_service_s = tostring(metadata_service_s), metadata_policy_s = tostring(metadata_policy_s), metadata_attack_severity_s = tostring(metadata_attack_severity_s), Message = tostring(Message), matched_username_s = tostring(matched_username_s), managementID_s = tostring(managementID_s), ManagementGroupName = tostring(ManagementGroupName), managed_app_s = tostring(managed_app_s), numbytes_d = toreal(numbytes_d), score_d = toreal(score_d), object_count_d = toreal(object_count_d), object_s = tostring(object_s), policy_id_s = tostring(policy_id_s), policy_actions_s = tostring(policy_actions_s), path_id_s = tostring(path_id_s), password_type_s = tostring(password_type_s), parent_id_s = tostring(parent_id_s), page_site_s = tostring(page_site_s), page_s = tostring(page_s), owner_s = tostring(owner_s), outer_doc_type_d = toreal(outer_doc_type_d), other_categories_s = tostring(other_categories_s), os_version_s = tostring(os_version_s), os_s = tostring(os_s), orignal_file_path_s = tostring(orignal_file_path_s), orig_ty_s = tostring(orig_ty_s), organization_unit_s = tostring(organization_unit_s), OpId_s = tostring(OpId_s), object_type_s = tostring(object_type_s), object_id_g = tostring(object_id_g), server_bytes_d = toreal(server_bytes_d), server_packets_d = toreal(server_packets_d), service_identifier_s = tostring(service_identifier_s), tunnel_id_s = tostring(tunnel_id_s), tunnel_id_g = tostring(tunnel_id_g), TSS_scan_s = tostring(TSS_scan_s), tss_mode_s = tostring(tss_mode_s), tss_license_s = tostring(tss_license_s), trust_computer_checked_s = tostring(trust_computer_checked_s), true_type_id_d = toreal(true_type_id_d), true_obj_type_s = tostring(true_obj_type_s), true_obj_category_s = tostring(true_obj_category_s), true_filetype_s = tostring(true_filetype_s), traffic_type_s = tostring(traffic_type_s), total_packets_d = toreal(total_packets_d), total_collaborator_count_d = toreal(total_collaborator_count_d), to_user_s = tostring(to_user_s), to_user_category_s = tostring(to_user_category_s), to_storage_s = tostring(to_storage_s), to_object_s = tostring(to_object_s), tunnel_type_s = tostring(tunnel_type_s), title_s = tostring(title_s), tunnel_up_time_d = toreal(tunnel_up_time_d), ur_normalized_s = tostring(ur_normalized_s), windowId_d = toreal(windowId_d), web_url_s = tostring(web_url_s), web_universal_connector_s = tostring(web_universal_connector_s), violating_user_s = tostring(violating_user_s), UserName_s = tostring(UserName_s), userkey_g = tostring(userkey_g), userip_s = tostring(userip_s), useragent_s = tostring(useragent_s), User_SPACE_Name_s = tostring(User_SPACE_Name_s), User_SPACE_Id_s = tostring(User_SPACE_Id_s), user_s = tostring(user_s), user_role_s = tostring(user_role_s), user_name_s = tostring(user_name_s), user_id_g = tostring(user_id_g), user_generated_s = tostring(user_generated_s), user_category_s = tostring(user_category_s), url_s = tostring(url_s), two_factor_auth_s = tostring(two_factor_auth_s), malware_type_s = tostring(malware_type_s), threshold_time_d = toreal(threshold_time_d), threat_source_id_d = toreal(threat_source_id_d), src_latitude_d = toreal(src_latitude_d), src_geoip_src_d = toreal(src_geoip_src_d), src_country_s = tostring(src_country_s), SourceSystem = tostring(SourceSystem), slc_longitude_d = toreal(slc_longitude_d), slc_latitude_d = toreal(slc_latitude_d), site_s = tostring(site_s), signature_s = tostring(signature_s), signature_id_d = toreal(signature_id_d), shared_with_s = tostring(shared_with_s), shared_type_s = tostring(shared_type_s), shared_domains_s = tostring(shared_domains_s), SeverityLevel_s = tostring(SeverityLevel_s), severity_s = tostring(severity_s), severity_level_d = toreal(severity_level_d), severity_id_d = toreal(severity_id_d), session_duration_d = toreal(session_duration_d), src_location_s = tostring(src_location_s), threshold_d = toreal(threshold_d), src_longitude_d = toreal(src_longitude_d), src_time_s = tostring(src_time_s), threat_match_value_s = tostring(threat_match_value_s), threat_match_field_s = tostring(threat_match_field_s), TenantId = toguid(TenantId), telemetry_app_s = tostring(telemetry_app_s), SyslogMessage_s = tostring(SyslogMessage_s), suppression_start_time_d = toreal(suppression_start_time_d), suppression_key_s = tostring(suppression_key_s), suppression_end_time_d = toreal(suppression_end_time_d), supporting_data_data_values_d = toreal(supporting_data_data_values_d), supporting_data_data_type_s = tostring(supporting_data_data_type_s), Sub_s = tostring(Sub_s), start_time_t = todatetime(start_time_t), ssl_decrypt_policy_s = tostring(ssl_decrypt_policy_s), srcport_d = toreal(srcport_d), srcip_s = tostring(srcip_s), src_zipcode_s = tostring(src_zipcode_s), src_timezone_s = tostring(src_timezone_s), src_region_s = tostring(src_region_s), malware_severity_s = tostring(malware_severity_s), malware_profile_s = tostring(malware_profile_s), malware_name_s = tostring(malware_name_s), conn_starttime_d = toreal(conn_starttime_d), conn_endtime_d = toreal(conn_endtime_d), conn_duration_d = toreal(conn_duration_d), Computer = tostring(Computer), compliance_standards_s = tostring(compliance_standards_s), collaborated_s = tostring(collaborated_s), client_packets_d = toreal(client_packets_d), client_bytes_d = toreal(client_bytes_d), channel_id_s = tostring(channel_id_s), Category = tostring(Category), bypass_traffic_s = tostring(bypass_traffic_s), bypass_reason_s = tostring(bypass_reason_s), browser_version_s = tostring(browser_version_s), browser_sessionid_s = tostring(browser_sessionid_s), browser_session_id_d = toreal(browser_session_id_d), browser_s = tostring(browser_s), breach_target_references_s = tostring(breach_target_references_s), connection_id_d = toreal(connection_id_d), breach_score_d = toreal(breach_score_d), connectionid_s = tostring(connectionid_s), createdTime_s = tostring(createdTime_s), dlp_rule_s = tostring(dlp_rule_s), dlp_rule_count_d = toreal(dlp_rule_count_d), dlp_profile_s = tostring(dlp_profile_s), dlp_parent_id_d = toreal(dlp_parent_id_d), dlp_mail_parent_id_s = tostring(dlp_mail_parent_id_s), dlp_is_unique_count_s = tostring(dlp_is_unique_count_s), dlp_incidentid_s = tostring(dlp_incidentid_s), dlp_incident_id_d = toreal(dlp_incident_id_d), dlp_file_s = tostring(dlp_file_s), deviceClassification_s = tostring(deviceClassification_s), device_s = tostring(device_s), device_classification_s = tostring(device_classification_s), detection_type_s = tostring(detection_type_s), detection_engine_s = tostring(detection_engine_s), details_s = tostring(details_s), data_type_s = tostring(data_type_s), data_center_s = tostring(data_center_s), count_d = toreal(count_d), dlp_rule_severity_s = tostring(dlp_rule_severity_s), breach_media_references_s = tostring(breach_media_references_s), breach_description_s = tostring(breach_description_s), anomalyData_histo_s = tostring(anomalyData_histo_s), anomalyData_featureValue_s = tostring(anomalyData_featureValue_s), anomalyData_convergenceFactor_d = toreal(anomalyData_convergenceFactor_d), anomalyData_binCount_d = toreal(anomalyData_binCount_d), anomaly_type_s = tostring(anomaly_type_s), all_policy_matches_s = tostring(all_policy_matches_s), alert_type_s = tostring(alert_type_s), alert_s = tostring(alert_s), alert_name_s = tostring(alert_name_s), alert_id_g = tostring(alert_id_g), activity_type_s = tostring(activity_type_s), activity_status_s = tostring(activity_status_s), activity_s = tostring(activity_s), action_s = tostring(action_s), act_user_s = tostring(act_user_s), account_name_s = tostring(account_name_s), account_id_s = tostring(account_id_s), anomalyData_modelId_s = tostring(anomalyData_modelId_s), breach_id_g = tostring(breach_id_g), anomalyData_observationCount_d = toreal(anomalyData_observationCount_d), anomalyData_probability_d = toreal(anomalyData_probability_d), breach_date_d = toreal(breach_date_d), audit_log_event_s = tostring(audit_log_event_s), audit_category_s = tostring(audit_category_s), asset_object_id_s = tostring(asset_object_id_s), asset_id_s = tostring(asset_id_s), appsuite_s = tostring(appsuite_s), appcategory_s = tostring(appcategory_s), app_sessionid_s = tostring(app_sessionid_s), app_session_id_d = toreal(app_session_id_d), app_s = tostring(app_s), app_name_s = tostring(app_name_s), app_category_s = tostring(app_category_s), app_activity_s = tostring(app_activity_s), api_command_s = tostring(api_command_s), anomalyData_scope_s = tostring(anomalyData_scope_s), anomalyData_sampleCount_d = toreal(anomalyData_sampleCount_d), anomalyData_pValue_d = toreal(anomalyData_pValue_d), anomalyData_percentileThresholdCount_d = toreal(anomalyData_percentileThresholdCount_d), SrcUserName = tostring(SrcUserName), domain_s = tostring(domain_s), dst_country_s = tostring(dst_country_s), last_device_s = tostring(last_device_s), last_country_s = tostring(last_country_s), last_app_s = tostring(last_app_s), justification_type_s = tostring(justification_type_s), justification_reason_s = tostring(justification_reason_s), ip_protocol_s = tostring(ip_protocol_s), internal_collaborator_count_d = toreal(internal_collaborator_count_d), instance_type_s = tostring(instance_type_s), instance_s = tostring(instance_s), instance_id_s = tostring(instance_id_s), incident_id_d = toreal(incident_id_d), id_d = toreal(id_d), iaas_remediated_s = tostring(iaas_remediated_s), iaas_asset_tags_s = tostring(iaas_asset_tags_s), http_transaction_count_d = toreal(http_transaction_count_d), http_method_s = tostring(http_method_s), HostName_s = tostring(HostName_s), last_location_s = tostring(last_location_s), HostIP_s = tostring(HostIP_s), last_region_s = tostring(last_region_s), logintype_s = tostring(logintype_s), malware_id_g = tostring(malware_id_g), malsite_reputation_s = tostring(malsite_reputation_s), malsite_region_s = tostring(malsite_region_s), malsite_longitude_d = toreal(malsite_longitude_d), malsite_latitude_d = toreal(malsite_latitude_d), malsite_last_seen_d = toreal(malsite_last_seen_d), malsite_ip_host_s = tostring(malsite_ip_host_s), malsite_id_s = tostring(malsite_id_s), malsite_hostility_s = tostring(malsite_hostility_s), malsite_first_seen_d = toreal(malsite_first_seen_d), malsite_country_s = tostring(malsite_country_s), malsite_consecutive_s = tostring(malsite_consecutive_s), malsite_confidence_d = toreal(malsite_confidence_d), malsite_category_s = tostring(malsite_category_s), malsite_active_s = tostring(malsite_active_s), malicious_s = tostring(malicious_s), loginurl_s = tostring(loginurl_s), last_timestamp_d = toreal(last_timestamp_d), download_app_s = tostring(download_app_s), home_pop_s = tostring(home_pop_s), gid_d = toreal(gid_d), event_type_s = tostring(event_type_s), end_time_t = todatetime(end_time_t), encrypt_failure_s = tostring(encrypt_failure_s), email_source_s = tostring(email_source_s), dynamic_classification_s = tostring(dynamic_classification_s), dstport_d = toreal(dstport_d), dstip_s = tostring(dstip_s), dsthost_s = tostring(dsthost_s), dst_zipcode_s = tostring(dst_zipcode_s), dst_timezone_s = tostring(dst_timezone_s), dst_region_s = tostring(dst_region_s), dst_longitude_s = tostring(dst_longitude_s), dst_longitude_d = toreal(dst_longitude_d), dst_location_s = tostring(dst_location_s), dst_latitude_s = tostring(dst_latitude_s), dst_latitude_d = toreal(dst_latitude_d), dst_geoip_src_d = toreal(dst_geoip_src_d), EventTime_s = tostring(EventTime_s), hold_until_proven_b = tobool(hold_until_proven_b), exposure_s = tostring(exposure_s), external_email_d = toreal(external_email_d), from_user_s = tostring(from_user_s), from_user_category_s = tostring(from_user_category_s), from_storage_s = tostring(from_storage_s), from_object_s = tostring(from_object_s), forward_to_proxy_xau_s = tostring(forward_to_proxy_xau_s), flow_status_s = tostring(flow_status_s), filename_s = tostring(filename_s), file_type_s = tostring(file_type_s), file_size_d = toreal(file_size_d), file_path_s = tostring(file_path_s), file_password_protected_s = tostring(file_password_protected_s), file_lang_s = tostring(file_lang_s), file_id_g = tostring(file_id_g), file_category_s = tostring(file_category_s), fastscan_results_s = tostring(fastscan_results_s), fastscan_req_id_d = toreal(fastscan_req_id_d), Facility_s = tostring(Facility_s), external_collaborator_count_d = toreal(external_collaborator_count_d), AlertName = tostring(AlertName)'
        outputStream: 'Custom-Netskope_CL'
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
