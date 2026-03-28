// Bicep template for Log Analytics custom table: TaniumThreatResponse_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 69, Deployed columns: 68 (Type column filtered)
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

resource taniumthreatresponseclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TaniumThreatResponse_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TaniumThreatResponse_CL'
      description: 'Custom table TaniumThreatResponse_CL - imported from JSON schema'
      displayName: 'TaniumThreatResponse_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Alert_Id_g'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_file_md5_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_fullpath_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_md5_g'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_md5_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_name_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_args_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_file_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_name_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_parent_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_pid_d'
          type: 'real'
        }
        {
          name: 'Match_Details_match_properties_parent_ppid_d'
          type: 'real'
        }
        {
          name: 'Match_Details_match_properties_parent_recorder_unique_id_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_start_time_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_start_time_t'
          type: 'dateTime'
        }
        {
          name: 'Match_Details_match_properties_file_md5_g'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_parent_user_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_ppid_d'
          type: 'real'
        }
        {
          name: 'Match_Details_match_properties_recorder_unique_id_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_sha1_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_sha256_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_size_d'
          type: 'real'
        }
        {
          name: 'Match_Details_match_properties_start_time_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_start_time_t'
          type: 'dateTime'
        }
        {
          name: 'Match_Details_match_properties_user_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_source_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_type_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_version_d'
          type: 'real'
        }
        {
          name: 'Match_Details_service_id_g'
          type: 'string'
        }
        {
          name: 'MITRE_Techniques_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_pid_d'
          type: 'real'
        }
        {
          name: 'Timestamp_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_file_fullpath_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_args_s'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'Computer_IP_s'
          type: 'string'
        }
        {
          name: 'Computer_Name_s'
          type: 'string'
        }
        {
          name: 'fake_b'
          type: 'boolean'
        }
        {
          name: 'Impact_Score_d'
          type: 'real'
        }
        {
          name: 'Impact_Score_s'
          type: 'string'
        }
        {
          name: 'Intel_Id_d'
          type: 'real'
        }
        {
          name: 'Intel_Labels_s'
          type: 'string'
        }
        {
          name: 'Intel_Name_s'
          type: 'string'
        }
        {
          name: 'Intel_Type_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_artifact_artifact_hash_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_artifact_instance_hash_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_artifact_windows_defender_event_event_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_artifact_windows_defender_event_timestamp_ms_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_properties_cwd_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_description_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_hunt_id_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_intel_id_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_last_seen_t'
          type: 'dateTime'
        }
        {
          name: 'Match_Details_finding_source_name_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_system_info_bits_d'
          type: 'real'
        }
        {
          name: 'Match_Details_finding_system_info_build_number_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_system_info_os_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_system_info_patch_level_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_system_info_platform_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_threat_id_s'
          type: 'string'
        }
        {
          name: 'Match_Details_finding_whats_s'
          type: 'string'
        }
        {
          name: 'Match_Details_hash_d'
          type: 'real'
        }
        {
          name: 'Match_Details_match_contexts_s'
          type: 'string'
        }
        {
          name: 'Match_Details_match_hash_d'
          type: 'real'
        }
        {
          name: 'Match_Details_finding_first_seen_t'
          type: 'dateTime'
        }
        {
          name: 'Timestamp_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = taniumthreatresponseclTable.name
output tableId string = taniumthreatresponseclTable.id
output provisioningState string = taniumthreatresponseclTable.properties.provisioningState
