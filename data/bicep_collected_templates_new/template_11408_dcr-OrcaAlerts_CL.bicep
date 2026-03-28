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
// Data Collection Rule for OrcaAlerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:28
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 82, DCR columns: 79 (Type column always filtered)
// Output stream: Custom-OrcaAlerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-OrcaAlerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-OrcaAlerts_CL': {
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
            name: 'findings_s_os_end_of_support_end_support_s'
            type: 'string'
          }
          {
            name: 'findings_s_os_end_of_support_release_nice_s'
            type: 'string'
          }
          {
            name: 'findings_s_os_end_of_support_distro_nice_s'
            type: 'string'
          }
          {
            name: 'findings_s_os_end_of_support_release_s'
            type: 'string'
          }
          {
            name: 'findings_s_os_end_of_support_distro_s'
            type: 'string'
          }
          {
            name: 'findings_s_os_end_of_support_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_weak_password_os_username_s'
            type: 'string'
          }
          {
            name: 'findings_s_weak_password_os_labels_s'
            type: 'string'
          }
          {
            name: 'findings_s_weak_password_os_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_weak_password_os_password_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_labels_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_source_link_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_cvss3_score_d'
            type: 'string'
          }
          {
            name: 'findings_s_cve_affected_packages_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_cvss3_vector_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_user_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_arn_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_mfa_active_b'
            type: 'string'
          }
          {
            name: 'findings_s_non_corporate_auth_key_file_s'
            type: 'string'
          }
          {
            name: 'findings_s_non_corporate_auth_key_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_acl_public_acl_s'
            type: 'string'
          }
          {
            name: 'findings_s_acl_details_s'
            type: 'string'
          }
          {
            name: 'findings_s_acl_description_s'
            type: 'string'
          }
          {
            name: 'findings_s_acl_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cloudtrail_user_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cloudtrail_user_agent_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cloudtrail_event_time_t'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cloudtrail_event_source_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cloudtrail_event_id_g'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_password_last_used_t'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_user_creation_time_t'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cis_aws_control_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cis_aws_version_s'
            type: 'string'
          }
          {
            name: 'findings_s_account_iam_policy_cloudtrail_source_ip_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_published_t'
            type: 'string'
          }
          {
            name: 'findings_s_cve_cve_id_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_score_d'
            type: 'string'
          }
          {
            name: 'score_d'
            type: 'string'
          }
          {
            name: 'alert_id_s'
            type: 'string'
          }
          {
            name: 'asset_state_s'
            type: 'string'
          }
          {
            name: 'vm_id_s'
            type: 'string'
          }
          {
            name: 'cluster_type_s'
            type: 'string'
          }
          {
            name: 'cluster_name_s'
            type: 'string'
          }
          {
            name: 'asset_type_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'asset_name_s'
            type: 'string'
          }
          {
            name: 'cloud_provider_id_d'
            type: 'string'
          }
          {
            name: 'MG_s'
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
            name: 'asset_unique_id_s'
            type: 'string'
          }
          {
            name: 'findings_s_non_corporate_auth_key_keys_s'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'findings_s_cve_summary_s'
            type: 'string'
          }
          {
            name: 'Type_s'
            type: 'string'
          }
          {
            name: 'vm_id_g'
            type: 'string'
          }
          {
            name: 'asset_name_g'
            type: 'string'
          }
          {
            name: 'findings_s_malware_labels_s'
            type: 'string'
          }
          {
            name: 'findings_s_malware_md5_g'
            type: 'string'
          }
          {
            name: 'findings_s_malware_modification_time_t'
            type: 'string'
          }
          {
            name: 'recommendation_s'
            type: 'string'
          }
          {
            name: 'findings_s_malware_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_malware_sha256_s'
            type: 'string'
          }
          {
            name: 'findings_s_malware_file_s'
            type: 'string'
          }
          {
            name: 'findings_s_malware_has_macro_b'
            type: 'string'
          }
          {
            name: 'findings_s_malware_sha1_s'
            type: 'string'
          }
          {
            name: 'time_t'
            type: 'string'
          }
          {
            name: 'alert_labels_s'
            type: 'string'
          }
          {
            name: 'alert_type_s'
            type: 'string'
          }
          {
            name: 'findings_s_malware_virus_names_s'
            type: 'string'
          }
          {
            name: 'findings_s_non_corporate_auth_key_description_s'
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
          name: 'Sentinel-OrcaAlerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-OrcaAlerts_CL']
        destinations: ['Sentinel-OrcaAlerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), findings_s_os_end_of_support_end_support_s = tostring(findings_s_os_end_of_support_end_support_s), findings_s_os_end_of_support_release_nice_s = tostring(findings_s_os_end_of_support_release_nice_s), findings_s_os_end_of_support_distro_nice_s = tostring(findings_s_os_end_of_support_distro_nice_s), findings_s_os_end_of_support_release_s = tostring(findings_s_os_end_of_support_release_s), findings_s_os_end_of_support_distro_s = tostring(findings_s_os_end_of_support_distro_s), findings_s_os_end_of_support_type_s = tostring(findings_s_os_end_of_support_type_s), findings_s_weak_password_os_username_s = tostring(findings_s_weak_password_os_username_s), findings_s_weak_password_os_labels_s = tostring(findings_s_weak_password_os_labels_s), findings_s_weak_password_os_type_s = tostring(findings_s_weak_password_os_type_s), findings_s_weak_password_os_password_s = tostring(findings_s_weak_password_os_password_s), findings_s_cve_labels_s = tostring(findings_s_cve_labels_s), findings_s_cve_source_link_s = tostring(findings_s_cve_source_link_s), findings_s_cve_cvss3_score_d = toreal(findings_s_cve_cvss3_score_d), findings_s_cve_affected_packages_s = tostring(findings_s_cve_affected_packages_s), findings_s_cve_cvss3_vector_s = tostring(findings_s_cve_cvss3_vector_s), findings_s_account_iam_policy_type_s = tostring(findings_s_account_iam_policy_type_s), findings_s_account_iam_policy_user_s = tostring(findings_s_account_iam_policy_user_s), findings_s_account_iam_policy_arn_s = tostring(findings_s_account_iam_policy_arn_s), findings_s_account_iam_policy_mfa_active_b = tobool(findings_s_account_iam_policy_mfa_active_b), findings_s_non_corporate_auth_key_file_s = tostring(findings_s_non_corporate_auth_key_file_s), findings_s_non_corporate_auth_key_type_s = tostring(findings_s_non_corporate_auth_key_type_s), findings_s_acl_public_acl_s = tostring(findings_s_acl_public_acl_s), findings_s_acl_details_s = tostring(findings_s_acl_details_s), findings_s_acl_description_s = tostring(findings_s_acl_description_s), findings_s_acl_type_s = tostring(findings_s_acl_type_s), findings_s_account_iam_policy_cloudtrail_user_type_s = tostring(findings_s_account_iam_policy_cloudtrail_user_type_s), findings_s_cve_type_s = tostring(findings_s_cve_type_s), findings_s_account_iam_policy_cloudtrail_user_agent_s = tostring(findings_s_account_iam_policy_cloudtrail_user_agent_s), findings_s_account_iam_policy_cloudtrail_event_time_t = todatetime(findings_s_account_iam_policy_cloudtrail_event_time_t), findings_s_account_iam_policy_cloudtrail_event_source_s = tostring(findings_s_account_iam_policy_cloudtrail_event_source_s), findings_s_account_iam_policy_cloudtrail_event_id_g = tostring(findings_s_account_iam_policy_cloudtrail_event_id_g), findings_s_account_iam_policy_password_last_used_t = todatetime(findings_s_account_iam_policy_password_last_used_t), findings_s_account_iam_policy_user_creation_time_t = todatetime(findings_s_account_iam_policy_user_creation_time_t), findings_s_account_iam_policy_cis_aws_control_s = tostring(findings_s_account_iam_policy_cis_aws_control_s), findings_s_account_iam_policy_cis_aws_version_s = tostring(findings_s_account_iam_policy_cis_aws_version_s), findings_s_account_iam_policy_cloudtrail_source_ip_s = tostring(findings_s_account_iam_policy_cloudtrail_source_ip_s), findings_s_cve_published_t = todatetime(findings_s_cve_published_t), findings_s_cve_cve_id_s = tostring(findings_s_cve_cve_id_s), findings_s_cve_score_d = toreal(findings_s_cve_score_d), score_d = toreal(score_d), alert_id_s = tostring(alert_id_s), asset_state_s = tostring(asset_state_s), vm_id_s = tostring(vm_id_s), cluster_type_s = tostring(cluster_type_s), cluster_name_s = tostring(cluster_name_s), asset_type_s = tostring(asset_type_s), description_s = tostring(description_s), asset_name_s = tostring(asset_name_s), cloud_provider_id_d = toreal(cloud_provider_id_d), MG_s = tostring(MG_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), asset_unique_id_s = tostring(asset_unique_id_s), findings_s_non_corporate_auth_key_keys_s = tostring(findings_s_non_corporate_auth_key_keys_s), details_s = tostring(details_s), source_s = tostring(source_s), findings_s_cve_summary_s = tostring(findings_s_cve_summary_s), Type_s = tostring(Type_s), vm_id_g = tostring(vm_id_g), asset_name_g = tostring(asset_name_g), findings_s_malware_labels_s = tostring(findings_s_malware_labels_s), findings_s_malware_md5_g = tostring(findings_s_malware_md5_g), findings_s_malware_modification_time_t = todatetime(findings_s_malware_modification_time_t), recommendation_s = tostring(recommendation_s), findings_s_malware_type_s = tostring(findings_s_malware_type_s), findings_s_malware_sha256_s = tostring(findings_s_malware_sha256_s), findings_s_malware_file_s = tostring(findings_s_malware_file_s), findings_s_malware_has_macro_b = tobool(findings_s_malware_has_macro_b), findings_s_malware_sha1_s = tostring(findings_s_malware_sha1_s), time_t = todatetime(time_t), alert_labels_s = tostring(alert_labels_s), alert_type_s = tostring(alert_type_s), findings_s_malware_virus_names_s = tostring(findings_s_malware_virus_names_s), findings_s_non_corporate_auth_key_description_s = tostring(findings_s_non_corporate_auth_key_description_s)'
        outputStream: 'Custom-OrcaAlerts_CL'
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
