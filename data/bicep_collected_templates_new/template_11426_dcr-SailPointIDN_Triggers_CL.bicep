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
// Data Collection Rule for SailPointIDN_Triggers_CL
// ============================================================================
// Generated: 2025-09-19 14:20:30
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 54, DCR columns: 54 (Type column always filtered)
// Output stream: Custom-SailPointIDN_Triggers_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SailPointIDN_Triggers_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SailPointIDN_Triggers_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Body_attributes_created_t'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Account_noun_s'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Account_preview_s'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Entitlement_count_s'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Entitlement_noun_s'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Entitlement_preview_s'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Identity_count_s'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Identity_noun_s'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Identity_preview_s'
            type: 'string'
          }
          {
            name: 'Body_signedS3Url_s'
            type: 'string'
          }
          {
            name: 'Body_source_id_g'
            type: 'string'
          }
          {
            name: 'Body_source_name_s'
            type: 'string'
          }
          {
            name: 'Body_source_type_s'
            type: 'string'
          }
          {
            name: 'Body_started_t'
            type: 'string'
          }
          {
            name: 'Body_stats_added_d'
            type: 'string'
          }
          {
            name: 'Body_stats_changed_d'
            type: 'string'
          }
          {
            name: 'Body_stats_removed_d'
            type: 'string'
          }
          {
            name: 'Body_stats_scanned_d'
            type: 'string'
          }
          {
            name: 'Body_stats_unchanged_d'
            type: 'string'
          }
          {
            name: 'Body_status_s'
            type: 'string'
          }
          {
            name: 'Body_warnings_s'
            type: 'string'
          }
          {
            name: 'Body__metadata_invocationId_g'
            type: 'string'
          }
          {
            name: 'Body__metadata_triggerType_s'
            type: 'string'
          }
          {
            name: 'Metadata_invocationId_g'
            type: 'string'
          }
          {
            name: 'Body_searchResults_Account_count_s'
            type: 'string'
          }
          {
            name: 'Metadata_triggerId_s'
            type: 'string'
          }
          {
            name: 'Body_searchName_s'
            type: 'string'
          }
          {
            name: 'Body_ownerName_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_customAttribute1_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_customAttribute2_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_department_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_displayName_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_email_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_employeeNumber_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_firstname_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_identificationNumber_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_inactive_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_isManager_b'
            type: 'string'
          }
          {
            name: 'Body_attributes_lastname_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_manager_id_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_manager_name_s'
            type: 'string'
          }
          {
            name: 'ody_attributes_manager_type_s'
            type: 'string'
          }
          {
            name: 'Body_attributes_uid_s'
            type: 'string'
          }
          {
            name: 'Body_changes_s'
            type: 'string'
          }
          {
            name: 'Body_completed_t'
            type: 'string'
          }
          {
            name: 'Body_errors_s'
            type: 'string'
          }
          {
            name: 'Body_fileName_s'
            type: 'string'
          }
          {
            name: 'Body_identity_id_g'
            type: 'string'
          }
          {
            name: 'Body_identity_name_s'
            type: 'string'
          }
          {
            name: 'Body_identity_type_s'
            type: 'string'
          }
          {
            name: 'Body_ownerEmail_s'
            type: 'string'
          }
          {
            name: 'Body_query_s'
            type: 'string'
          }
          {
            name: 'Metadata_triggerType_s'
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
          name: 'Sentinel-SailPointIDN_Triggers_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SailPointIDN_Triggers_CL']
        destinations: ['Sentinel-SailPointIDN_Triggers_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Body_attributes_created_t = todatetime(Body_attributes_created_t), Body_searchResults_Account_noun_s = tostring(Body_searchResults_Account_noun_s), Body_searchResults_Account_preview_s = tostring(Body_searchResults_Account_preview_s), Body_searchResults_Entitlement_count_s = tostring(Body_searchResults_Entitlement_count_s), Body_searchResults_Entitlement_noun_s = tostring(Body_searchResults_Entitlement_noun_s), Body_searchResults_Entitlement_preview_s = tostring(Body_searchResults_Entitlement_preview_s), Body_searchResults_Identity_count_s = tobool(Body_searchResults_Identity_count_s), Body_searchResults_Identity_noun_s = tobool(Body_searchResults_Identity_noun_s), Body_searchResults_Identity_preview_s = tobool(Body_searchResults_Identity_preview_s), Body_signedS3Url_s = tobool(Body_signedS3Url_s), Body_source_id_g = tostring(Body_source_id_g), Body_source_name_s = tostring(Body_source_name_s), Body_source_type_s = tostring(Body_source_type_s), Body_started_t = todatetime(Body_started_t), Body_stats_added_d = toreal(Body_stats_added_d), Body_stats_changed_d = toreal(Body_stats_changed_d), Body_stats_removed_d = toreal(Body_stats_removed_d), Body_stats_scanned_d = toreal(Body_stats_scanned_d), Body_stats_unchanged_d = toreal(Body_stats_unchanged_d), Body_status_s = tostring(Body_status_s), Body_warnings_s = tostring(Body_warnings_s), Body__metadata_invocationId_g = todatetime(Body__metadata_invocationId_g), Body__metadata_triggerType_s = tostring(Body__metadata_triggerType_s), Metadata_invocationId_g = tostring(Metadata_invocationId_g), Body_searchResults_Account_count_s = tostring(Body_searchResults_Account_count_s), Metadata_triggerId_s = tostring(Metadata_triggerId_s), Body_searchName_s = tostring(Body_searchName_s), Body_ownerName_s = tostring(Body_ownerName_s), Body_attributes_customAttribute1_s = tostring(Body_attributes_customAttribute1_s), Body_attributes_customAttribute2_s = tostring(Body_attributes_customAttribute2_s), Body_attributes_department_s = tostring(Body_attributes_department_s), Body_attributes_displayName_s = tostring(Body_attributes_displayName_s), Body_attributes_email_s = tostring(Body_attributes_email_s), Body_attributes_employeeNumber_s = tostring(Body_attributes_employeeNumber_s), Body_attributes_firstname_s = tostring(Body_attributes_firstname_s), Body_attributes_identificationNumber_s = tostring(Body_attributes_identificationNumber_s), Body_attributes_inactive_s = tostring(Body_attributes_inactive_s), Body_attributes_isManager_b = tobool(Body_attributes_isManager_b), Body_attributes_lastname_s = tostring(Body_attributes_lastname_s), Body_attributes_manager_id_s = tostring(Body_attributes_manager_id_s), Body_attributes_manager_name_s = tostring(Body_attributes_manager_name_s), ody_attributes_manager_type_s = tostring(ody_attributes_manager_type_s), Body_attributes_uid_s = tostring(Body_attributes_uid_s), Body_changes_s = tostring(Body_changes_s), Body_completed_t = todatetime(Body_completed_t), Body_errors_s = tostring(Body_errors_s), Body_fileName_s = tostring(Body_fileName_s), Body_identity_id_g = tostring(Body_identity_id_g), Body_identity_name_s = tostring(Body_identity_name_s), Body_identity_type_s = tostring(Body_identity_type_s), Body_ownerEmail_s = tostring(Body_ownerEmail_s), Body_query_s = tostring(Body_query_s), Metadata_triggerType_s = tostring(Metadata_triggerType_s)'
        outputStream: 'Custom-SailPointIDN_Triggers_CL'
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
