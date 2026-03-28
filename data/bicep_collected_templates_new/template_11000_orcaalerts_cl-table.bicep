// Bicep template for Log Analytics custom table: OrcaAlerts_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 82, Deployed columns: 79 (Type column filtered)
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

resource orcaalertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'OrcaAlerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'OrcaAlerts_CL'
      description: 'Custom table OrcaAlerts_CL - imported from JSON schema'
      displayName: 'OrcaAlerts_CL'
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
          dataTypeHint: 0
        }
        {
          name: 'findings_s_cve_cvss3_score_d'
          type: 'real'
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
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'dateTime'
        }
        {
          name: 'findings_s_account_iam_policy_user_creation_time_t'
          type: 'dateTime'
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
          type: 'dateTime'
        }
        {
          name: 'findings_s_cve_cve_id_s'
          type: 'string'
        }
        {
          name: 'findings_s_cve_score_d'
          type: 'real'
        }
        {
          name: 'score_d'
          type: 'real'
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
          type: 'real'
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
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'findings_s_malware_sha1_s'
          type: 'string'
        }
        {
          name: 'time_t'
          type: 'dateTime'
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
}

output tableName string = orcaalertsclTable.name
output tableId string = orcaalertsclTable.id
output provisioningState string = orcaalertsclTable.properties.provisioningState
