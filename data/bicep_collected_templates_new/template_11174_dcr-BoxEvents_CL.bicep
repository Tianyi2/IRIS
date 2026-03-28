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
// Data Collection Rule for BoxEvents_CL
// ============================================================================
// Generated: 2025-09-19 14:19:58
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 72, DCR columns: 70 (Type column always filtered)
// Output stream: Custom-BoxEvents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BoxEvents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BoxEvents_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'additional_details_advancedFolderSettings_oldOwnerOnlyInvite_b'
            type: 'string'
          }
          {
            name: 'source_owned_by_login_s'
            type: 'string'
          }
          {
            name: 'created_by_type_s'
            type: 'string'
          }
          {
            name: 'created_by_id_s'
            type: 'string'
          }
          {
            name: 'created_by_name_s'
            type: 'string'
          }
          {
            name: 'created_by_login_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'event_id_g'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'ip_address_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'additional_details_size_d'
            type: 'string'
          }
          {
            name: 'additional_details_ekm_id_g'
            type: 'string'
          }
          {
            name: 'additional_details_version_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_service_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_service_name_s'
            type: 'string'
          }
          {
            name: 'source_type_s'
            type: 'string'
          }
          {
            name: 'source_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_collab_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_type_s'
            type: 'string'
          }
          {
            name: 'accessible_by_login_s'
            type: 'string'
          }
          {
            name: 'accessible_by_name_s'
            type: 'string'
          }
          {
            name: 'accessible_by_id_s'
            type: 'string'
          }
          {
            name: 'accessible_by_type_s'
            type: 'string'
          }
          {
            name: 'source_owned_by_name_s'
            type: 'string'
          }
          {
            name: 'source_user_name_s'
            type: 'string'
          }
          {
            name: 'source_folder_name_s'
            type: 'string'
          }
          {
            name: 'source_folder_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_shared_link_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_access_token_identifier_s'
            type: 'string'
          }
          {
            name: 'source_login_s'
            type: 'string'
          }
          {
            name: 'source_name_s'
            type: 'string'
          }
          {
            name: 'source_user_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_role_s'
            type: 'string'
          }
          {
            name: 'source_owned_by_id_s'
            type: 'string'
          }
          {
            name: 'source_parent_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_advancedFolderSettings_newOwnerOnlyInvite_b'
            type: 'string'
          }
          {
            name: 'source_item_name_g'
            type: 'string'
          }
          {
            name: 'additional_details_metadata_type_s'
            type: 'string'
          }
          {
            name: 'additional_details_metadata_operationParams_s'
            type: 'string'
          }
          {
            name: 'additional_details_task_due_at_t'
            type: 'string'
          }
          {
            name: 'action_by_type_s'
            type: 'string'
          }
          {
            name: 'action_by_id_s'
            type: 'string'
          }
          {
            name: 'action_by_name_s'
            type: 'string'
          }
          {
            name: 'action_by_login_s'
            type: 'string'
          }
          {
            name: 'additional_details_annotation_id_d'
            type: 'string'
          }
          {
            name: 'additional_details_group_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_group_name_s'
            type: 'string'
          }
          {
            name: 'source_user_email_s'
            type: 'string'
          }
          {
            name: 'additional_details_comment_id_d'
            type: 'string'
          }
          {
            name: 'additional_details_message_s'
            type: 'string'
          }
          {
            name: 'additional_details_task_id_d'
            type: 'string'
          }
          {
            name: 'additional_details_task_message_s'
            type: 'string'
          }
          {
            name: 'source_parent_name_s'
            type: 'string'
          }
          {
            name: 'source_parent_type_s'
            type: 'string'
          }
          {
            name: 'source_item_name_s'
            type: 'string'
          }
          {
            name: 'source_item_id_s'
            type: 'string'
          }
          {
            name: 'source_item_type_s'
            type: 'string'
          }
          {
            name: 'source_parent_name_g'
            type: 'string'
          }
          {
            name: 'source_owned_by_type_s'
            type: 'string'
          }
          {
            name: 'source_file_name_s'
            type: 'string'
          }
          {
            name: 'additional_details_task_assignment_message_s'
            type: 'string'
          }
          {
            name: 'additional_details_task_assignment_status_s'
            type: 'string'
          }
          {
            name: 'additional_details_task_assignment_assigned_to_login_s'
            type: 'string'
          }
          {
            name: 'additional_details_task_assignment_assigned_to_id_d'
            type: 'string'
          }
          {
            name: 'additional_details_task_created_by_login_s'
            type: 'string'
          }
          {
            name: 'additional_details_task_created_by_id_d'
            type: 'string'
          }
          {
            name: 'source_file_id_s'
            type: 'string'
          }
          {
            name: 'additional_details_is_performed_by_admin_b'
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
          name: 'Sentinel-BoxEvents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BoxEvents_CL']
        destinations: ['Sentinel-BoxEvents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), additional_details_advancedFolderSettings_oldOwnerOnlyInvite_b = tobool(additional_details_advancedFolderSettings_oldOwnerOnlyInvite_b), source_owned_by_login_s = tostring(source_owned_by_login_s), created_by_type_s = tostring(created_by_type_s), created_by_id_s = tostring(created_by_id_s), created_by_name_s = tostring(created_by_name_s), created_by_login_s = tostring(created_by_login_s), created_at_t = todatetime(created_at_t), event_id_g = tostring(event_id_g), event_type_s = tostring(event_type_s), ip_address_s = tostring(ip_address_s), type_s = tostring(type_s), additional_details_size_d = toreal(additional_details_size_d), additional_details_ekm_id_g = tostring(additional_details_ekm_id_g), additional_details_version_id_s = tostring(additional_details_version_id_s), additional_details_service_id_s = tostring(additional_details_service_id_s), additional_details_service_name_s = tostring(additional_details_service_name_s), source_type_s = tostring(source_type_s), source_id_s = tostring(source_id_s), additional_details_collab_id_s = tostring(additional_details_collab_id_s), additional_details_type_s = tostring(additional_details_type_s), accessible_by_login_s = tostring(accessible_by_login_s), accessible_by_name_s = tostring(accessible_by_name_s), accessible_by_id_s = tostring(accessible_by_id_s), accessible_by_type_s = tostring(accessible_by_type_s), source_owned_by_name_s = tostring(source_owned_by_name_s), source_user_name_s = tostring(source_user_name_s), source_folder_name_s = tostring(source_folder_name_s), source_folder_id_s = tostring(source_folder_id_s), additional_details_shared_link_id_s = tostring(additional_details_shared_link_id_s), additional_details_access_token_identifier_s = tostring(additional_details_access_token_identifier_s), source_login_s = tostring(source_login_s), source_name_s = tostring(source_name_s), source_user_id_s = tostring(source_user_id_s), additional_details_role_s = tostring(additional_details_role_s), source_owned_by_id_s = tostring(source_owned_by_id_s), source_parent_id_s = tostring(source_parent_id_s), additional_details_advancedFolderSettings_newOwnerOnlyInvite_b = tobool(additional_details_advancedFolderSettings_newOwnerOnlyInvite_b), source_item_name_g = tostring(source_item_name_g), additional_details_metadata_type_s = tostring(additional_details_metadata_type_s), additional_details_metadata_operationParams_s = tostring(additional_details_metadata_operationParams_s), additional_details_task_due_at_t = todatetime(additional_details_task_due_at_t), action_by_type_s = tostring(action_by_type_s), action_by_id_s = tostring(action_by_id_s), action_by_name_s = tostring(action_by_name_s), action_by_login_s = tostring(action_by_login_s), additional_details_annotation_id_d = toreal(additional_details_annotation_id_d), additional_details_group_id_s = tostring(additional_details_group_id_s), additional_details_group_name_s = tostring(additional_details_group_name_s), source_user_email_s = tostring(source_user_email_s), additional_details_comment_id_d = toreal(additional_details_comment_id_d), additional_details_message_s = tostring(additional_details_message_s), additional_details_task_id_d = toreal(additional_details_task_id_d), additional_details_task_message_s = tostring(additional_details_task_message_s), source_parent_name_s = tostring(source_parent_name_s), source_parent_type_s = tostring(source_parent_type_s), source_item_name_s = tostring(source_item_name_s), source_item_id_s = tostring(source_item_id_s), source_item_type_s = tostring(source_item_type_s), source_parent_name_g = tostring(source_parent_name_g), source_owned_by_type_s = tostring(source_owned_by_type_s), source_file_name_s = tostring(source_file_name_s), additional_details_task_assignment_message_s = tostring(additional_details_task_assignment_message_s), additional_details_task_assignment_status_s = tostring(additional_details_task_assignment_status_s), additional_details_task_assignment_assigned_to_login_s = tostring(additional_details_task_assignment_assigned_to_login_s), additional_details_task_assignment_assigned_to_id_d = toreal(additional_details_task_assignment_assigned_to_id_d), additional_details_task_created_by_login_s = tostring(additional_details_task_created_by_login_s), additional_details_task_created_by_id_d = toreal(additional_details_task_created_by_id_d), source_file_id_s = tostring(source_file_id_s), additional_details_is_performed_by_admin_b = tobool(additional_details_is_performed_by_admin_b)'
        outputStream: 'Custom-BoxEvents_CL'
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
