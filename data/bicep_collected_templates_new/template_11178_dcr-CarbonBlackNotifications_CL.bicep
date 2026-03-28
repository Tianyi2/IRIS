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
// Data Collection Rule for CarbonBlackNotifications_CL
// ============================================================================
// Generated: 2025-09-19 14:19:58
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 170, DCR columns: 167 (Type column always filtered)
// Output stream: Custom-CarbonBlackNotifications_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CarbonBlackNotifications_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CarbonBlackNotifications_CL': {
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
            name: 'threatInfo_threatCause_actor_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_actorName_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_actorProcessPPid_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_threatCategory_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_originSourceType_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_causeEventId_g'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_processGuid_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_reputation_s'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_parentGuid_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_score_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_summary_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_time_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_indicators_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_watchLists_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_iocId_g'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_count_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_incidentId_g'
            type: 'string'
          }
          {
            name: 'threatInfo_threatCause_reason_s'
            type: 'string'
          }
          {
            name: 'threatInfo_indicators_s'
            type: 'string'
          }
          {
            name: 'threatInfo_time_d'
            type: 'string'
          }
          {
            name: 'workflow_changed_by_type_s'
            type: 'string'
          }
          {
            name: 'workflow_changed_by_s'
            type: 'string'
          }
          {
            name: 'workflow_closure_reason_s'
            type: 'string'
          }
          {
            name: 'process_effective_reputation_s'
            type: 'string'
          }
          {
            name: 'parent_name_s'
            type: 'string'
          }
          {
            name: 'process_publisher_s'
            type: 'string'
          }
          {
            name: 'mdr_alert_notes_present_b'
            type: 'string'
          }
          {
            name: 'process_md5_g'
            type: 'string'
          }
          {
            name: 'device_id_d'
            type: 'string'
          }
          {
            name: 'ml_classification_org_prevalence_s'
            type: 'string'
          }
          {
            name: 'sensor_action_s'
            type: 'string'
          }
          {
            name: 'device_username_s'
            type: 'string'
          }
          {
            name: 'backend_update_timestamp_t'
            type: 'string'
          }
          {
            name: 'last_event_timestamp_t'
            type: 'string'
          }
          {
            name: 'threatInfo_incidentId_g'
            type: 'string'
          }
          {
            name: 'threatInfo_score_d'
            type: 'string'
          }
          {
            name: 'threatInfo_summary_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_dismissed_b'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_documentGuid_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_firstActivityTime_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_md5_g'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatId_g'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_lastUpdatedTime_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_orgId_d'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'eventDescription_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_internalIpAddress_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_externalIpAddress_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_targetPriorityCode_d'
            type: 'string'
          }
          {
            name: 'deviceInfo_groupName_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_deviceId_d'
            type: 'string'
          }
          {
            name: 'deviceInfo_deviceName_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_deviceType_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_deviceVersion_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_email_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_targetPriorityType_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_uemId_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_processGuid_s'
            type: 'string'
          }
          {
            name: 'workflow_change_timestamp_t'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_originSourceType_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_actorName_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_policyId_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_processGuid_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_processPath_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_reportName_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_reportId_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_reputation_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_responseAlarmId_g'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_responseSeverity_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_runState_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_sha256_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_targetPriority_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_reason_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_actorProcessPPid_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_parentGuid_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_causeEventId_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_reputation_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_actor_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatCause_threatCategory_s'
            type: 'string'
          }
          {
            name: 'workflow_status_s'
            type: 'string'
          }
          {
            name: 'watchlists_s'
            type: 'string'
          }
          {
            name: 'org_key_s'
            type: 'string'
          }
          {
            name: 'childproc_guid_s'
            type: 'string'
          }
          {
            name: 'blocked_effective_reputation_s'
            type: 'string'
          }
          {
            name: 'childproc_cmdline_s'
            type: 'string'
          }
          {
            name: 'attack_tactic_s'
            type: 'string'
          }
          {
            name: 'childproc_sha256_s'
            type: 'string'
          }
          {
            name: 'first_event_timestamp_t'
            type: 'string'
          }
          {
            name: 'parent_reputation_s'
            type: 'string'
          }
          {
            name: 'run_state_s'
            type: 'string'
          }
          {
            name: 'mdr_alert_b'
            type: 'string'
          }
          {
            name: 'detection_timestamp_t'
            type: 'string'
          }
          {
            name: 'parent_pid_d'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_policyId_s'
            type: 'string'
          }
          {
            name: 'device_internal_ip_s'
            type: 'string'
          }
          {
            name: 'reason_s'
            type: 'string'
          }
          {
            name: 'alert_url_s'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'process_cmdline_s'
            type: 'string'
          }
          {
            name: 'childproc_username_s'
            type: 'string'
          }
          {
            name: 'process_username_s'
            type: 'string'
          }
          {
            name: 'ttps_s'
            type: 'string'
          }
          {
            name: 'blocked_name_s'
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
            name: 'threatHunterInfo_md5_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_iocId_s'
            type: 'string'
          }
          {
            name: 'deviceInfo_uemId_g'
            type: 'string'
          }
          {
            name: 'threat_id_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_threatId_s'
            type: 'string'
          }
          {
            name: 'rule_id_g'
            type: 'string'
          }
          {
            name: 'attack_technique_s'
            type: 'string'
          }
          {
            name: 'rule_category_id_g'
            type: 'string'
          }
          {
            name: 'ioc_id_g'
            type: 'string'
          }
          {
            name: 'childproc_name_s'
            type: 'string'
          }
          {
            name: 'blocked_sha256_s'
            type: 'string'
          }
          {
            name: 'primary_event_id_g'
            type: 'string'
          }
          {
            name: 'childproc_effective_reputation_s'
            type: 'string'
          }
          {
            name: 'ruleName_s'
            type: 'string'
          }
          {
            name: 'process_guid_s'
            type: 'string'
          }
          {
            name: 'report_tags_s'
            type: 'string'
          }
          {
            name: 'parent_cmdline_s'
            type: 'string'
          }
          {
            name: 'parent_guid_s'
            type: 'string'
          }
          {
            name: 'device_target_value_s'
            type: 'string'
          }
          {
            name: 'ioc_hit_s'
            type: 'string'
          }
          {
            name: 'device_external_ip_s'
            type: 'string'
          }
          {
            name: 'device_policy_id_d'
            type: 'string'
          }
          {
            name: 'device_os_version_s'
            type: 'string'
          }
          {
            name: 'policy_applied_s'
            type: 'string'
          }
          {
            name: 'parent_effective_reputation_s'
            type: 'string'
          }
          {
            name: 'process_name_s'
            type: 'string'
          }
          {
            name: 'version_s'
            type: 'string'
          }
          {
            name: 'device_location_s'
            type: 'string'
          }
          {
            name: 'report_description_s'
            type: 'string'
          }
          {
            name: 'threat_id_g'
            type: 'string'
          }
          {
            name: 'is_updated_b'
            type: 'string'
          }
          {
            name: 'parent_username_s'
            type: 'string'
          }
          {
            name: 'device_name_s'
            type: 'string'
          }
          {
            name: 'alert_notes_present_b'
            type: 'string'
          }
          {
            name: 'parent_sha256_s'
            type: 'string'
          }
          {
            name: 'report_link_s'
            type: 'string'
          }
          {
            name: 'reason_code_s'
            type: 'string'
          }
          {
            name: 'report_id_s'
            type: 'string'
          }
          {
            name: 'ml_classification_final_verdict_s'
            type: 'string'
          }
          {
            name: 'threatHunterInfo_processPath_d'
            type: 'string'
          }
          {
            name: 'device_policy_s'
            type: 'string'
          }
          {
            name: 'device_os_s'
            type: 'string'
          }
          {
            name: 'ml_classification_global_prevalence_s'
            type: 'string'
          }
          {
            name: 'primary_event_id_s'
            type: 'string'
          }
          {
            name: 'process_pid_d'
            type: 'string'
          }
          {
            name: 'determination_value_s'
            type: 'string'
          }
          {
            name: 'determination_change_timestamp_t'
            type: 'string'
          }
          {
            name: 'ioc_id_s'
            type: 'string'
          }
          {
            name: 'process_issuer_s'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'process_sha256_s'
            type: 'string'
          }
          {
            name: 'process_reputation_s'
            type: 'string'
          }
          {
            name: 'parent_md5_g'
            type: 'string'
          }
          {
            name: 'report_name_s'
            type: 'string'
          }
          {
            name: 'backend_timestamp_t'
            type: 'string'
          }
          {
            name: 'eventTime_d'
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
          name: 'Sentinel-CarbonBlackNotifications_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CarbonBlackNotifications_CL']
        destinations: ['Sentinel-CarbonBlackNotifications_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), threatInfo_threatCause_actor_s = tostring(threatInfo_threatCause_actor_s), threatInfo_threatCause_actorName_s = tostring(threatInfo_threatCause_actorName_s), threatInfo_threatCause_actorProcessPPid_s = tostring(threatInfo_threatCause_actorProcessPPid_s), threatInfo_threatCause_threatCategory_s = tostring(threatInfo_threatCause_threatCategory_s), threatInfo_threatCause_originSourceType_s = tostring(threatInfo_threatCause_originSourceType_s), threatInfo_threatCause_causeEventId_g = tostring(threatInfo_threatCause_causeEventId_g), threatInfo_threatCause_processGuid_s = tostring(threatInfo_threatCause_processGuid_s), threatInfo_threatCause_reputation_s = tostring(threatInfo_threatCause_reputation_s), threatInfo_threatCause_parentGuid_s = tostring(threatInfo_threatCause_parentGuid_s), threatHunterInfo_score_d = toreal(threatHunterInfo_score_d), threatHunterInfo_summary_s = tostring(threatHunterInfo_summary_s), threatHunterInfo_time_d = toreal(threatHunterInfo_time_d), threatHunterInfo_indicators_s = tostring(threatHunterInfo_indicators_s), threatHunterInfo_watchLists_s = tostring(threatHunterInfo_watchLists_s), threatHunterInfo_iocId_g = tostring(threatHunterInfo_iocId_g), threatHunterInfo_count_d = toreal(threatHunterInfo_count_d), threatHunterInfo_incidentId_g = tostring(threatHunterInfo_incidentId_g), threatInfo_threatCause_reason_s = tostring(threatInfo_threatCause_reason_s), threatInfo_indicators_s = tostring(threatInfo_indicators_s), threatInfo_time_d = toreal(threatInfo_time_d), workflow_changed_by_type_s = tostring(workflow_changed_by_type_s), workflow_changed_by_s = tostring(workflow_changed_by_s), workflow_closure_reason_s = tostring(workflow_closure_reason_s), process_effective_reputation_s = tostring(process_effective_reputation_s), parent_name_s = tostring(parent_name_s), process_publisher_s = tostring(process_publisher_s), mdr_alert_notes_present_b = tobool(mdr_alert_notes_present_b), process_md5_g = tostring(process_md5_g), device_id_d = toreal(device_id_d), ml_classification_org_prevalence_s = tostring(ml_classification_org_prevalence_s), sensor_action_s = tostring(sensor_action_s), device_username_s = tostring(device_username_s), backend_update_timestamp_t = todatetime(backend_update_timestamp_t), last_event_timestamp_t = todatetime(last_event_timestamp_t), threatInfo_incidentId_g = tostring(threatInfo_incidentId_g), threatInfo_score_d = toreal(threatInfo_score_d), threatInfo_summary_s = tostring(threatInfo_summary_s), threatHunterInfo_dismissed_b = tobool(threatHunterInfo_dismissed_b), threatHunterInfo_documentGuid_s = tostring(threatHunterInfo_documentGuid_s), threatHunterInfo_firstActivityTime_d = toreal(threatHunterInfo_firstActivityTime_d), threatHunterInfo_md5_g = tostring(threatHunterInfo_md5_g), threatHunterInfo_threatId_g = tostring(threatHunterInfo_threatId_g), threatHunterInfo_lastUpdatedTime_d = toreal(threatHunterInfo_lastUpdatedTime_d), threatHunterInfo_orgId_d = toreal(threatHunterInfo_orgId_d), url_s = tostring(url_s), type_s = tostring(type_s), eventDescription_s = tostring(eventDescription_s), deviceInfo_internalIpAddress_s = tostring(deviceInfo_internalIpAddress_s), deviceInfo_externalIpAddress_s = tostring(deviceInfo_externalIpAddress_s), deviceInfo_targetPriorityCode_d = toreal(deviceInfo_targetPriorityCode_d), deviceInfo_groupName_s = tostring(deviceInfo_groupName_s), deviceInfo_deviceId_d = toreal(deviceInfo_deviceId_d), deviceInfo_deviceName_s = tostring(deviceInfo_deviceName_s), deviceInfo_deviceType_s = tostring(deviceInfo_deviceType_s), deviceInfo_deviceVersion_s = tostring(deviceInfo_deviceVersion_s), deviceInfo_email_s = tostring(deviceInfo_email_s), deviceInfo_targetPriorityType_s = tostring(deviceInfo_targetPriorityType_s), deviceInfo_uemId_s = tostring(deviceInfo_uemId_s), threatHunterInfo_threatCause_processGuid_s = tostring(threatHunterInfo_threatCause_processGuid_s), workflow_change_timestamp_t = todatetime(workflow_change_timestamp_t), threatHunterInfo_threatCause_originSourceType_s = tostring(threatHunterInfo_threatCause_originSourceType_s), threatHunterInfo_threatCause_actorName_s = tostring(threatHunterInfo_threatCause_actorName_s), threatHunterInfo_policyId_d = toreal(threatHunterInfo_policyId_d), threatHunterInfo_processGuid_s = tostring(threatHunterInfo_processGuid_s), threatHunterInfo_processPath_s = tostring(threatHunterInfo_processPath_s), threatHunterInfo_reportName_s = tostring(threatHunterInfo_reportName_s), threatHunterInfo_reportId_s = tostring(threatHunterInfo_reportId_s), threatHunterInfo_reputation_s = tostring(threatHunterInfo_reputation_s), threatHunterInfo_responseAlarmId_g = tostring(threatHunterInfo_responseAlarmId_g), threatHunterInfo_responseSeverity_d = toreal(threatHunterInfo_responseSeverity_d), threatHunterInfo_runState_s = tostring(threatHunterInfo_runState_s), threatHunterInfo_sha256_s = tostring(threatHunterInfo_sha256_s), threatHunterInfo_targetPriority_s = tostring(threatHunterInfo_targetPriority_s), threatHunterInfo_threatCause_reason_s = tostring(threatHunterInfo_threatCause_reason_s), threatHunterInfo_threatCause_actorProcessPPid_s = tostring(threatHunterInfo_threatCause_actorProcessPPid_s), threatHunterInfo_threatCause_parentGuid_s = tostring(threatHunterInfo_threatCause_parentGuid_s), threatHunterInfo_threatCause_causeEventId_s = tostring(threatHunterInfo_threatCause_causeEventId_s), threatHunterInfo_threatCause_reputation_s = tostring(threatHunterInfo_threatCause_reputation_s), threatHunterInfo_threatCause_actor_s = tostring(threatHunterInfo_threatCause_actor_s), threatHunterInfo_threatCause_threatCategory_s = tostring(threatHunterInfo_threatCause_threatCategory_s), workflow_status_s = tostring(workflow_status_s), watchlists_s = tostring(watchlists_s), org_key_s = tostring(org_key_s), childproc_guid_s = tostring(childproc_guid_s), blocked_effective_reputation_s = tostring(blocked_effective_reputation_s), childproc_cmdline_s = tostring(childproc_cmdline_s), attack_tactic_s = tostring(attack_tactic_s), childproc_sha256_s = tostring(childproc_sha256_s), first_event_timestamp_t = todatetime(first_event_timestamp_t), parent_reputation_s = tostring(parent_reputation_s), run_state_s = tostring(run_state_s), mdr_alert_b = tobool(mdr_alert_b), detection_timestamp_t = todatetime(detection_timestamp_t), parent_pid_d = toreal(parent_pid_d), threatHunterInfo_policyId_s = tostring(threatHunterInfo_policyId_s), device_internal_ip_s = tostring(device_internal_ip_s), reason_s = tostring(reason_s), alert_url_s = tostring(alert_url_s), id_g = tostring(id_g), process_cmdline_s = tostring(process_cmdline_s), childproc_username_s = tostring(childproc_username_s), process_username_s = tostring(process_username_s), ttps_s = tostring(ttps_s), blocked_name_s = tostring(blocked_name_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), threatHunterInfo_md5_s = tostring(threatHunterInfo_md5_s), threatHunterInfo_iocId_s = tostring(threatHunterInfo_iocId_s), deviceInfo_uemId_g = tostring(deviceInfo_uemId_g), threat_id_s = tostring(threat_id_s), threatHunterInfo_threatId_s = tostring(threatHunterInfo_threatId_s), rule_id_g = tostring(rule_id_g), attack_technique_s = tostring(attack_technique_s), rule_category_id_g = tostring(rule_category_id_g), ioc_id_g = tostring(ioc_id_g), childproc_name_s = tostring(childproc_name_s), blocked_sha256_s = tostring(blocked_sha256_s), primary_event_id_g = tostring(primary_event_id_g), childproc_effective_reputation_s = tostring(childproc_effective_reputation_s), ruleName_s = tostring(ruleName_s), process_guid_s = tostring(process_guid_s), report_tags_s = tostring(report_tags_s), parent_cmdline_s = tostring(parent_cmdline_s), parent_guid_s = tostring(parent_guid_s), device_target_value_s = tostring(device_target_value_s), ioc_hit_s = tostring(ioc_hit_s), device_external_ip_s = tostring(device_external_ip_s), device_policy_id_d = toreal(device_policy_id_d), device_os_version_s = tostring(device_os_version_s), policy_applied_s = tostring(policy_applied_s), parent_effective_reputation_s = tostring(parent_effective_reputation_s), process_name_s = tostring(process_name_s), version_s = tostring(version_s), device_location_s = tostring(device_location_s), report_description_s = tostring(report_description_s), threat_id_g = tostring(threat_id_g), is_updated_b = tobool(is_updated_b), parent_username_s = tostring(parent_username_s), device_name_s = tostring(device_name_s), alert_notes_present_b = tobool(alert_notes_present_b), parent_sha256_s = tostring(parent_sha256_s), report_link_s = tostring(report_link_s), reason_code_s = tostring(reason_code_s), report_id_s = tostring(report_id_s), ml_classification_final_verdict_s = tostring(ml_classification_final_verdict_s), threatHunterInfo_processPath_d = toreal(threatHunterInfo_processPath_d), device_policy_s = tostring(device_policy_s), device_os_s = tostring(device_os_s), ml_classification_global_prevalence_s = tostring(ml_classification_global_prevalence_s), primary_event_id_s = tostring(primary_event_id_s), process_pid_d = toreal(process_pid_d), determination_value_s = tostring(determination_value_s), determination_change_timestamp_t = todatetime(determination_change_timestamp_t), ioc_id_s = tostring(ioc_id_s), process_issuer_s = tostring(process_issuer_s), Severity = toint(Severity), process_sha256_s = tostring(process_sha256_s), process_reputation_s = tostring(process_reputation_s), parent_md5_g = tostring(parent_md5_g), report_name_s = tostring(report_name_s), backend_timestamp_t = todatetime(backend_timestamp_t), eventTime_d = toreal(eventTime_d)'
        outputStream: 'Custom-CarbonBlackNotifications_CL'
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
