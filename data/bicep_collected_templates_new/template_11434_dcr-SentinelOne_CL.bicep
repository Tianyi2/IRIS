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
// Data Collection Rule for SentinelOne_CL
// ============================================================================
// Generated: 2025-09-19 14:20:31
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 323, DCR columns: 319 (Type column always filtered)
// Output stream: Custom-SentinelOne_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SentinelOne_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SentinelOne_CL': {
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
            name: 'agentDetectionInfo_agentIpV4_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentDomain_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentDetectionState_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_accountName_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_accountId_s'
            type: 'string'
          }
          {
            name: 'threatId_s'
            type: 'string'
          }
          {
            name: 'osFamily_s'
            type: 'string'
          }
          {
            name: 'hash_s'
            type: 'string'
          }
          {
            name: 'agentId_s'
            type: 'string'
          }
          {
            name: 'agentUpdatedVersion_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcessStartTime_t'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcIntegrityLevel_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFilePath_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileModifiedAt_t'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileIsSigned_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentIpV6_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentLastLoggedInUserName_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentMitigationMode_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentOsName_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentInfected_b'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentId_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentDomain_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentComputerName_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_activeThreats_d'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_accountName_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_accountId_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileId_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_siteName_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_groupName_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_groupId_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_externalIp_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentVersion_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentUuid_g'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentRegisteredAt_t'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_agentOsRevision_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_siteId_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileHashSha256_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileHashSha1_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileCreatedAt_t'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_name_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_integrityLevel_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_fileSignerIdentity_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_filePath_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_fileHashSha256_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_fileHashSha1_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_fileHashMd5_g'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_pid_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_commandline_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_severity_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_scopeLevel_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_s1ql_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_queryType_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_queryLang_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_name_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_id_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_treatAsThreat_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentIsActive_b'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_pidStarttime_t'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_subsystem_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_user_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_uniqueId_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_subsystem_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_storyline_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_pidStarttime_t'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_pid_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_name_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_storyline_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_integrityLevel_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_filePath_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_fileHashSha256_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_fileHashSha1_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_fileHashMd5_g'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_commandline_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_user_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_uniqueId_s'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_fileSignerIdentity_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentIsDecommissioned_b'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentMachineType_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentMitigationMode_s'
            type: 'string'
          }
          {
            name: 'threatInfo_sha1_s'
            type: 'string'
          }
          {
            name: 'threatInfo_rebootRequired_b'
            type: 'string'
          }
          {
            name: 'threatInfo_reachedEventsLimit_b'
            type: 'string'
          }
          {
            name: 'threatInfo_publisherName_s'
            type: 'string'
          }
          {
            name: 'threatInfo_processUser_s'
            type: 'string'
          }
          {
            name: 'threatInfo_pendingActions_b'
            type: 'string'
          }
          {
            name: 'threatInfo_originatorProcess_s'
            type: 'string'
          }
          {
            name: 'threatInfo_storyline_s'
            type: 'string'
          }
          {
            name: 'threatInfo_mitigationStatusDescription_s'
            type: 'string'
          }
          {
            name: 'threatInfo_mitigatedPreemptively_b'
            type: 'string'
          }
          {
            name: 'threatInfo_isValidCertificate_b'
            type: 'string'
          }
          {
            name: 'threatInfo_isFileless_b'
            type: 'string'
          }
          {
            name: 'threatInfo_initiatedByDescription_s'
            type: 'string'
          }
          {
            name: 'threatInfo_initiatedBy_s'
            type: 'string'
          }
          {
            name: 'threatInfo_incidentStatusDescription_s'
            type: 'string'
          }
          {
            name: 'threatInfo_incidentStatus_s'
            type: 'string'
          }
          {
            name: 'threatInfo_mitigationStatus_s'
            type: 'string'
          }
          {
            name: 'threatInfo_identifiedAt_t'
            type: 'string'
          }
          {
            name: 'threatInfo_threatId_s'
            type: 'string'
          }
          {
            name: 'threatInfo_updatedAt_t'
            type: 'string'
          }
          {
            name: 'tags_sentinelone_s'
            type: 'string'
          }
          {
            name: 'showAlertIcon_b'
            type: 'string'
          }
          {
            name: 'serialNumber_s'
            type: 'string'
          }
          {
            name: 'fullDiskScanLastUpdatedAt_t'
            type: 'string'
          }
          {
            name: 'firstFullModeTime_t'
            type: 'string'
          }
          {
            name: 'detectionState_s'
            type: 'string'
          }
          {
            name: 'comments_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatName_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'secondaryDescription_s'
            type: 'string'
          }
          {
            name: 'activityUuid_g'
            type: 'string'
          }
          {
            name: 'threatInfo_storyline_g'
            type: 'string'
          }
          {
            name: 'threatInfo_threatName_g'
            type: 'string'
          }
          {
            name: 'threatInfo_fileExtension_g'
            type: 'string'
          }
          {
            name: 'threatInfo_maliciousProcessArguments_s'
            type: 'string'
          }
          {
            name: 'whiteningOptions_s'
            type: 'string'
          }
          {
            name: 'DataFields_s'
            type: 'string'
          }
          {
            name: 'alertInfo_updatedAt_t'
            type: 'string'
          }
          {
            name: 'threatInfo_fileVerificationType_s'
            type: 'string'
          }
          {
            name: 'threatInfo_filePath_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_siteName_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_siteId_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_scanStatus_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_scanStartedAt_t'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_scanFinishedAt_t'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_rebootRequired_b'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_operationalState_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_userActionsNeeded_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_networkInterfaces_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_groupId_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentVersion_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentUuid_g'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentOsType_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentOsRevision_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentOsName_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_agentNetworkStatus_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_groupName_s'
            type: 'string'
          }
          {
            name: 'threatInfo_fileSize_d'
            type: 'string'
          }
          {
            name: 'indicators_s'
            type: 'string'
          }
          {
            name: 'threatInfo_analystVerdict_s'
            type: 'string'
          }
          {
            name: 'threatInfo_fileExtensionType_s'
            type: 'string'
          }
          {
            name: 'threatInfo_fileExtension_s'
            type: 'string'
          }
          {
            name: 'threatInfo_failedActions_b'
            type: 'string'
          }
          {
            name: 'threatInfo_externalTicketExists_b'
            type: 'string'
          }
          {
            name: 'threatInfo_engines_s'
            type: 'string'
          }
          {
            name: 'threatInfo_detectionType_s'
            type: 'string'
          }
          {
            name: 'threatInfo_detectionEngines_s'
            type: 'string'
          }
          {
            name: 'mitigationStatus_s'
            type: 'string'
          }
          {
            name: 'threatInfo_createdAt_t'
            type: 'string'
          }
          {
            name: 'threatInfo_collectionId_s'
            type: 'string'
          }
          {
            name: 'threatInfo_cloudFilesHashVerdict_s'
            type: 'string'
          }
          {
            name: 'threatInfo_classificationSource_s'
            type: 'string'
          }
          {
            name: 'threatInfo_classification_s'
            type: 'string'
          }
          {
            name: 'threatInfo_certificateId_s'
            type: 'string'
          }
          {
            name: 'threatInfo_automaticallyResolved_b'
            type: 'string'
          }
          {
            name: 'threatInfo_analystVerdictDescription_s'
            type: 'string'
          }
          {
            name: 'threatInfo_confidenceLevel_s'
            type: 'string'
          }
          {
            name: 'alertInfo_source_s'
            type: 'string'
          }
          {
            name: 'alertInfo_reportedAt_t'
            type: 'string'
          }
          {
            name: 'alertInfo_isEdr_b'
            type: 'string'
          }
          {
            name: 'lastIpToMgmt_s'
            type: 'string'
          }
          {
            name: 'lastActiveDate_t'
            type: 'string'
          }
          {
            name: 'isUpToDate_b'
            type: 'string'
          }
          {
            name: 'isUninstalled_b'
            type: 'string'
          }
          {
            name: 'isPendingUninstall_b'
            type: 'string'
          }
          {
            name: 'isDecommissioned_b'
            type: 'string'
          }
          {
            name: 'isActive_b'
            type: 'string'
          }
          {
            name: 'lastLoggedInUserName_s'
            type: 'string'
          }
          {
            name: 'installerType_s'
            type: 'string'
          }
          {
            name: 'inRemoteShellSession_b'
            type: 'string'
          }
          {
            name: 'groupName_s'
            type: 'string'
          }
          {
            name: 'groupIp_s'
            type: 'string'
          }
          {
            name: 'groupId_s'
            type: 'string'
          }
          {
            name: 'firewallEnabled_b'
            type: 'string'
          }
          {
            name: 'externalIp_s'
            type: 'string'
          }
          {
            name: 'externalId_s'
            type: 'string'
          }
          {
            name: 'infected_b'
            type: 'string'
          }
          {
            name: 'encryptedApplications_b'
            type: 'string'
          }
          {
            name: 'licenseKey_s'
            type: 'string'
          }
          {
            name: 'locationType_s'
            type: 'string'
          }
          {
            name: 'rangerVersion_s'
            type: 'string'
          }
          {
            name: 'rangerStatus_s'
            type: 'string'
          }
          {
            name: 'osType_s'
            type: 'string'
          }
          {
            name: 'osStartTime_t'
            type: 'string'
          }
          {
            name: 'osRevision_s'
            type: 'string'
          }
          {
            name: 'osName_s'
            type: 'string'
          }
          {
            name: 'osArch_s'
            type: 'string'
          }
          {
            name: 'locationEnabled_b'
            type: 'string'
          }
          {
            name: 'operationalState_s'
            type: 'string'
          }
          {
            name: 'networkQuarantineEnabled_b'
            type: 'string'
          }
          {
            name: 'networkInterfaces_s'
            type: 'string'
          }
          {
            name: 'modelName_s'
            type: 'string'
          }
          {
            name: 'mitigationModeSuspicious_s'
            type: 'string'
          }
          {
            name: 'mitigationMode_s'
            type: 'string'
          }
          {
            name: 'machineType_s'
            type: 'string'
          }
          {
            name: 'locations_s'
            type: 'string'
          }
          {
            name: 'networkStatus_s'
            type: 'string'
          }
          {
            name: 'registeredAt_t'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'cpuCount_d'
            type: 'string'
          }
          {
            name: 'data_source_s'
            type: 'string'
          }
          {
            name: 'data_siteName_s'
            type: 'string'
          }
          {
            name: 'data_scopeName_s'
            type: 'string'
          }
          {
            name: 'data_scopeLevel_s'
            type: 'string'
          }
          {
            name: 'data_role_s'
            type: 'string'
          }
          {
            name: 'data_fullScopeDetails_s'
            type: 'string'
          }
          {
            name: 'data_accountName_s'
            type: 'string'
          }
          {
            name: 'data_userScope_s'
            type: 'string'
          }
          {
            name: 'createdAt_t'
            type: 'string'
          }
          {
            name: 'accountName_s'
            type: 'string'
          }
          {
            name: 'accountId_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'activityType_d'
            type: 'string'
          }
          {
            name: 'cpuId_s'
            type: 'string'
          }
          {
            name: 'data_username_s'
            type: 'string'
          }
          {
            name: 'primaryDescription_s'
            type: 'string'
          }
          {
            name: 'coreCount_d'
            type: 'string'
          }
          {
            name: 'consoleMigrationStatus_s'
            type: 'string'
          }
          {
            name: 'computerName_s'
            type: 'string'
          }
          {
            name: 'appsVulnerabilityStatus_s'
            type: 'string'
          }
          {
            name: 'allowRemoteShell_b'
            type: 'string'
          }
          {
            name: 'agentVersion_s'
            type: 'string'
          }
          {
            name: 'activeThreats_d'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'activeDirectory_lastUserMemberOf_s'
            type: 'string'
          }
          {
            name: 'activeDirectory_computerMemberOf_s'
            type: 'string'
          }
          {
            name: 'activeDirectory_computerDistinguishedName_s'
            type: 'string'
          }
          {
            name: 'event_name_s'
            type: 'string'
          }
          {
            name: 'userId_s'
            type: 'string'
          }
          {
            name: 'updatedAt_t'
            type: 'string'
          }
          {
            name: 'siteName_s'
            type: 'string'
          }
          {
            name: 'siteId_s'
            type: 'string'
          }
          {
            name: 'activeDirectory_lastUserDistinguishedName_s'
            type: 'string'
          }
          {
            name: 'osUsername_s'
            type: 'string'
          }
          {
            name: 'remoteProfilingState_s'
            type: 'string'
          }
          {
            name: 'scanStartedAt_t'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_name_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_machineType_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcUid_g'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcStorylineId_g'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_uniqueId_g'
            type: 'string'
          }
          {
            name: 'sourceProcessInfo_storyline_g'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_uniqueId_g'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_osFamily_s'
            type: 'string'
          }
          {
            name: 'sourceParentProcessInfo_storyline_g'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcStorylineId_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcSignedStatus_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcPid_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcName_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcImagePath_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcCmdLine_s'
            type: 'string'
          }
          {
            name: 'alertInfo_srcMachineIp_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtProcUid_s'
            type: 'string'
          }
          {
            name: 'alertInfo_loginsUserName_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_osName_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_uuid_g'
            type: 'string'
          }
          {
            name: 'alertInfo_incidentStatus_s'
            type: 'string'
          }
          {
            name: 'alertInfo_hitType_s'
            type: 'string'
          }
          {
            name: 'alertInfo_eventType_s'
            type: 'string'
          }
          {
            name: 'alertInfo_dvEventId_s'
            type: 'string'
          }
          {
            name: 'alertInfo_createdAt_t'
            type: 'string'
          }
          {
            name: 'alertInfo_analystVerdict_s'
            type: 'string'
          }
          {
            name: 'alertInfo_alertId_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_osRevision_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_uuid_g'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_name_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_machineType_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_isDecommissioned_b'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_isActive_b'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_infected_b'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_id_s'
            type: 'string'
          }
          {
            name: 'agentDetectionInfo_version_s'
            type: 'string'
          }
          {
            name: 'agentRealtimeInfo_os_s'
            type: 'string'
          }
          {
            name: 'scanFinishedAt_t'
            type: 'string'
          }
          {
            name: 'alertInfo_loginType_s'
            type: 'string'
          }
          {
            name: 'alertInfo_loginIsAdministratorEquivalent_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileOldPath_s'
            type: 'string'
          }
          {
            name: 'alertInfo_indicatorName_s'
            type: 'string'
          }
          {
            name: 'alertInfo_indicatorDescription_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'totalAgents_d'
            type: 'string'
          }
          {
            name: 'registrationToken_s'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'alertInfo_indicatorCategory_s'
            type: 'string'
          }
          {
            name: 'isDefault_b'
            type: 'string'
          }
          {
            name: 'creatorId_s'
            type: 'string'
          }
          {
            name: 'creator_s'
            type: 'string'
          }
          {
            name: 'uuid_g'
            type: 'string'
          }
          {
            name: 'userActionsNeeded_s'
            type: 'string'
          }
          {
            name: 'totalMemory_d'
            type: 'string'
          }
          {
            name: 'threatRebootRequired_b'
            type: 'string'
          }
          {
            name: 'scanStatus_s'
            type: 'string'
          }
          {
            name: 'inherits_b'
            type: 'string'
          }
          {
            name: 'alertInfo_loginIsSuccessful_s'
            type: 'string'
          }
          {
            name: 'alertInfo_registryOldValue_g'
            type: 'string'
          }
          {
            name: 'alertInfo_dstPort_s'
            type: 'string'
          }
          {
            name: 'alertInfo_loginAccountSid_s'
            type: 'string'
          }
          {
            name: 'alertInfo_loginAccountDomain_s'
            type: 'string'
          }
          {
            name: 'alertInfo_registryValue_s'
            type: 'string'
          }
          {
            name: 'ruleInfo_description_s'
            type: 'string'
          }
          {
            name: 'alertInfo_registryValue_g'
            type: 'string'
          }
          {
            name: 'alertInfo_registryPath_s'
            type: 'string'
          }
          {
            name: 'alertInfo_registryKeyPath_s'
            type: 'string'
          }
          {
            name: 'alertInfo_dstIp_s'
            type: 'string'
          }
          {
            name: 'alertInfo_dnsResponse_s'
            type: 'string'
          }
          {
            name: 'alertInfo_registryOldValueType_s'
            type: 'string'
          }
          {
            name: 'alertInfo_registryOldValue_s'
            type: 'string'
          }
          {
            name: 'targetProcessInfo_tgtFileId_g'
            type: 'string'
          }
          {
            name: 'containerInfo_id_s'
            type: 'string'
          }
          {
            name: 'alertInfo_srcPort_s'
            type: 'string'
          }
          {
            name: 'alertInfo_srcIp_s'
            type: 'string'
          }
          {
            name: 'alertInfo_netEventDirection_s'
            type: 'string'
          }
          {
            name: 'alertInfo_dnsRequest_s'
            type: 'string'
          }
          {
            name: 'scanAbortedAt_t'
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
          name: 'Sentinel-SentinelOne_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SentinelOne_CL']
        destinations: ['Sentinel-SentinelOne_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), agentDetectionInfo_agentIpV4_s = tostring(agentDetectionInfo_agentIpV4_s), agentDetectionInfo_agentDomain_s = tostring(agentDetectionInfo_agentDomain_s), agentDetectionInfo_agentDetectionState_s = tostring(agentDetectionInfo_agentDetectionState_s), agentDetectionInfo_accountName_s = tostring(agentDetectionInfo_accountName_s), agentDetectionInfo_accountId_s = tostring(agentDetectionInfo_accountId_s), threatId_s = tostring(threatId_s), osFamily_s = tostring(osFamily_s), hash_s = tostring(hash_s), agentId_s = tostring(agentId_s), agentUpdatedVersion_s = tostring(agentUpdatedVersion_s), targetProcessInfo_tgtProcessStartTime_t = todatetime(targetProcessInfo_tgtProcessStartTime_t), targetProcessInfo_tgtProcIntegrityLevel_s = tostring(targetProcessInfo_tgtProcIntegrityLevel_s), targetProcessInfo_tgtFilePath_s = tostring(targetProcessInfo_tgtFilePath_s), targetProcessInfo_tgtFileModifiedAt_t = todatetime(targetProcessInfo_tgtFileModifiedAt_t), targetProcessInfo_tgtFileIsSigned_s = tostring(targetProcessInfo_tgtFileIsSigned_s), agentDetectionInfo_agentIpV6_s = tostring(agentDetectionInfo_agentIpV6_s), agentDetectionInfo_agentLastLoggedInUserName_s = tostring(agentDetectionInfo_agentLastLoggedInUserName_s), agentDetectionInfo_agentMitigationMode_s = tostring(agentDetectionInfo_agentMitigationMode_s), agentDetectionInfo_agentOsName_s = tostring(agentDetectionInfo_agentOsName_s), agentRealtimeInfo_agentInfected_b = tobool(agentRealtimeInfo_agentInfected_b), agentRealtimeInfo_agentId_s = tostring(agentRealtimeInfo_agentId_s), agentRealtimeInfo_agentDomain_s = tostring(agentRealtimeInfo_agentDomain_s), agentRealtimeInfo_agentComputerName_s = tostring(agentRealtimeInfo_agentComputerName_s), agentRealtimeInfo_activeThreats_d = toreal(agentRealtimeInfo_activeThreats_d), agentRealtimeInfo_accountName_s = tostring(agentRealtimeInfo_accountName_s), agentRealtimeInfo_accountId_s = tostring(agentRealtimeInfo_accountId_s), targetProcessInfo_tgtFileId_s = tostring(targetProcessInfo_tgtFileId_s), agentDetectionInfo_siteName_s = tostring(agentDetectionInfo_siteName_s), agentDetectionInfo_groupName_s = tostring(agentDetectionInfo_groupName_s), agentDetectionInfo_groupId_s = tostring(agentDetectionInfo_groupId_s), agentDetectionInfo_externalIp_s = tostring(agentDetectionInfo_externalIp_s), agentDetectionInfo_agentVersion_s = tostring(agentDetectionInfo_agentVersion_s), agentDetectionInfo_agentUuid_g = tostring(agentDetectionInfo_agentUuid_g), agentDetectionInfo_agentRegisteredAt_t = todatetime(agentDetectionInfo_agentRegisteredAt_t), agentDetectionInfo_agentOsRevision_s = tostring(agentDetectionInfo_agentOsRevision_s), agentDetectionInfo_siteId_s = tostring(agentDetectionInfo_siteId_s), targetProcessInfo_tgtFileHashSha256_s = tostring(targetProcessInfo_tgtFileHashSha256_s), targetProcessInfo_tgtFileHashSha1_s = tostring(targetProcessInfo_tgtFileHashSha1_s), targetProcessInfo_tgtFileCreatedAt_t = todatetime(targetProcessInfo_tgtFileCreatedAt_t), sourceParentProcessInfo_name_s = tostring(sourceParentProcessInfo_name_s), sourceParentProcessInfo_integrityLevel_s = tostring(sourceParentProcessInfo_integrityLevel_s), sourceParentProcessInfo_fileSignerIdentity_s = tostring(sourceParentProcessInfo_fileSignerIdentity_s), sourceParentProcessInfo_filePath_s = tostring(sourceParentProcessInfo_filePath_s), sourceParentProcessInfo_fileHashSha256_s = tostring(sourceParentProcessInfo_fileHashSha256_s), sourceParentProcessInfo_fileHashSha1_s = tostring(sourceParentProcessInfo_fileHashSha1_s), sourceParentProcessInfo_fileHashMd5_g = tostring(sourceParentProcessInfo_fileHashMd5_g), sourceParentProcessInfo_pid_s = tostring(sourceParentProcessInfo_pid_s), sourceParentProcessInfo_commandline_s = tostring(sourceParentProcessInfo_commandline_s), ruleInfo_severity_s = tostring(ruleInfo_severity_s), ruleInfo_scopeLevel_s = tostring(ruleInfo_scopeLevel_s), ruleInfo_s1ql_s = tostring(ruleInfo_s1ql_s), ruleInfo_queryType_s = tostring(ruleInfo_queryType_s), ruleInfo_queryLang_s = tostring(ruleInfo_queryLang_s), ruleInfo_name_s = tostring(ruleInfo_name_s), ruleInfo_id_s = tostring(ruleInfo_id_s), ruleInfo_treatAsThreat_s = tostring(ruleInfo_treatAsThreat_s), agentRealtimeInfo_agentIsActive_b = tobool(agentRealtimeInfo_agentIsActive_b), sourceParentProcessInfo_pidStarttime_t = todatetime(sourceParentProcessInfo_pidStarttime_t), sourceParentProcessInfo_subsystem_s = tostring(sourceParentProcessInfo_subsystem_s), sourceProcessInfo_user_s = tostring(sourceProcessInfo_user_s), sourceProcessInfo_uniqueId_s = tostring(sourceProcessInfo_uniqueId_s), sourceProcessInfo_subsystem_s = tostring(sourceProcessInfo_subsystem_s), sourceProcessInfo_storyline_s = tostring(sourceProcessInfo_storyline_s), sourceProcessInfo_pidStarttime_t = todatetime(sourceProcessInfo_pidStarttime_t), sourceProcessInfo_pid_s = tostring(sourceProcessInfo_pid_s), sourceProcessInfo_name_s = tostring(sourceProcessInfo_name_s), sourceParentProcessInfo_storyline_s = tostring(sourceParentProcessInfo_storyline_s), sourceProcessInfo_integrityLevel_s = tostring(sourceProcessInfo_integrityLevel_s), sourceProcessInfo_filePath_s = tostring(sourceProcessInfo_filePath_s), sourceProcessInfo_fileHashSha256_s = tostring(sourceProcessInfo_fileHashSha256_s), sourceProcessInfo_fileHashSha1_s = tostring(sourceProcessInfo_fileHashSha1_s), sourceProcessInfo_fileHashMd5_g = tostring(sourceProcessInfo_fileHashMd5_g), sourceProcessInfo_commandline_s = tostring(sourceProcessInfo_commandline_s), sourceParentProcessInfo_user_s = tostring(sourceParentProcessInfo_user_s), sourceParentProcessInfo_uniqueId_s = tostring(sourceParentProcessInfo_uniqueId_s), sourceProcessInfo_fileSignerIdentity_s = tostring(sourceProcessInfo_fileSignerIdentity_s), agentRealtimeInfo_agentIsDecommissioned_b = tobool(agentRealtimeInfo_agentIsDecommissioned_b), agentRealtimeInfo_agentMachineType_s = tostring(agentRealtimeInfo_agentMachineType_s), agentRealtimeInfo_agentMitigationMode_s = tostring(agentRealtimeInfo_agentMitigationMode_s), threatInfo_sha1_s = tostring(threatInfo_sha1_s), threatInfo_rebootRequired_b = tobool(threatInfo_rebootRequired_b), threatInfo_reachedEventsLimit_b = tobool(threatInfo_reachedEventsLimit_b), threatInfo_publisherName_s = tostring(threatInfo_publisherName_s), threatInfo_processUser_s = tostring(threatInfo_processUser_s), threatInfo_pendingActions_b = tobool(threatInfo_pendingActions_b), threatInfo_originatorProcess_s = tostring(threatInfo_originatorProcess_s), threatInfo_storyline_s = tostring(threatInfo_storyline_s), threatInfo_mitigationStatusDescription_s = tostring(threatInfo_mitigationStatusDescription_s), threatInfo_mitigatedPreemptively_b = tobool(threatInfo_mitigatedPreemptively_b), threatInfo_isValidCertificate_b = tobool(threatInfo_isValidCertificate_b), threatInfo_isFileless_b = tobool(threatInfo_isFileless_b), threatInfo_initiatedByDescription_s = tostring(threatInfo_initiatedByDescription_s), threatInfo_initiatedBy_s = tostring(threatInfo_initiatedBy_s), threatInfo_incidentStatusDescription_s = tostring(threatInfo_incidentStatusDescription_s), threatInfo_incidentStatus_s = tostring(threatInfo_incidentStatus_s), threatInfo_mitigationStatus_s = tostring(threatInfo_mitigationStatus_s), threatInfo_identifiedAt_t = todatetime(threatInfo_identifiedAt_t), threatInfo_threatId_s = tostring(threatInfo_threatId_s), threatInfo_updatedAt_t = todatetime(threatInfo_updatedAt_t), tags_sentinelone_s = tostring(tags_sentinelone_s), showAlertIcon_b = tobool(showAlertIcon_b), serialNumber_s = tostring(serialNumber_s), fullDiskScanLastUpdatedAt_t = todatetime(fullDiskScanLastUpdatedAt_t), firstFullModeTime_t = todatetime(firstFullModeTime_t), detectionState_s = tostring(detectionState_s), comments_s = tostring(comments_s), threatInfo_threatName_s = tostring(threatInfo_threatName_s), description_s = tostring(description_s), secondaryDescription_s = tostring(secondaryDescription_s), activityUuid_g = tostring(activityUuid_g), threatInfo_storyline_g = tostring(threatInfo_storyline_g), threatInfo_threatName_g = tostring(threatInfo_threatName_g), threatInfo_fileExtension_g = tostring(threatInfo_fileExtension_g), threatInfo_maliciousProcessArguments_s = tostring(threatInfo_maliciousProcessArguments_s), whiteningOptions_s = tostring(whiteningOptions_s), DataFields_s = tostring(DataFields_s), alertInfo_updatedAt_t = todatetime(alertInfo_updatedAt_t), threatInfo_fileVerificationType_s = tostring(threatInfo_fileVerificationType_s), threatInfo_filePath_s = tostring(threatInfo_filePath_s), agentRealtimeInfo_siteName_s = tostring(agentRealtimeInfo_siteName_s), agentRealtimeInfo_siteId_s = tostring(agentRealtimeInfo_siteId_s), agentRealtimeInfo_scanStatus_s = tostring(agentRealtimeInfo_scanStatus_s), agentRealtimeInfo_scanStartedAt_t = todatetime(agentRealtimeInfo_scanStartedAt_t), agentRealtimeInfo_scanFinishedAt_t = todatetime(agentRealtimeInfo_scanFinishedAt_t), agentRealtimeInfo_rebootRequired_b = tobool(agentRealtimeInfo_rebootRequired_b), agentRealtimeInfo_operationalState_s = tostring(agentRealtimeInfo_operationalState_s), agentRealtimeInfo_userActionsNeeded_s = tostring(agentRealtimeInfo_userActionsNeeded_s), agentRealtimeInfo_networkInterfaces_s = tostring(agentRealtimeInfo_networkInterfaces_s), agentRealtimeInfo_groupId_s = tostring(agentRealtimeInfo_groupId_s), agentRealtimeInfo_agentVersion_s = tostring(agentRealtimeInfo_agentVersion_s), agentRealtimeInfo_agentUuid_g = tostring(agentRealtimeInfo_agentUuid_g), agentRealtimeInfo_agentOsType_s = tostring(agentRealtimeInfo_agentOsType_s), agentRealtimeInfo_agentOsRevision_s = tostring(agentRealtimeInfo_agentOsRevision_s), agentRealtimeInfo_agentOsName_s = tostring(agentRealtimeInfo_agentOsName_s), agentRealtimeInfo_agentNetworkStatus_s = tostring(agentRealtimeInfo_agentNetworkStatus_s), agentRealtimeInfo_groupName_s = tostring(agentRealtimeInfo_groupName_s), threatInfo_fileSize_d = toreal(threatInfo_fileSize_d), indicators_s = tostring(indicators_s), threatInfo_analystVerdict_s = tostring(threatInfo_analystVerdict_s), threatInfo_fileExtensionType_s = tostring(threatInfo_fileExtensionType_s), threatInfo_fileExtension_s = tostring(threatInfo_fileExtension_s), threatInfo_failedActions_b = tobool(threatInfo_failedActions_b), threatInfo_externalTicketExists_b = tobool(threatInfo_externalTicketExists_b), threatInfo_engines_s = tostring(threatInfo_engines_s), threatInfo_detectionType_s = tostring(threatInfo_detectionType_s), threatInfo_detectionEngines_s = tostring(threatInfo_detectionEngines_s), mitigationStatus_s = tostring(mitigationStatus_s), threatInfo_createdAt_t = todatetime(threatInfo_createdAt_t), threatInfo_collectionId_s = tostring(threatInfo_collectionId_s), threatInfo_cloudFilesHashVerdict_s = tostring(threatInfo_cloudFilesHashVerdict_s), threatInfo_classificationSource_s = tostring(threatInfo_classificationSource_s), threatInfo_classification_s = tostring(threatInfo_classification_s), threatInfo_certificateId_s = tostring(threatInfo_certificateId_s), threatInfo_automaticallyResolved_b = tobool(threatInfo_automaticallyResolved_b), threatInfo_analystVerdictDescription_s = tostring(threatInfo_analystVerdictDescription_s), threatInfo_confidenceLevel_s = tostring(threatInfo_confidenceLevel_s), alertInfo_source_s = tostring(alertInfo_source_s), alertInfo_reportedAt_t = todatetime(alertInfo_reportedAt_t), alertInfo_isEdr_b = tobool(alertInfo_isEdr_b), lastIpToMgmt_s = tostring(lastIpToMgmt_s), lastActiveDate_t = todatetime(lastActiveDate_t), isUpToDate_b = tobool(isUpToDate_b), isUninstalled_b = tobool(isUninstalled_b), isPendingUninstall_b = tobool(isPendingUninstall_b), isDecommissioned_b = tobool(isDecommissioned_b), isActive_b = tobool(isActive_b), lastLoggedInUserName_s = tostring(lastLoggedInUserName_s), installerType_s = tostring(installerType_s), inRemoteShellSession_b = tobool(inRemoteShellSession_b), groupName_s = tostring(groupName_s), groupIp_s = tostring(groupIp_s), groupId_s = tostring(groupId_s), firewallEnabled_b = tobool(firewallEnabled_b), externalIp_s = tostring(externalIp_s), externalId_s = tostring(externalId_s), infected_b = tobool(infected_b), encryptedApplications_b = tobool(encryptedApplications_b), licenseKey_s = tostring(licenseKey_s), locationType_s = tostring(locationType_s), rangerVersion_s = tostring(rangerVersion_s), rangerStatus_s = tostring(rangerStatus_s), osType_s = tostring(osType_s), osStartTime_t = todatetime(osStartTime_t), osRevision_s = tostring(osRevision_s), osName_s = tostring(osName_s), osArch_s = tostring(osArch_s), locationEnabled_b = tobool(locationEnabled_b), operationalState_s = tostring(operationalState_s), networkQuarantineEnabled_b = tobool(networkQuarantineEnabled_b), networkInterfaces_s = tostring(networkInterfaces_s), modelName_s = tostring(modelName_s), mitigationModeSuspicious_s = tostring(mitigationModeSuspicious_s), mitigationMode_s = tostring(mitigationMode_s), machineType_s = tostring(machineType_s), locations_s = tostring(locations_s), networkStatus_s = tostring(networkStatus_s), registeredAt_t = todatetime(registeredAt_t), domain_s = tostring(domain_s), cpuCount_d = toreal(cpuCount_d), data_source_s = tostring(data_source_s), data_siteName_s = tostring(data_siteName_s), data_scopeName_s = tostring(data_scopeName_s), data_scopeLevel_s = tostring(data_scopeLevel_s), data_role_s = tostring(data_role_s), data_fullScopeDetails_s = tostring(data_fullScopeDetails_s), data_accountName_s = tostring(data_accountName_s), data_userScope_s = tostring(data_userScope_s), createdAt_t = todatetime(createdAt_t), accountName_s = tostring(accountName_s), accountId_s = tostring(accountId_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), activityType_d = toreal(activityType_d), cpuId_s = tostring(cpuId_s), data_username_s = tostring(data_username_s), primaryDescription_s = tostring(primaryDescription_s), coreCount_d = toreal(coreCount_d), consoleMigrationStatus_s = tostring(consoleMigrationStatus_s), computerName_s = tostring(computerName_s), appsVulnerabilityStatus_s = tostring(appsVulnerabilityStatus_s), allowRemoteShell_b = tobool(allowRemoteShell_b), agentVersion_s = tostring(agentVersion_s), activeThreats_d = toreal(activeThreats_d), id_s = tostring(id_s), activeDirectory_lastUserMemberOf_s = tostring(activeDirectory_lastUserMemberOf_s), activeDirectory_computerMemberOf_s = tostring(activeDirectory_computerMemberOf_s), activeDirectory_computerDistinguishedName_s = tostring(activeDirectory_computerDistinguishedName_s), event_name_s = tostring(event_name_s), userId_s = tostring(userId_s), updatedAt_t = todatetime(updatedAt_t), siteName_s = tostring(siteName_s), siteId_s = tostring(siteId_s), activeDirectory_lastUserDistinguishedName_s = tostring(activeDirectory_lastUserDistinguishedName_s), osUsername_s = tostring(osUsername_s), remoteProfilingState_s = tostring(remoteProfilingState_s), scanStartedAt_t = todatetime(scanStartedAt_t), agentDetectionInfo_name_s = tostring(agentDetectionInfo_name_s), agentDetectionInfo_machineType_s = tostring(agentDetectionInfo_machineType_s), targetProcessInfo_tgtProcUid_g = tostring(targetProcessInfo_tgtProcUid_g), targetProcessInfo_tgtProcStorylineId_g = tostring(targetProcessInfo_tgtProcStorylineId_g), sourceProcessInfo_uniqueId_g = tostring(sourceProcessInfo_uniqueId_g), sourceProcessInfo_storyline_g = tostring(sourceProcessInfo_storyline_g), sourceParentProcessInfo_uniqueId_g = tostring(sourceParentProcessInfo_uniqueId_g), agentDetectionInfo_osFamily_s = tostring(agentDetectionInfo_osFamily_s), sourceParentProcessInfo_storyline_g = tostring(sourceParentProcessInfo_storyline_g), targetProcessInfo_tgtProcStorylineId_s = tostring(targetProcessInfo_tgtProcStorylineId_s), targetProcessInfo_tgtProcSignedStatus_s = tostring(targetProcessInfo_tgtProcSignedStatus_s), targetProcessInfo_tgtProcPid_s = tostring(targetProcessInfo_tgtProcPid_s), targetProcessInfo_tgtProcName_s = tostring(targetProcessInfo_tgtProcName_s), targetProcessInfo_tgtProcImagePath_s = tostring(targetProcessInfo_tgtProcImagePath_s), targetProcessInfo_tgtProcCmdLine_s = tostring(targetProcessInfo_tgtProcCmdLine_s), alertInfo_srcMachineIp_s = tostring(alertInfo_srcMachineIp_s), targetProcessInfo_tgtProcUid_s = tostring(targetProcessInfo_tgtProcUid_s), alertInfo_loginsUserName_s = tostring(alertInfo_loginsUserName_s), agentDetectionInfo_osName_s = tostring(agentDetectionInfo_osName_s), agentDetectionInfo_uuid_g = tostring(agentDetectionInfo_uuid_g), alertInfo_incidentStatus_s = tostring(alertInfo_incidentStatus_s), alertInfo_hitType_s = tostring(alertInfo_hitType_s), alertInfo_eventType_s = tostring(alertInfo_eventType_s), alertInfo_dvEventId_s = tostring(alertInfo_dvEventId_s), alertInfo_createdAt_t = todatetime(alertInfo_createdAt_t), alertInfo_analystVerdict_s = tostring(alertInfo_analystVerdict_s), alertInfo_alertId_s = tostring(alertInfo_alertId_s), agentDetectionInfo_osRevision_s = tostring(agentDetectionInfo_osRevision_s), agentRealtimeInfo_uuid_g = tostring(agentRealtimeInfo_uuid_g), agentRealtimeInfo_name_s = tostring(agentRealtimeInfo_name_s), agentRealtimeInfo_machineType_s = tostring(agentRealtimeInfo_machineType_s), agentRealtimeInfo_isDecommissioned_b = tobool(agentRealtimeInfo_isDecommissioned_b), agentRealtimeInfo_isActive_b = tobool(agentRealtimeInfo_isActive_b), agentRealtimeInfo_infected_b = tobool(agentRealtimeInfo_infected_b), agentRealtimeInfo_id_s = tostring(agentRealtimeInfo_id_s), agentDetectionInfo_version_s = tostring(agentDetectionInfo_version_s), agentRealtimeInfo_os_s = tostring(agentRealtimeInfo_os_s), scanFinishedAt_t = todatetime(scanFinishedAt_t), alertInfo_loginType_s = tostring(alertInfo_loginType_s), alertInfo_loginIsAdministratorEquivalent_s = tostring(alertInfo_loginIsAdministratorEquivalent_s), targetProcessInfo_tgtFileOldPath_s = tostring(targetProcessInfo_tgtFileOldPath_s), alertInfo_indicatorName_s = tostring(alertInfo_indicatorName_s), alertInfo_indicatorDescription_s = tostring(alertInfo_indicatorDescription_s), type_s = tostring(type_s), totalAgents_d = toreal(totalAgents_d), registrationToken_s = tostring(registrationToken_s), name_s = tostring(name_s), alertInfo_indicatorCategory_s = tostring(alertInfo_indicatorCategory_s), isDefault_b = tobool(isDefault_b), creatorId_s = tostring(creatorId_s), creator_s = tostring(creator_s), uuid_g = tostring(uuid_g), userActionsNeeded_s = tostring(userActionsNeeded_s), totalMemory_d = toreal(totalMemory_d), threatRebootRequired_b = tobool(threatRebootRequired_b), scanStatus_s = tostring(scanStatus_s), inherits_b = tobool(inherits_b), alertInfo_loginIsSuccessful_s = tostring(alertInfo_loginIsSuccessful_s), alertInfo_registryOldValue_g = tostring(alertInfo_registryOldValue_g), alertInfo_dstPort_s = tostring(alertInfo_dstPort_s), alertInfo_loginAccountSid_s = tostring(alertInfo_loginAccountSid_s), alertInfo_loginAccountDomain_s = tostring(alertInfo_loginAccountDomain_s), alertInfo_registryValue_s = tostring(alertInfo_registryValue_s), ruleInfo_description_s = tostring(ruleInfo_description_s), alertInfo_registryValue_g = tostring(alertInfo_registryValue_g), alertInfo_registryPath_s = tostring(alertInfo_registryPath_s), alertInfo_registryKeyPath_s = tostring(alertInfo_registryKeyPath_s), alertInfo_dstIp_s = tostring(alertInfo_dstIp_s), alertInfo_dnsResponse_s = tostring(alertInfo_dnsResponse_s), alertInfo_registryOldValueType_s = tostring(alertInfo_registryOldValueType_s), alertInfo_registryOldValue_s = tostring(alertInfo_registryOldValue_s), targetProcessInfo_tgtFileId_g = tostring(targetProcessInfo_tgtFileId_g), containerInfo_id_s = tostring(containerInfo_id_s), alertInfo_srcPort_s = tostring(alertInfo_srcPort_s), alertInfo_srcIp_s = tostring(alertInfo_srcIp_s), alertInfo_netEventDirection_s = tostring(alertInfo_netEventDirection_s), alertInfo_dnsRequest_s = tostring(alertInfo_dnsRequest_s), scanAbortedAt_t = todatetime(scanAbortedAt_t)'
        outputStream: 'Custom-SentinelOne_CL'
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
