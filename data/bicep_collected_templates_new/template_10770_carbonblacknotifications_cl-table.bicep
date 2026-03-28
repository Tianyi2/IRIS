// Bicep template for Log Analytics custom table: CarbonBlackNotifications_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 170, Deployed columns: 167 (Type column filtered)
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

resource carbonblacknotificationsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CarbonBlackNotifications_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CarbonBlackNotifications_CL'
      description: 'Custom table CarbonBlackNotifications_CL - imported from JSON schema'
      displayName: 'CarbonBlackNotifications_CL'
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
          type: 'real'
        }
        {
          name: 'threatHunterInfo_summary_s'
          type: 'string'
        }
        {
          name: 'threatHunterInfo_time_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          type: 'boolean'
        }
        {
          name: 'process_md5_g'
          type: 'string'
        }
        {
          name: 'device_id_d'
          type: 'real'
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
          type: 'dateTime'
        }
        {
          name: 'last_event_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'threatInfo_incidentId_g'
          type: 'string'
        }
        {
          name: 'threatInfo_score_d'
          type: 'real'
        }
        {
          name: 'threatInfo_summary_s'
          type: 'string'
        }
        {
          name: 'threatHunterInfo_dismissed_b'
          type: 'boolean'
        }
        {
          name: 'threatHunterInfo_documentGuid_s'
          type: 'string'
        }
        {
          name: 'threatHunterInfo_firstActivityTime_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'threatHunterInfo_orgId_d'
          type: 'real'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
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
          dataTypeHint: 3
        }
        {
          name: 'deviceInfo_externalIpAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'deviceInfo_targetPriorityCode_d'
          type: 'real'
        }
        {
          name: 'deviceInfo_groupName_s'
          type: 'string'
        }
        {
          name: 'deviceInfo_deviceId_d'
          type: 'real'
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
          type: 'dateTime'
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
          type: 'real'
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
          type: 'real'
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
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'detection_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'parent_pid_d'
          type: 'real'
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
          dataTypeHint: 0
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
          type: 'real'
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
          type: 'boolean'
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
          type: 'boolean'
        }
        {
          name: 'parent_sha256_s'
          type: 'string'
        }
        {
          name: 'report_link_s'
          type: 'string'
          dataTypeHint: 0
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'determination_value_s'
          type: 'string'
        }
        {
          name: 'determination_change_timestamp_t'
          type: 'dateTime'
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
          type: 'int'
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
          type: 'dateTime'
        }
        {
          name: 'eventTime_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = carbonblacknotificationsclTable.name
output tableId string = carbonblacknotificationsclTable.id
output provisioningState string = carbonblacknotificationsclTable.properties.provisioningState
