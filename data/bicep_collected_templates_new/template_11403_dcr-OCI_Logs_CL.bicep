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
// Data Collection Rule for OCI_Logs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:27
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 267, DCR columns: 267 (Type column always filtered)
// Output stream: Custom-OCI_Logs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-OCI_Logs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-OCI_Logs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'data_endTime_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
          }
          {
            name: 'data_eventName_s'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_agentConfig_isMonitoringDisabled_b'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'data_stateChange_current_launchOptions_isPvEncryptionInTransitEnabled_b'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'data_stateChange_current_shapeConfig_localDisks_d'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_shapeConfig_maxVnicAttachments_d'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_shapeConfig_memoryInGBs_d'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_shapeConfig_networkingBandwidthInGbps_d'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_shapeConfig_ocpus_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'data_stateChange_current_agentConfig_areAllPluginsDisabled_b'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'data_destinationAddress_s'
            type: 'string'
          }
          {
            name: 'data_destinationPort_d'
            type: 'string'
          }
          {
            name: 'data_packets_d'
            type: 'string'
          }
          {
            name: 'data_additionalDetails_isFreeTier_b'
            type: 'string'
          }
          {
            name: 'data_protocol_d'
            type: 'string'
          }
          {
            name: 'data_sourceAddress_s'
            type: 'string'
          }
          {
            name: 'data_sourcePort_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'data_stateChange_current_subnetIds_s'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_syslogUrl_s'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_traceConfig_domainId_s'
            type: 'string'
          }
          {
            name: 'data_stateChange_current_traceConfig_isEnabled_b'
            type: 'string'
          }
          {
            name: 'data_response_headers_Content_Security_Policy_s'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-OCI_Logs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-OCI_Logs_CL']
        destinations: ['Sentinel-OCI_Logs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), data_endTime_d = toreal(data_endTime_d), data_identity_credentials_s = tostring(data_identity_credentials_s), data_identity_principalName_s = tostring(data_identity_principalName_s), data_request_headers_Accept_s = tostring(data_request_headers_Accept_s), data_request_headers_Accept_Encoding_s = tostring(data_request_headers_Accept_Encoding_s), data_request_headers_Accept_Language_s = tostring(data_request_headers_Accept_Language_s), data_request_headers_Origin_s = tostring(data_request_headers_Origin_s), data_request_headers_Referer_s = tostring(data_request_headers_Referer_s), data_request_headers_X_OCI_LB_NetworkMetadata_s = tostring(data_request_headers_X_OCI_LB_NetworkMetadata_s), data_request_headers_X_Real_IP_s = tostring(data_request_headers_X_Real_IP_s), data_request_headers_X_Real_Port_s = tostring(data_request_headers_X_Real_Port_s), data_request_headers_oci_original_url_s = tostring(data_request_headers_oci_original_url_s), data_request_headers_oci_skip_authorization_for_splat_s = tostring(data_request_headers_oci_skip_authorization_for_splat_s), data_request_headers_opc_principal_s = tostring(data_request_headers_opc_principal_s), data_request_headers_x_date_s = tostring(data_request_headers_x_date_s), data_request_parameters_compartmentId_s = tostring(data_request_parameters_compartmentId_s), data_response_headers_Access_Control_Allow_Credentials_s = tostring(data_response_headers_Access_Control_Allow_Credentials_s), data_response_headers_Access_Control_Allow_Origin_s = tostring(data_response_headers_Access_Control_Allow_Origin_s), data_response_headers_Access_Control_Expose_Headers_s = tostring(data_response_headers_Access_Control_Expose_Headers_s), data_request_parameters_limit_s = tostring(data_request_parameters_limit_s), data_request_headers_oci_splat_audited_s = tostring(data_request_headers_oci_splat_audited_s), data_request_headers_oci_splat_internal_context_s = tostring(data_request_headers_oci_splat_internal_context_s), data_request_parameters_sortBy_s = tostring(data_request_parameters_sortBy_s), data_request_parameters_sortOrder_s = tostring(data_request_parameters_sortOrder_s), data_additionalDetails_X_Real_Port_d = toreal(data_additionalDetails_X_Real_Port_d), data_freeformTags_VCN_s = tostring(data_freeformTags_VCN_s), data_request_headers_Authorization_s = tostring(data_request_headers_Authorization_s), data_request_headers_Sec_Fetch_Dest_s = tostring(data_request_headers_Sec_Fetch_Dest_s), data_request_headers_Sec_Fetch_Mode_s = tostring(data_request_headers_Sec_Fetch_Mode_s), data_request_headers_Sec_Fetch_Site_s = tostring(data_request_headers_Sec_Fetch_Site_s), data_identity_consoleSessionId_s = tostring(data_identity_consoleSessionId_s), data_request_headers_sec_ch_ua_s = tostring(data_request_headers_sec_ch_ua_s), data_identity_authType_s = tostring(data_identity_authType_s), type_s = tostring(type_s), data_identity_userAgent_s = tostring(data_identity_userAgent_s), data_message_s = tostring(data_message_s), data_request_action_s = tostring(data_request_action_s), data_request_headers_Connection_s = tostring(data_request_headers_Connection_s), data_request_headers_User_Agent_s = tostring(data_request_headers_User_Agent_s), data_request_headers_X_Forwarded_For_s = tostring(data_request_headers_X_Forwarded_For_s), data_request_headers_auth_info_s = tostring(data_request_headers_auth_info_s), data_request_headers_opc_request_id_s = tostring(data_request_headers_opc_request_id_s), data_request_id_s = tostring(data_request_id_s), data_request_parameters_tenancy_s = tostring(data_request_parameters_tenancy_s), data_request_path_s = tostring(data_request_path_s), data_resourceId_s = tostring(data_resourceId_s), data_response_headers_Content_Length_s = tostring(data_response_headers_Content_Length_s), data_response_headers_Content_Type_s = tostring(data_response_headers_Content_Type_s), data_response_headers_Date_s = tostring(data_response_headers_Date_s), data_response_headers_ETag_s = tostring(data_response_headers_ETag_s), data_response_headers_Vary_s = tostring(data_response_headers_Vary_s), data_response_headers_opc_request_id_s = tostring(data_response_headers_opc_request_id_s), data_response_responseTime_t = todatetime(data_response_responseTime_t), data_response_status_s = tostring(data_response_status_s), dataschema_s = tostring(dataschema_s), id_g = tostring(id_g), oracle_compartmentid_s = tostring(oracle_compartmentid_s), oracle_ingestedtime_t = todatetime(oracle_ingestedtime_t), oracle_loggroupid_s = tostring(oracle_loggroupid_s), oracle_tenantid_s = tostring(oracle_tenantid_s), source_s = tostring(source_s), specversion_s = tostring(specversion_s), time_t = todatetime(time_t), data_eventGroupingId_g = tostring(data_eventGroupingId_g), data_request_headers_sec_ch_ua_mobile_s = tostring(data_request_headers_sec_ch_ua_mobile_s), data_response_headers_Connection_s = tostring(data_response_headers_Connection_s), data_response_headers_Timing_Allow_Origin_s = tostring(data_response_headers_Timing_Allow_Origin_s), data_response_headers_Transfer_Encoding_s = tostring(data_response_headers_Transfer_Encoding_s), data_request_parameters_accessLevel_s = tostring(data_request_parameters_accessLevel_s), data_request_parameters_compartmentIdInSubtree_s = tostring(data_request_parameters_compartmentIdInSubtree_s), data_additionalDetails_description_s = tostring(data_additionalDetails_description_s), data_additionalDetails_isAccessable_b = tobool(data_additionalDetails_isAccessable_b), data_additionalDetails_lifeCycleState_s = tostring(data_additionalDetails_lifeCycleState_s), data_additionalDetails_homeRegionKey_s = tostring(data_additionalDetails_homeRegionKey_s), data_additionalDetails_oracleMyServicesIdentifier_s = tostring(data_additionalDetails_oracleMyServicesIdentifier_s), data_request_headers_X_Forwarded_Host_s = tostring(data_request_headers_X_Forwarded_Host_s), data_request_headers_X_Forwarded_Port_s = tostring(data_request_headers_X_Forwarded_Port_s), data_request_headers_X_Forwarded_Proto_s = tostring(data_request_headers_X_Forwarded_Proto_s), data_request_headers_X_Oracle_Auth_Client_CN_s = tostring(data_request_headers_X_Oracle_Auth_Client_CN_s), data_request_parameters_isBanner_s = tostring(data_request_parameters_isBanner_s), data_request_parameters_granularity_s = tostring(data_request_parameters_granularity_s), data_request_parameters_protocol_s = tostring(data_request_parameters_protocol_s), data_additionalDetails_userId_s = tostring(data_additionalDetails_userId_s), data_response_headers_Location_s = tostring(data_response_headers_Location_s), data_stateChange_current_fingerprint_s = tostring(data_stateChange_current_fingerprint_s), data_stateChange_current_keyId_s = tostring(data_stateChange_current_keyId_s), data_stateChange_current_keyValue_s = tostring(data_stateChange_current_keyValue_s), data_stateChange_current_lifecycleState_s = tostring(data_stateChange_current_lifecycleState_s), data_stateChange_current_timeCreated_t = todatetime(data_stateChange_current_timeCreated_t), data_stateChange_current_userId_s = tostring(data_stateChange_current_userId_s), data_request_parameters_userId_s = tostring(data_request_parameters_userId_s), data_request_headers_X_OCI_LB_PrivateAccessMetadata_s = tostring(data_request_headers_X_OCI_LB_PrivateAccessMetadata_s), data_request_headers_date_s = tostring(data_request_headers_date_s), data_stateChange_current_LoadBalancers_s = tostring(data_stateChange_current_LoadBalancers_s), data_request_parameters_fields_s = tostring(data_request_parameters_fields_s), data_request_parameters_availabilityDomain_s = tostring(data_request_parameters_availabilityDomain_s), data_response_headers_Pragma_s = tostring(data_response_headers_Pragma_s), data_response_headers_Cache_Control_s = tostring(data_response_headers_Cache_Control_s), data_request_parameters_param0_s = tostring(data_request_parameters_param0_s), data_additionalDetails_namespace_s = tostring(data_additionalDetails_namespace_s), data_response_headers_X_Content_Type_Options_s = tostring(data_response_headers_X_Content_Type_Options_s), data_request_headers_Content_Length_s = tostring(data_request_headers_Content_Length_s), data_request_headers_Content_Type_s = tostring(data_request_headers_Content_Type_s), data_request_headers_x_content_sha256_s = tostring(data_request_headers_x_content_sha256_s), data_request_headers_If_None_Match_s = tostring(data_request_headers_If_None_Match_s), data_response_headers_Content_Encoding_s = tostring(data_response_headers_Content_Encoding_s), data_request_parameters_includeSubcompartments_s = tostring(data_request_parameters_includeSubcompartments_s), data_response_headers_opc_limit_s = tostring(data_response_headers_opc_limit_s), data_request_headers_Date_s = tostring(data_request_headers_Date_s), data_request_headers_opc_client_info_s = tostring(data_request_headers_opc_client_info_s), data_request_parameters_endTime_s = tostring(data_request_parameters_endTime_s), data_request_parameters_startTime_s = tostring(data_request_parameters_startTime_s), data_response_headers_opc_next_page_s = tostring(data_response_headers_opc_next_page_s), data_response_headers_opc_prev_page_s = tostring(data_response_headers_opc_prev_page_s), data_identity_tenantId_s = tostring(data_identity_tenantId_s), data_request_parameters_id_s = tostring(data_request_parameters_id_s), data_request_parameters_name_s = tostring(data_request_parameters_name_s), data_request_parameters_page_s = tostring(data_request_parameters_page_s), data_request_parameters_streamPoolId_s = tostring(data_request_parameters_streamPoolId_s), data_response_headers_opc_previous_page_s = tostring(data_response_headers_opc_previous_page_s), data_response_payload_id_s = tostring(data_response_payload_id_s), data_response_payload_resourceName_s = tostring(data_response_payload_resourceName_s), data_request_headers_accept_language_s = tostring(data_request_headers_accept_language_s), data_request_headers_authorization_s = tostring(data_request_headers_authorization_s), data_response_headers_access_control_allow_credentials_s = tostring(data_response_headers_access_control_allow_credentials_s), data_response_headers_access_control_allow_methods_s = tostring(data_response_headers_access_control_allow_methods_s), data_response_headers_access_control_allow_origin_s = tostring(data_response_headers_access_control_allow_origin_s), data_response_headers_access_control_expose_headers_s = tostring(data_response_headers_access_control_expose_headers_s), data_response_headers_date_s = tostring(data_response_headers_date_s), data_response_headers_x_api_id_s = tostring(data_response_headers_x_api_id_s), data_request_parameters_lifecycleState_s = tostring(data_request_parameters_lifecycleState_s), data_identity_principalId_s = tostring(data_identity_principalId_s), data_identity_ipAddress_s = tostring(data_identity_ipAddress_s), data_eventName_s = tostring(data_eventName_s), data_stateChange_current_agentConfig_isMonitoringDisabled_b = tobool(data_stateChange_current_agentConfig_isMonitoringDisabled_b), data_stateChange_current_agentConfig_pluginsConfig_s = tostring(data_stateChange_current_agentConfig_pluginsConfig_s), data_stateChange_current_availabilityConfig_recoveryAction_s = tostring(data_stateChange_current_availabilityConfig_recoveryAction_s), data_stateChange_current_availabilityDomain_s = tostring(data_stateChange_current_availabilityDomain_s), data_stateChange_current_faultDomain_s = tostring(data_stateChange_current_faultDomain_s), data_stateChange_current_imageId_s = tostring(data_stateChange_current_imageId_s), data_stateChange_current_instanceOptions_areLegacyImdsEndpointsDisabled_b = tobool(data_stateChange_current_instanceOptions_areLegacyImdsEndpointsDisabled_b), data_stateChange_current_launchMode_s = tostring(data_stateChange_current_launchMode_s), data_stateChange_current_launchOptions_bootVolumeType_s = tostring(data_stateChange_current_launchOptions_bootVolumeType_s), data_stateChange_current_launchOptions_firmware_s = tostring(data_stateChange_current_launchOptions_firmware_s), data_stateChange_current_launchOptions_isConsistentVolumeNamingEnabled_b = tobool(data_stateChange_current_launchOptions_isConsistentVolumeNamingEnabled_b), data_stateChange_current_launchOptions_isPvEncryptionInTransitEnabled_b = tobool(data_stateChange_current_launchOptions_isPvEncryptionInTransitEnabled_b), data_stateChange_current_launchOptions_networkType_s = tostring(data_stateChange_current_launchOptions_networkType_s), data_stateChange_current_launchOptions_remoteDataVolumeType_s = tostring(data_stateChange_current_launchOptions_remoteDataVolumeType_s), data_stateChange_current_metadata_ssh_authorized_keys_s = tostring(data_stateChange_current_metadata_ssh_authorized_keys_s), data_stateChange_current_region_s = tostring(data_stateChange_current_region_s), data_stateChange_current_shape_s = tostring(data_stateChange_current_shape_s), data_stateChange_current_shapeConfig_gpus_d = toreal(data_stateChange_current_shapeConfig_gpus_d), data_stateChange_current_shapeConfig_localDisks_d = toreal(data_stateChange_current_shapeConfig_localDisks_d), data_stateChange_current_shapeConfig_maxVnicAttachments_d = toreal(data_stateChange_current_shapeConfig_maxVnicAttachments_d), data_stateChange_current_shapeConfig_memoryInGBs_d = toreal(data_stateChange_current_shapeConfig_memoryInGBs_d), data_stateChange_current_shapeConfig_networkingBandwidthInGbps_d = toreal(data_stateChange_current_shapeConfig_networkingBandwidthInGbps_d), data_stateChange_current_shapeConfig_ocpus_d = toreal(data_stateChange_current_shapeConfig_ocpus_d), data_stateChange_current_shapeConfig_processorDescription_s = tostring(data_stateChange_current_shapeConfig_processorDescription_s), data_stateChange_current_sourceDetails_imageId_s = tostring(data_stateChange_current_sourceDetails_imageId_s), data_stateChange_current_sourceDetails_sourceType_s = tostring(data_stateChange_current_sourceDetails_sourceType_s), data_stateChange_current_systemTags_orcl_cloud_s = tostring(data_stateChange_current_systemTags_orcl_cloud_s), data_request_parameters_instanceId_s = tostring(data_request_parameters_instanceId_s), data_request_headers_opc_retry_token_s = tostring(data_request_headers_opc_retry_token_s), data_stateChange_current_agentConfig_isManagementDisabled_b = tobool(data_stateChange_current_agentConfig_isManagementDisabled_b), data_stateChange_current_agentConfig_areAllPluginsDisabled_b = tobool(data_stateChange_current_agentConfig_areAllPluginsDisabled_b), data_additionalDetails_volumeId_s = tostring(data_additionalDetails_volumeId_s), data_additionalDetails_type_s = tostring(data_additionalDetails_type_s), data_flowid_s = tostring(data_flowid_s), data_startTime_d = toreal(data_startTime_d), data_status_s = tostring(data_status_s), data_version_s = tostring(data_version_s), id_s = tostring(id_s), oracle_logid_s = tostring(oracle_logid_s), oracle_vniccompartmentocid_s = tostring(oracle_vniccompartmentocid_s), oracle_vnicocid_s = tostring(oracle_vnicocid_s), oracle_vnicsubnetocid_s = tostring(oracle_vnicsubnetocid_s), data_action_s = tostring(data_action_s), data_bytesOut_d = toreal(data_bytesOut_d), data_destinationAddress_s = tostring(data_destinationAddress_s), data_destinationPort_d = toreal(data_destinationPort_d), data_packets_d = toreal(data_packets_d), data_additionalDetails_isFreeTier_b = tobool(data_additionalDetails_isFreeTier_b), data_protocol_d = toreal(data_protocol_d), data_sourceAddress_s = tostring(data_sourceAddress_s), data_sourcePort_d = toreal(data_sourcePort_d), data_request_parameters_serviceName_s = tostring(data_request_parameters_serviceName_s), data_request_parameters_vcnId_s = tostring(data_request_parameters_vcnId_s), data_request_parameters_imageId_s = tostring(data_request_parameters_imageId_s), data_request_parameters_operatingSystem_s = tostring(data_request_parameters_operatingSystem_s), data_request_parameters_operatingSystemVersion_s = tostring(data_request_parameters_operatingSystemVersion_s), data_request_parameters_shape_s = tostring(data_request_parameters_shape_s), data_request_parameters_isMergeEnabled_s = tostring(data_request_parameters_isMergeEnabled_s), data_identity_callerId_s = tostring(data_identity_callerId_s), data_identity_callerName_s = tostring(data_identity_callerName_s), data_request_headers_opc_obo_token_s = tostring(data_request_headers_opc_obo_token_s), data_additionalDetails_imageId_s = tostring(data_additionalDetails_imageId_s), data_additionalDetails_shape_s = tostring(data_additionalDetails_shape_s), data_protocolName_s = tostring(data_protocolName_s), data_request_parameters_subnetId_s = tostring(data_request_parameters_subnetId_s), data_stateChange_current_Instance_agentConfig_s = tostring(data_stateChange_current_Instance_agentConfig_s), data_stateChange_current_Instance_availabilityDomain_s = tostring(data_stateChange_current_Instance_availabilityDomain_s), data_stateChange_current_lifecycleDetails_s = tostring(data_stateChange_current_lifecycleDetails_s), data_stateChange_current_lifecyleDetails_s = tostring(data_stateChange_current_lifecyleDetails_s), data_stateChange_current_tenancyId_s = tostring(data_stateChange_current_tenancyId_s), data_stateChange_current_timeUpdated_t = todatetime(data_stateChange_current_timeUpdated_t), data_stateChange_current_userDisplayName_s = tostring(data_stateChange_current_userDisplayName_s), data_stateChange_current_userName_s = tostring(data_stateChange_current_userName_s), data_request_headers_oci_splat_generated_ocids_s = tostring(data_request_headers_oci_splat_generated_ocids_s), data_response_headers_opc_work_request_id_s = tostring(data_response_headers_opc_work_request_id_s), data_stateChange_current_configuration_s = tostring(data_stateChange_current_configuration_s), data_stateChange_current_definedTags_s = tostring(data_stateChange_current_definedTags_s), data_stateChange_current_freeformTags_s = tostring(data_stateChange_current_freeformTags_s), data_stateChange_current_isEnabled_s = tostring(data_stateChange_current_isEnabled_s), data_stateChange_current_logGroupId_s = tostring(data_stateChange_current_logGroupId_s), data_stateChange_current_logType_s = tostring(data_stateChange_current_logType_s), data_stateChange_current_retentionDuration_s = tostring(data_stateChange_current_retentionDuration_s), data_stateChange_current_timeCreated_s = tostring(data_stateChange_current_timeCreated_s), data_stateChange_current_timeLastModified_s = tostring(data_stateChange_current_timeLastModified_s), data_request_headers_Cache_Control_s = tostring(data_request_headers_Cache_Control_s), data_request_headers_Cookie_s = tostring(data_request_headers_Cookie_s), data_request_headers_Sec_Fetch_User_s = tostring(data_request_headers_Sec_Fetch_User_s), data_request_headers_Upgrade_Insecure_Requests_s = tostring(data_request_headers_Upgrade_Insecure_Requests_s), data_response_headers_X_FRAME_OPTIONS_s = tostring(data_response_headers_X_FRAME_OPTIONS_s), data_additionalDetails_id_s = tostring(data_additionalDetails_id_s), data_availabilityDomain_s = tostring(data_availabilityDomain_s), data_compartmentId_s = tostring(data_compartmentId_s), data_compartmentName_s = tostring(data_compartmentName_s), data_definedTags_Oracle_Tags_CreatedBy_s = tostring(data_definedTags_Oracle_Tags_CreatedBy_s), data_definedTags_Oracle_Tags_CreatedOn_t = todatetime(data_definedTags_Oracle_Tags_CreatedOn_t), data_eventGroupingId_s = tostring(data_eventGroupingId_s), data_stateChange_current_instanceId_s = tostring(data_stateChange_current_instanceId_s), data_stateChange_current_id_s = tostring(data_stateChange_current_id_s), data_stateChange_current_displayName_s = tostring(data_stateChange_current_displayName_s), data_stateChange_current_definedTags_Oracle_Tags_s = tostring(data_stateChange_current_definedTags_Oracle_Tags_s), data_stateChange_current_Instance_compartmentId_s = tostring(data_stateChange_current_Instance_compartmentId_s), data_stateChange_current_Instance_definedTags_s = tostring(data_stateChange_current_Instance_definedTags_s), data_stateChange_current_Instance_displayName_s = tostring(data_stateChange_current_Instance_displayName_s), data_stateChange_current_Instance_extendedMetadata_s = tostring(data_stateChange_current_Instance_extendedMetadata_s), data_stateChange_current_Instance_faultDomain_s = tostring(data_stateChange_current_Instance_faultDomain_s), data_stateChange_current_Instance_freeformTags_s = tostring(data_stateChange_current_Instance_freeformTags_s), data_stateChange_current_Instance_id_s = tostring(data_stateChange_current_Instance_id_s), data_stateChange_current_Instance_imageId_s = tostring(data_stateChange_current_Instance_imageId_s), data_stateChange_current_Instance_instanceOptions_s = tostring(data_stateChange_current_Instance_instanceOptions_s), data_stateChange_current_Instance_launchMode_s = tostring(data_stateChange_current_Instance_launchMode_s), data_stateChange_current_Instance_launchOptions_s = tostring(data_stateChange_current_Instance_launchOptions_s), data_stateChange_current_Instance_lifecycleState_s = tostring(data_stateChange_current_Instance_lifecycleState_s), data_stateChange_current_Instance_metadata_s = tostring(data_stateChange_current_Instance_metadata_s), data_stateChange_current_Instance_region_s = tostring(data_stateChange_current_Instance_region_s), data_stateChange_current_Instance_availabilityConfig_s = tostring(data_stateChange_current_Instance_availabilityConfig_s), data_stateChange_current_Instance_shape_s = tostring(data_stateChange_current_Instance_shape_s), data_stateChange_current_Instance_sourceDetails_s = tostring(data_stateChange_current_Instance_sourceDetails_s), data_stateChange_current_Instance_systemTags_s = tostring(data_stateChange_current_Instance_systemTags_s), data_stateChange_current_Instance_timeCreated_t = todatetime(data_stateChange_current_Instance_timeCreated_t), data_stateChange_current_subnetIds_s = tostring(data_stateChange_current_subnetIds_s), data_stateChange_current_syslogUrl_s = tostring(data_stateChange_current_syslogUrl_s), data_stateChange_current_traceConfig_domainId_s = tostring(data_stateChange_current_traceConfig_domainId_s), data_stateChange_current_traceConfig_isEnabled_b = tobool(data_stateChange_current_traceConfig_isEnabled_b), data_response_headers_Content_Security_Policy_s = tostring(data_response_headers_Content_Security_Policy_s), data_response_headers_Etag_s = tostring(data_response_headers_Etag_s), data_response_headers_Opc_Request_Id_s = tostring(data_response_headers_Opc_Request_Id_s), data_response_headers_Strict_Transport_Security_s = tostring(data_response_headers_Strict_Transport_Security_s), data_response_headers_X_Frame_Options_s = tostring(data_response_headers_X_Frame_Options_s), data_response_headers_X_Xss_Protection_s = tostring(data_response_headers_X_Xss_Protection_s), data_stateChange_current_compartmentId_s = tostring(data_stateChange_current_compartmentId_s), data_stateChange_current_Instance_shapeConfig_s = tostring(data_stateChange_current_Instance_shapeConfig_s), data_response_headers_oci_splat_authorization_verify_content_s = tostring(data_response_headers_oci_splat_authorization_verify_content_s)'
        outputStream: 'Custom-OCI_Logs_CL'
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
