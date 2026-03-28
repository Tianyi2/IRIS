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
// Data Collection Rule for TaniumThreatResponse_CL
// ============================================================================
// Generated: 2025-09-19 14:20:34
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 69, DCR columns: 68 (Type column always filtered)
// Output stream: Custom-TaniumThreatResponse_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TaniumThreatResponse_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TaniumThreatResponse_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'Match_Details_match_properties_parent_ppid_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'Match_Details_match_properties_start_time_s'
            type: 'string'
          }
          {
            name: 'Match_Details_match_properties_start_time_t'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'Impact_Score_d'
            type: 'string'
          }
          {
            name: 'Impact_Score_s'
            type: 'string'
          }
          {
            name: 'Intel_Id_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'Match_Details_finding_source_name_s'
            type: 'string'
          }
          {
            name: 'Match_Details_finding_system_info_bits_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'Match_Details_match_contexts_s'
            type: 'string'
          }
          {
            name: 'Match_Details_match_hash_d'
            type: 'string'
          }
          {
            name: 'Match_Details_finding_first_seen_t'
            type: 'string'
          }
          {
            name: 'Timestamp_t'
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
          name: 'Sentinel-TaniumThreatResponse_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TaniumThreatResponse_CL']
        destinations: ['Sentinel-TaniumThreatResponse_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Alert_Id_g = tostring(Alert_Id_g), Match_Details_match_properties_file_md5_s = tostring(Match_Details_match_properties_file_md5_s), Match_Details_match_properties_fullpath_s = tostring(Match_Details_match_properties_fullpath_s), Match_Details_match_properties_md5_g = tostring(Match_Details_match_properties_md5_g), Match_Details_match_properties_md5_s = tostring(Match_Details_match_properties_md5_s), Match_Details_match_properties_name_s = tostring(Match_Details_match_properties_name_s), Match_Details_match_properties_parent_args_s = tostring(Match_Details_match_properties_parent_args_s), Match_Details_match_properties_parent_file_s = tostring(Match_Details_match_properties_parent_file_s), Match_Details_match_properties_parent_name_s = tostring(Match_Details_match_properties_parent_name_s), Match_Details_match_properties_parent_parent_s = tostring(Match_Details_match_properties_parent_parent_s), Match_Details_match_properties_parent_pid_d = toreal(Match_Details_match_properties_parent_pid_d), Match_Details_match_properties_parent_ppid_d = toreal(Match_Details_match_properties_parent_ppid_d), Match_Details_match_properties_parent_recorder_unique_id_s = tostring(Match_Details_match_properties_parent_recorder_unique_id_s), Match_Details_match_properties_parent_start_time_s = tostring(Match_Details_match_properties_parent_start_time_s), Match_Details_match_properties_parent_start_time_t = todatetime(Match_Details_match_properties_parent_start_time_t), Match_Details_match_properties_file_md5_g = tostring(Match_Details_match_properties_file_md5_g), Match_Details_match_properties_parent_user_s = tostring(Match_Details_match_properties_parent_user_s), Match_Details_match_properties_ppid_d = toreal(Match_Details_match_properties_ppid_d), Match_Details_match_properties_recorder_unique_id_s = tostring(Match_Details_match_properties_recorder_unique_id_s), Match_Details_match_properties_sha1_s = tostring(Match_Details_match_properties_sha1_s), Match_Details_match_properties_sha256_s = tostring(Match_Details_match_properties_sha256_s), Match_Details_match_properties_size_d = toreal(Match_Details_match_properties_size_d), Match_Details_match_properties_start_time_s = tostring(Match_Details_match_properties_start_time_s), Match_Details_match_properties_start_time_t = todatetime(Match_Details_match_properties_start_time_t), Match_Details_match_properties_user_s = tostring(Match_Details_match_properties_user_s), Match_Details_match_source_s = tostring(Match_Details_match_source_s), Match_Details_match_type_s = tostring(Match_Details_match_type_s), Match_Details_match_version_d = toreal(Match_Details_match_version_d), Match_Details_service_id_g = tostring(Match_Details_service_id_g), MITRE_Techniques_s = tostring(MITRE_Techniques_s), RawData = tostring(RawData), Match_Details_match_properties_pid_d = toreal(Match_Details_match_properties_pid_d), Timestamp_s = tostring(Timestamp_s), Match_Details_match_properties_file_fullpath_s = tostring(Match_Details_match_properties_file_fullpath_s), Match_Details_match_properties_args_s = tostring(Match_Details_match_properties_args_s), Computer = tostring(Computer), Computer_IP_s = tostring(Computer_IP_s), Computer_Name_s = tostring(Computer_Name_s), fake_b = tobool(fake_b), Impact_Score_d = toreal(Impact_Score_d), Impact_Score_s = tostring(Impact_Score_s), Intel_Id_d = toreal(Intel_Id_d), Intel_Labels_s = tostring(Intel_Labels_s), Intel_Name_s = tostring(Intel_Name_s), Intel_Type_s = tostring(Intel_Type_s), Match_Details_finding_artifact_artifact_hash_s = tostring(Match_Details_finding_artifact_artifact_hash_s), Match_Details_finding_artifact_instance_hash_s = tostring(Match_Details_finding_artifact_instance_hash_s), Match_Details_finding_artifact_windows_defender_event_event_s = tostring(Match_Details_finding_artifact_windows_defender_event_event_s), Match_Details_finding_artifact_windows_defender_event_timestamp_ms_s = tostring(Match_Details_finding_artifact_windows_defender_event_timestamp_ms_s), Match_Details_match_properties_cwd_s = tostring(Match_Details_match_properties_cwd_s), Match_Details_finding_description_s = tostring(Match_Details_finding_description_s), Match_Details_finding_hunt_id_s = tostring(Match_Details_finding_hunt_id_s), Match_Details_finding_intel_id_s = tostring(Match_Details_finding_intel_id_s), Match_Details_finding_last_seen_t = todatetime(Match_Details_finding_last_seen_t), Match_Details_finding_source_name_s = tostring(Match_Details_finding_source_name_s), Match_Details_finding_system_info_bits_d = toreal(Match_Details_finding_system_info_bits_d), Match_Details_finding_system_info_build_number_s = tostring(Match_Details_finding_system_info_build_number_s), Match_Details_finding_system_info_os_s = tostring(Match_Details_finding_system_info_os_s), Match_Details_finding_system_info_patch_level_s = tostring(Match_Details_finding_system_info_patch_level_s), Match_Details_finding_system_info_platform_s = tostring(Match_Details_finding_system_info_platform_s), Match_Details_finding_threat_id_s = tostring(Match_Details_finding_threat_id_s), Match_Details_finding_whats_s = tostring(Match_Details_finding_whats_s), Match_Details_hash_d = toreal(Match_Details_hash_d), Match_Details_match_contexts_s = tostring(Match_Details_match_contexts_s), Match_Details_match_hash_d = toreal(Match_Details_match_hash_d), Match_Details_finding_first_seen_t = todatetime(Match_Details_finding_first_seen_t), Timestamp_t = todatetime(Timestamp_t)'
        outputStream: 'Custom-TaniumThreatResponse_CL'
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
