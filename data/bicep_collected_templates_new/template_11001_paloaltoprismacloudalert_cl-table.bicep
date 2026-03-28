// Bicep template for Log Analytics custom table: PaloAltoPrismaCloudAlert_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 74, Deployed columns: 72 (Type column filtered)
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

resource paloaltoprismacloudalertclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'PaloAltoPrismaCloudAlert_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'PaloAltoPrismaCloudAlert_CL'
      description: 'Custom table PaloAltoPrismaCloudAlert_CL - imported from JSON schema'
      displayName: 'PaloAltoPrismaCloudAlert_CL'
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
          name: 'resource_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'resource_resourceApiName_s'
          type: 'string'
        }
        {
          name: 'resource_resourceType_s'
          type: 'string'
        }
        {
          name: 'resource_regionId_s'
          type: 'string'
        }
        {
          name: 'resource_region_s'
          type: 'string'
        }
        {
          name: 'resource_cloudAccountGroups_s'
          type: 'string'
        }
        {
          name: 'resource_data_arn_s'
          type: 'string'
        }
        {
          name: 'resource_accountId_s'
          type: 'string'
        }
        {
          name: 'resource_name_s'
          type: 'string'
        }
        {
          name: 'resource_id_s'
          type: 'string'
        }
        {
          name: 'resource_rrn_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_2_last_used_service_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_1_last_used_service_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_2_last_used_region_s'
          type: 'string'
        }
        {
          name: 'resource_account_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_1_last_used_region_s'
          type: 'string'
        }
        {
          name: 'resource_data_user_s'
          type: 'string'
        }
        {
          name: 'resource_additionalInfo_inactiveSinceTs_s'
          type: 'string'
        }
        {
          name: 'firstSeen_s'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'riskDetail_score_s'
          type: 'string'
        }
        {
          name: 'riskDetail_rating_s'
          type: 'string'
        }
        {
          name: 'riskDetail_riskScore_maxScore_s'
          type: 'string'
        }
        {
          name: 'riskDetail_riskScore_score_s'
          type: 'string'
        }
        {
          name: 'resource_additionalInfo_accessKeyAge_s'
          type: 'string'
        }
        {
          name: 'alertRules_s'
          type: 'string'
        }
        {
          name: 'policy_systemDefault_s'
          type: 'string'
        }
        {
          name: 'policy_policyType_s'
          type: 'string'
        }
        {
          name: 'policy_policyId_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'resource_resourceTs_s'
          type: 'string'
        }
        {
          name: 'resource_cloudType_s'
          type: 'string'
        }
        {
          name: 'policy_remediable_s'
          type: 'string'
        }
        {
          name: 'lastSeen_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_2_last_used_date_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_2_last_rotated_s'
          type: 'string'
        }
        {
          name: 'policy_lastModifiedBy_s'
          type: 'string'
        }
        {
          name: 'policy_lastModifiedOn_s'
          type: 'string'
        }
        {
          name: 'policy_labels_s'
          type: 'string'
        }
        {
          name: 'policy_recommendation_s'
          type: 'string'
        }
        {
          name: 'policy_severity_s'
          type: 'string'
        }
        {
          name: 'policy_description_s'
          type: 'string'
        }
        {
          name: 'policy_deleted_s'
          type: 'string'
        }
        {
          name: 'policy_name_s'
          type: 'string'
        }
        {
          name: 'resource_id_g'
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
          name: 'reason_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_1_last_used_date_s'
          type: 'string'
        }
        {
          name: 'policy_remediation_description_s'
          type: 'string'
        }
        {
          name: 'policy_remediation_cliScriptTemplate_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_1_last_rotated_s'
          type: 'string'
        }
        {
          name: 'resource_data_password_next_rotation_s'
          type: 'string'
        }
        {
          name: 'resource_data_password_last_changed_s'
          type: 'string'
        }
        {
          name: 'resource_data_cert_2_last_rotated_s'
          type: 'string'
        }
        {
          name: 'resource_data_cert_1_last_rotated_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_2_active_s'
          type: 'string'
        }
        {
          name: 'policy_remediation_impact_s'
          type: 'string'
        }
        {
          name: 'resource_data_access_key_1_active_s'
          type: 'string'
        }
        {
          name: 'resource_data_password_last_used_s'
          type: 'string'
        }
        {
          name: 'resource_data_password_enabled_s'
          type: 'string'
        }
        {
          name: 'resource_data_cert_2_active_s'
          type: 'string'
        }
        {
          name: 'resource_data_cert_1_active_s'
          type: 'string'
        }
        {
          name: 'resource_data_mfa_active_s'
          type: 'string'
        }
        {
          name: 'history_s'
          type: 'string'
        }
        {
          name: 'resource_data_user_creation_time_s'
          type: 'string'
        }
        {
          name: 'alertTime_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = paloaltoprismacloudalertclTable.name
output tableId string = paloaltoprismacloudalertclTable.id
output provisioningState string = paloaltoprismacloudalertclTable.properties.provisioningState
