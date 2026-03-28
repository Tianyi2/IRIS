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
// Data Collection Rule for PaloAltoPrismaCloudAlert_CL
// ============================================================================
// Generated: 2025-09-19 14:20:28
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 74, DCR columns: 72 (Type column always filtered)
// Output stream: Custom-PaloAltoPrismaCloudAlert_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-PaloAltoPrismaCloudAlert_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-PaloAltoPrismaCloudAlert_CL': {
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
            name: 'resource_url_s'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-PaloAltoPrismaCloudAlert_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-PaloAltoPrismaCloudAlert_CL']
        destinations: ['Sentinel-PaloAltoPrismaCloudAlert_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), resource_url_s = tostring(resource_url_s), resource_resourceApiName_s = tostring(resource_resourceApiName_s), resource_resourceType_s = tostring(resource_resourceType_s), resource_regionId_s = tostring(resource_regionId_s), resource_region_s = tostring(resource_region_s), resource_cloudAccountGroups_s = tostring(resource_cloudAccountGroups_s), resource_data_arn_s = tostring(resource_data_arn_s), resource_accountId_s = tostring(resource_accountId_s), resource_name_s = tostring(resource_name_s), resource_id_s = tostring(resource_id_s), resource_rrn_s = tostring(resource_rrn_s), resource_data_access_key_2_last_used_service_s = tostring(resource_data_access_key_2_last_used_service_s), resource_data_access_key_1_last_used_service_s = tostring(resource_data_access_key_1_last_used_service_s), resource_data_access_key_2_last_used_region_s = tostring(resource_data_access_key_2_last_used_region_s), resource_account_s = tostring(resource_account_s), resource_data_access_key_1_last_used_region_s = tostring(resource_data_access_key_1_last_used_region_s), resource_data_user_s = tostring(resource_data_user_s), resource_additionalInfo_inactiveSinceTs_s = tostring(resource_additionalInfo_inactiveSinceTs_s), firstSeen_s = tostring(firstSeen_s), status_s = tostring(status_s), riskDetail_score_s = tostring(riskDetail_score_s), riskDetail_rating_s = tostring(riskDetail_rating_s), riskDetail_riskScore_maxScore_s = tostring(riskDetail_riskScore_maxScore_s), riskDetail_riskScore_score_s = tostring(riskDetail_riskScore_score_s), resource_additionalInfo_accessKeyAge_s = tostring(resource_additionalInfo_accessKeyAge_s), alertRules_s = tostring(alertRules_s), policy_systemDefault_s = tostring(policy_systemDefault_s), policy_policyType_s = tostring(policy_policyType_s), policy_policyId_s = tostring(policy_policyId_s), id_s = tostring(id_s), resource_resourceTs_s = tostring(resource_resourceTs_s), resource_cloudType_s = tostring(resource_cloudType_s), policy_remediable_s = tostring(policy_remediable_s), lastSeen_s = tostring(lastSeen_s), resource_data_access_key_2_last_used_date_s = tostring(resource_data_access_key_2_last_used_date_s), resource_data_access_key_2_last_rotated_s = tostring(resource_data_access_key_2_last_rotated_s), policy_lastModifiedBy_s = tostring(policy_lastModifiedBy_s), policy_lastModifiedOn_s = tostring(policy_lastModifiedOn_s), policy_labels_s = tostring(policy_labels_s), policy_recommendation_s = tostring(policy_recommendation_s), policy_severity_s = tostring(policy_severity_s), policy_description_s = tostring(policy_description_s), policy_deleted_s = tostring(policy_deleted_s), policy_name_s = tostring(policy_name_s), resource_id_g = tostring(resource_id_g), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), reason_s = tostring(reason_s), resource_data_access_key_1_last_used_date_s = tostring(resource_data_access_key_1_last_used_date_s), policy_remediation_description_s = tostring(policy_remediation_description_s), policy_remediation_cliScriptTemplate_s = tostring(policy_remediation_cliScriptTemplate_s), resource_data_access_key_1_last_rotated_s = tostring(resource_data_access_key_1_last_rotated_s), resource_data_password_next_rotation_s = tostring(resource_data_password_next_rotation_s), resource_data_password_last_changed_s = tostring(resource_data_password_last_changed_s), resource_data_cert_2_last_rotated_s = tostring(resource_data_cert_2_last_rotated_s), resource_data_cert_1_last_rotated_s = tostring(resource_data_cert_1_last_rotated_s), resource_data_access_key_2_active_s = tostring(resource_data_access_key_2_active_s), policy_remediation_impact_s = tostring(policy_remediation_impact_s), resource_data_access_key_1_active_s = tostring(resource_data_access_key_1_active_s), resource_data_password_last_used_s = tostring(resource_data_password_last_used_s), resource_data_password_enabled_s = tostring(resource_data_password_enabled_s), resource_data_cert_2_active_s = tostring(resource_data_cert_2_active_s), resource_data_cert_1_active_s = tostring(resource_data_cert_1_active_s), resource_data_mfa_active_s = tostring(resource_data_mfa_active_s), history_s = tostring(history_s), resource_data_user_creation_time_s = tostring(resource_data_user_creation_time_s), alertTime_s = tostring(alertTime_s)'
        outputStream: 'Custom-PaloAltoPrismaCloudAlert_CL'
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
