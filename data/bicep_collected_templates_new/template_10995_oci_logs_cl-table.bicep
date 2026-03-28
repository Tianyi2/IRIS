// Bicep template for Log Analytics custom table: OCI_Logs_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 267, Deployed columns: 267 (Type column filtered)
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

resource ocilogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'OCI_Logs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'OCI_Logs_CL'
      description: 'Custom table OCI_Logs_CL - imported from JSON schema'
      displayName: 'OCI_Logs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'data_endTime_d'
          type: 'real'
        }
        {
          name: 'data_identity_credentials_s'
          type: 'string'
        }
        {
          name: 'data_identity_principalName_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Accept_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Accept_Encoding_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Accept_Language_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Origin_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Referer_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_OCI_LB_NetworkMetadata_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_Real_IP_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_Real_Port_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_oci_original_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'data_request_headers_oci_skip_authorization_for_splat_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_opc_principal_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_x_date_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_compartmentId_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Access_Control_Allow_Credentials_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Access_Control_Allow_Origin_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Access_Control_Expose_Headers_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_limit_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_oci_splat_audited_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_oci_splat_internal_context_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_sortBy_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_sortOrder_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_X_Real_Port_d'
          type: 'real'
        }
        {
          name: 'data_freeformTags_VCN_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Authorization_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Sec_Fetch_Dest_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Sec_Fetch_Mode_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Sec_Fetch_Site_s'
          type: 'string'
        }
        {
          name: 'data_identity_consoleSessionId_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_sec_ch_ua_s'
          type: 'string'
        }
        {
          name: 'data_identity_authType_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'data_identity_userAgent_s'
          type: 'string'
        }
        {
          name: 'data_message_s'
          type: 'string'
        }
        {
          name: 'data_request_action_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Connection_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_User_Agent_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_Forwarded_For_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_auth_info_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_opc_request_id_s'
          type: 'string'
        }
        {
          name: 'data_request_id_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_tenancy_s'
          type: 'string'
        }
        {
          name: 'data_request_path_s'
          type: 'string'
        }
        {
          name: 'data_resourceId_s'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'data_response_headers_Content_Length_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Content_Type_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Date_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_ETag_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Vary_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_opc_request_id_s'
          type: 'string'
        }
        {
          name: 'data_response_responseTime_t'
          type: 'dateTime'
        }
        {
          name: 'data_response_status_s'
          type: 'string'
        }
        {
          name: 'dataschema_s'
          type: 'string'
        }
        {
          name: 'id_g'
          type: 'string'
        }
        {
          name: 'oracle_compartmentid_s'
          type: 'string'
        }
        {
          name: 'oracle_ingestedtime_t'
          type: 'dateTime'
        }
        {
          name: 'oracle_loggroupid_s'
          type: 'string'
        }
        {
          name: 'oracle_tenantid_s'
          type: 'string'
        }
        {
          name: 'source_s'
          type: 'string'
        }
        {
          name: 'specversion_s'
          type: 'string'
        }
        {
          name: 'time_t'
          type: 'dateTime'
        }
        {
          name: 'data_eventGroupingId_g'
          type: 'string'
        }
        {
          name: 'data_request_headers_sec_ch_ua_mobile_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Connection_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Timing_Allow_Origin_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Transfer_Encoding_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_accessLevel_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_compartmentIdInSubtree_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_description_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_isAccessable_b'
          type: 'boolean'
        }
        {
          name: 'data_additionalDetails_lifeCycleState_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_homeRegionKey_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_oracleMyServicesIdentifier_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_Forwarded_Host_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_Forwarded_Port_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_Forwarded_Proto_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_Oracle_Auth_Client_CN_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_isBanner_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_granularity_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_protocol_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_userId_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Location_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_fingerprint_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_keyId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_keyValue_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_lifecycleState_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_timeCreated_t'
          type: 'dateTime'
        }
        {
          name: 'data_stateChange_current_userId_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_userId_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_X_OCI_LB_PrivateAccessMetadata_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_date_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_LoadBalancers_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_fields_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_availabilityDomain_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Pragma_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Cache_Control_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_param0_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_namespace_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_X_Content_Type_Options_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Content_Length_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Content_Type_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_x_content_sha256_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_If_None_Match_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Content_Encoding_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_includeSubcompartments_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_opc_limit_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Date_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_opc_client_info_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_endTime_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_startTime_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_opc_next_page_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_opc_prev_page_s'
          type: 'string'
        }
        {
          name: 'data_identity_tenantId_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_id_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_name_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_page_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_streamPoolId_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_opc_previous_page_s'
          type: 'string'
        }
        {
          name: 'data_response_payload_id_s'
          type: 'string'
        }
        {
          name: 'data_response_payload_resourceName_s'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'data_request_headers_accept_language_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_authorization_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_access_control_allow_credentials_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_access_control_allow_methods_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_access_control_allow_origin_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_access_control_expose_headers_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_date_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_x_api_id_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_lifecycleState_s'
          type: 'string'
        }
        {
          name: 'data_identity_principalId_s'
          type: 'string'
        }
        {
          name: 'data_identity_ipAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'data_eventName_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_agentConfig_isMonitoringDisabled_b'
          type: 'boolean'
        }
        {
          name: 'data_stateChange_current_agentConfig_pluginsConfig_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_availabilityConfig_recoveryAction_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_availabilityDomain_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_faultDomain_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_imageId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_instanceOptions_areLegacyImdsEndpointsDisabled_b'
          type: 'boolean'
        }
        {
          name: 'data_stateChange_current_launchMode_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_launchOptions_bootVolumeType_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_launchOptions_firmware_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_launchOptions_isConsistentVolumeNamingEnabled_b'
          type: 'boolean'
        }
        {
          name: 'data_stateChange_current_launchOptions_isPvEncryptionInTransitEnabled_b'
          type: 'boolean'
        }
        {
          name: 'data_stateChange_current_launchOptions_networkType_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_launchOptions_remoteDataVolumeType_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_metadata_ssh_authorized_keys_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_region_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_shape_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_shapeConfig_gpus_d'
          type: 'real'
        }
        {
          name: 'data_stateChange_current_shapeConfig_localDisks_d'
          type: 'real'
        }
        {
          name: 'data_stateChange_current_shapeConfig_maxVnicAttachments_d'
          type: 'real'
        }
        {
          name: 'data_stateChange_current_shapeConfig_memoryInGBs_d'
          type: 'real'
        }
        {
          name: 'data_stateChange_current_shapeConfig_networkingBandwidthInGbps_d'
          type: 'real'
        }
        {
          name: 'data_stateChange_current_shapeConfig_ocpus_d'
          type: 'real'
        }
        {
          name: 'data_stateChange_current_shapeConfig_processorDescription_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_sourceDetails_imageId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_sourceDetails_sourceType_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_systemTags_orcl_cloud_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_instanceId_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_opc_retry_token_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_agentConfig_isManagementDisabled_b'
          type: 'boolean'
        }
        {
          name: 'data_stateChange_current_agentConfig_areAllPluginsDisabled_b'
          type: 'boolean'
        }
        {
          name: 'data_additionalDetails_volumeId_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_type_s'
          type: 'string'
        }
        {
          name: 'data_flowid_s'
          type: 'string'
        }
        {
          name: 'data_startTime_d'
          type: 'real'
        }
        {
          name: 'data_status_s'
          type: 'string'
        }
        {
          name: 'data_version_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'oracle_logid_s'
          type: 'string'
        }
        {
          name: 'oracle_vniccompartmentocid_s'
          type: 'string'
        }
        {
          name: 'oracle_vnicocid_s'
          type: 'string'
        }
        {
          name: 'oracle_vnicsubnetocid_s'
          type: 'string'
        }
        {
          name: 'data_action_s'
          type: 'string'
        }
        {
          name: 'data_bytesOut_d'
          type: 'real'
        }
        {
          name: 'data_destinationAddress_s'
          type: 'string'
        }
        {
          name: 'data_destinationPort_d'
          type: 'real'
        }
        {
          name: 'data_packets_d'
          type: 'real'
        }
        {
          name: 'data_additionalDetails_isFreeTier_b'
          type: 'boolean'
        }
        {
          name: 'data_protocol_d'
          type: 'real'
        }
        {
          name: 'data_sourceAddress_s'
          type: 'string'
        }
        {
          name: 'data_sourcePort_d'
          type: 'real'
        }
        {
          name: 'data_request_parameters_serviceName_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_vcnId_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_imageId_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_operatingSystem_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_operatingSystemVersion_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_shape_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_isMergeEnabled_s'
          type: 'string'
        }
        {
          name: 'data_identity_callerId_s'
          type: 'string'
        }
        {
          name: 'data_identity_callerName_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_opc_obo_token_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_imageId_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_shape_s'
          type: 'string'
        }
        {
          name: 'data_protocolName_s'
          type: 'string'
        }
        {
          name: 'data_request_parameters_subnetId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_agentConfig_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_availabilityDomain_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_lifecycleDetails_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_lifecyleDetails_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_tenancyId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_timeUpdated_t'
          type: 'dateTime'
        }
        {
          name: 'data_stateChange_current_userDisplayName_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_userName_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_oci_splat_generated_ocids_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_opc_work_request_id_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_configuration_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_definedTags_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_freeformTags_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_isEnabled_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_logGroupId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_logType_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_retentionDuration_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_timeCreated_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_timeLastModified_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Cache_Control_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Cookie_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Sec_Fetch_User_s'
          type: 'string'
        }
        {
          name: 'data_request_headers_Upgrade_Insecure_Requests_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_X_FRAME_OPTIONS_s'
          type: 'string'
        }
        {
          name: 'data_additionalDetails_id_s'
          type: 'string'
        }
        {
          name: 'data_availabilityDomain_s'
          type: 'string'
        }
        {
          name: 'data_compartmentId_s'
          type: 'string'
        }
        {
          name: 'data_compartmentName_s'
          type: 'string'
        }
        {
          name: 'data_definedTags_Oracle_Tags_CreatedBy_s'
          type: 'string'
        }
        {
          name: 'data_definedTags_Oracle_Tags_CreatedOn_t'
          type: 'dateTime'
        }
        {
          name: 'data_eventGroupingId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_instanceId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_id_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_displayName_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_definedTags_Oracle_Tags_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_compartmentId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_definedTags_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_displayName_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_extendedMetadata_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_faultDomain_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_freeformTags_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_id_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_imageId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_instanceOptions_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_launchMode_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_launchOptions_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_lifecycleState_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_metadata_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_region_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_availabilityConfig_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_shape_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_sourceDetails_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_systemTags_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_timeCreated_t'
          type: 'dateTime'
        }
        {
          name: 'data_stateChange_current_subnetIds_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_syslogUrl_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'data_stateChange_current_traceConfig_domainId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_traceConfig_isEnabled_b'
          type: 'boolean'
        }
        {
          name: 'data_response_headers_Content_Security_Policy_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'data_response_headers_Etag_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Opc_Request_Id_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_Strict_Transport_Security_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'data_response_headers_X_Frame_Options_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_X_Xss_Protection_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_compartmentId_s'
          type: 'string'
        }
        {
          name: 'data_stateChange_current_Instance_shapeConfig_s'
          type: 'string'
        }
        {
          name: 'data_response_headers_oci_splat_authorization_verify_content_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ocilogsclTable.name
output tableId string = ocilogsclTable.id
output provisioningState string = ocilogsclTable.properties.provisioningState
