// Bicep template for Log Analytics custom table: SentinelOne_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 323, Deployed columns: 319 (Type column filtered)
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

resource sentineloneclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SentinelOne_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SentinelOne_CL'
      description: 'Custom table SentinelOne_CL - imported from JSON schema'
      displayName: 'SentinelOne_CL'
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
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'boolean'
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
          type: 'real'
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
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'sourceParentProcessInfo_pidStarttime_t'
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'boolean'
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
          type: 'boolean'
        }
        {
          name: 'threatInfo_reachedEventsLimit_b'
          type: 'boolean'
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
          type: 'boolean'
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
          type: 'boolean'
        }
        {
          name: 'threatInfo_isValidCertificate_b'
          type: 'boolean'
        }
        {
          name: 'threatInfo_isFileless_b'
          type: 'boolean'
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
          type: 'dateTime'
        }
        {
          name: 'threatInfo_threatId_s'
          type: 'string'
        }
        {
          name: 'threatInfo_updatedAt_t'
          type: 'dateTime'
        }
        {
          name: 'tags_sentinelone_s'
          type: 'string'
        }
        {
          name: 'showAlertIcon_b'
          type: 'boolean'
        }
        {
          name: 'serialNumber_s'
          type: 'string'
        }
        {
          name: 'fullDiskScanLastUpdatedAt_t'
          type: 'dateTime'
        }
        {
          name: 'firstFullModeTime_t'
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'dateTime'
        }
        {
          name: 'agentRealtimeInfo_scanFinishedAt_t'
          type: 'dateTime'
        }
        {
          name: 'agentRealtimeInfo_rebootRequired_b'
          type: 'boolean'
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
          type: 'real'
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
          type: 'boolean'
        }
        {
          name: 'threatInfo_externalTicketExists_b'
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'boolean'
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
          type: 'dateTime'
        }
        {
          name: 'alertInfo_isEdr_b'
          type: 'boolean'
        }
        {
          name: 'lastIpToMgmt_s'
          type: 'string'
        }
        {
          name: 'lastActiveDate_t'
          type: 'dateTime'
        }
        {
          name: 'isUpToDate_b'
          type: 'boolean'
        }
        {
          name: 'isUninstalled_b'
          type: 'boolean'
        }
        {
          name: 'isPendingUninstall_b'
          type: 'boolean'
        }
        {
          name: 'isDecommissioned_b'
          type: 'boolean'
        }
        {
          name: 'isActive_b'
          type: 'boolean'
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
          type: 'boolean'
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
          type: 'boolean'
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
          type: 'boolean'
        }
        {
          name: 'encryptedApplications_b'
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'operationalState_s'
          type: 'string'
        }
        {
          name: 'networkQuarantineEnabled_b'
          type: 'boolean'
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
          type: 'dateTime'
        }
        {
          name: 'domain_s'
          type: 'string'
        }
        {
          name: 'cpuCount_d'
          type: 'real'
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
          type: 'dateTime'
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
          type: 'real'
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
          type: 'real'
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
          type: 'boolean'
        }
        {
          name: 'agentVersion_s'
          type: 'string'
        }
        {
          name: 'activeThreats_d'
          type: 'real'
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
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'agentRealtimeInfo_isActive_b'
          type: 'boolean'
        }
        {
          name: 'agentRealtimeInfo_infected_b'
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'real'
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
          type: 'boolean'
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
          type: 'real'
        }
        {
          name: 'threatRebootRequired_b'
          type: 'boolean'
        }
        {
          name: 'scanStatus_s'
          type: 'string'
        }
        {
          name: 'inherits_b'
          type: 'boolean'
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
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = sentineloneclTable.name
output tableId string = sentineloneclTable.id
output provisioningState string = sentineloneclTable.properties.provisioningState
