// Bicep template for Log Analytics custom table: Netskope_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 339, Deployed columns: 335 (Type column filtered)
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

resource netskopeclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Netskope_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Netskope_CL'
      description: 'Custom table Netskope_CL - imported from JSON schema'
      displayName: 'Netskope_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'resp_cnt_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'modified_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'score_d'
          type: 'real'
        }
        {
          name: 'object_count_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'server_packets_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'total_collaborator_count_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'ur_normalized_s'
          type: 'string'
        }
        {
          name: 'windowId_d'
          type: 'real'
        }
        {
          name: 'web_url_s'
          type: 'string'
          dataTypeHint: 0
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
          dataTypeHint: 0
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
          type: 'real'
        }
        {
          name: 'threat_source_id_d'
          type: 'real'
        }
        {
          name: 'src_latitude_d'
          type: 'real'
        }
        {
          name: 'src_geoip_src_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'slc_latitude_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'severity_id_d'
          type: 'real'
        }
        {
          name: 'session_duration_d'
          type: 'real'
        }
        {
          name: 'src_location_s'
          type: 'string'
        }
        {
          name: 'threshold_d'
          type: 'real'
        }
        {
          name: 'src_longitude_d'
          type: 'real'
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
          type: 'guid'
          dataTypeHint: 1
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
          type: 'real'
        }
        {
          name: 'suppression_key_s'
          type: 'string'
        }
        {
          name: 'suppression_end_time_d'
          type: 'real'
        }
        {
          name: 'supporting_data_data_values_d'
          type: 'real'
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
          type: 'dateTime'
        }
        {
          name: 'ssl_decrypt_policy_s'
          type: 'string'
        }
        {
          name: 'srcport_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'conn_endtime_d'
          type: 'real'
        }
        {
          name: 'conn_duration_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'client_bytes_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'breach_score_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'dlp_profile_s'
          type: 'string'
        }
        {
          name: 'dlp_parent_id_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'anomalyData_binCount_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'anomalyData_probability_d'
          type: 'real'
        }
        {
          name: 'breach_date_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'anomalyData_pValue_d'
          type: 'real'
        }
        {
          name: 'anomalyData_percentileThresholdCount_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'id_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'malsite_latitude_d'
          type: 'real'
        }
        {
          name: 'malsite_last_seen_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          dataTypeHint: 0
        }
        {
          name: 'last_timestamp_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'end_time_t'
          type: 'dateTime'
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
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'dst_geoip_src_d'
          type: 'real'
        }
        {
          name: 'EventTime_s'
          type: 'string'
        }
        {
          name: 'hold_until_proven_b'
          type: 'boolean'
        }
        {
          name: 'exposure_s'
          type: 'string'
        }
        {
          name: 'external_email_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'Facility_s'
          type: 'string'
        }
        {
          name: 'external_collaborator_count_d'
          type: 'real'
        }
        {
          name: 'AlertName'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = netskopeclTable.name
output tableId string = netskopeclTable.id
output provisioningState string = netskopeclTable.properties.provisioningState
