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
// Data Collection Rule for GCP_IAM_CL
// ============================================================================
// Generated: 2025-09-19 14:20:19
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 77, DCR columns: 77 (Type column always filtered)
// Output stream: Custom-GCP_IAM_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-GCP_IAM_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-GCP_IAM_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'payload_status_code_d'
            type: 'string'
          }
          {
            name: 'payload_response_etag_s'
            type: 'string'
          }
          {
            name: 'payload_response_name_s'
            type: 'string'
          }
          {
            name: 'payload_response_oauth2_client_id_s'
            type: 'string'
          }
          {
            name: 'payload_request_service_account_display_name_s'
            type: 'string'
          }
          {
            name: 'payload_request_service_account_description_s'
            type: 'string'
          }
          {
            name: 'payload_request_account_id_s'
            type: 'string'
          }
          {
            name: 'payload_request_name_s'
            type: 'string'
          }
          {
            name: 'payload_request__type_s'
            type: 'string'
          }
          {
            name: 'payload_resourceName_s'
            type: 'string'
          }
          {
            name: 'payload_authorizationInfo_s'
            type: 'string'
          }
          {
            name: 'payload_methodName_s'
            type: 'string'
          }
          {
            name: 'payload_serviceName_s'
            type: 'string'
          }
          {
            name: 'payload_requestMetadata_requestAttributes_time_s'
            type: 'string'
          }
          {
            name: 'payload_requestMetadata_callerSuppliedUserAgent_s'
            type: 'string'
          }
          {
            name: 'payload_requestMetadata_callerIp_s'
            type: 'string'
          }
          {
            name: 'payload_response_unique_id_s'
            type: 'string'
          }
          {
            name: 'payload_authenticationInfo_principalSubject_s'
            type: 'string'
          }
          {
            name: 'payload_response_description_s'
            type: 'string'
          }
          {
            name: 'payload_response_display_name_s'
            type: 'string'
          }
          {
            name: 'payload_request_options_requested_policy_version_d'
            type: 'string'
          }
          {
            name: 'payload_request_full_resource_name_s'
            type: 'string'
          }
          {
            name: 'resource_labels_method_s'
            type: 'string'
          }
          {
            name: 'resource_labels_location_s'
            type: 'string'
          }
          {
            name: 'resource_labels_version_s'
            type: 'string'
          }
          {
            name: 'resource_labels_service_s'
            type: 'string'
          }
          {
            name: 'payload_response_key_algorithm_d'
            type: 'string'
          }
          {
            name: 'payload_response_private_key_type_d'
            type: 'string'
          }
          {
            name: 'payload_response_key_origin_d'
            type: 'string'
          }
          {
            name: 'payload_response_key_type_d'
            type: 'string'
          }
          {
            name: 'payload_response_valid_after_time_seconds_d'
            type: 'string'
          }
          {
            name: 'payload_response_valid_before_time_seconds_d'
            type: 'string'
          }
          {
            name: 'payload_request_private_key_type_d'
            type: 'string'
          }
          {
            name: 'payload_response_email_s'
            type: 'string'
          }
          {
            name: 'payload_response__type_s'
            type: 'string'
          }
          {
            name: 'payload_response_project_id_s'
            type: 'string'
          }
          {
            name: 'payload_authenticationInfo_principalEmail_s'
            type: 'string'
          }
          {
            name: 'payload__type_s'
            type: 'string'
          }
          {
            name: 'resource_labels_unique_id_s'
            type: 'string'
          }
          {
            name: 'payload_request_view_d'
            type: 'string'
          }
          {
            name: 'payload_request_remove_deleted_service_accounts_b'
            type: 'string'
          }
          {
            name: 'payload_request_page_size_d'
            type: 'string'
          }
          {
            name: 'payload_response_auditConfigs_s'
            type: 'string'
          }
          {
            name: 'payload_response_bindings_s'
            type: 'string'
          }
          {
            name: 'payload_request_resource_s'
            type: 'string'
          }
          {
            name: 'payload_request_policy_bindings_s'
            type: 'string'
          }
          {
            name: 'payload_request_policy_etag_s'
            type: 'string'
          }
          {
            name: 'payload_request_policy_auditConfigs_s'
            type: 'string'
          }
          {
            name: 'payload_serviceData_policyDelta_bindingDeltas_s'
            type: 'string'
          }
          {
            name: 'resource_labels_topic_id_s'
            type: 'string'
          }
          {
            name: 'payload_request_update_mask_paths_s'
            type: 'string'
          }
          {
            name: 'payload_serviceData_permissionDelta_removedPermissions_s'
            type: 'string'
          }
          {
            name: 'payload_request_key_types_s'
            type: 'string'
          }
          {
            name: 'payload_status_message_s'
            type: 'string'
          }
          {
            name: 'payload_request_parent_s'
            type: 'string'
          }
          {
            name: 'payload_request_show_deleted_b'
            type: 'string'
          }
          {
            name: 'resource_labels_role_name_s'
            type: 'string'
          }
          {
            name: 'payload_serviceData__type_s'
            type: 'string'
          }
          {
            name: 'resource_labels_project_id_s'
            type: 'string'
          }
          {
            name: 'resource_labels_email_id_s'
            type: 'string'
          }
          {
            name: 'resource_type_s'
            type: 'string'
          }
          {
            name: 'timestamp_t'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'insert_id_s'
            type: 'string'
          }
          {
            name: 'log_name_s'
            type: 'string'
          }
          {
            name: 'payload_request_skip_visibility_check_b'
            type: 'string'
          }
          {
            name: 'payload_response_group_title_s'
            type: 'string'
          }
          {
            name: 'payload_response_included_permissions_s'
            type: 'string'
          }
          {
            name: 'payload_response_group_name_s'
            type: 'string'
          }
          {
            name: 'payload_request_role_id_s'
            type: 'string'
          }
          {
            name: 'payload_request_role_description_s'
            type: 'string'
          }
          {
            name: 'payload_request_role_title_s'
            type: 'string'
          }
          {
            name: 'payload_request_role_included_permissions_s'
            type: 'string'
          }
          {
            name: 'payload_serviceData_permissionDelta_addedPermissions_s'
            type: 'string'
          }
          {
            name: 'payload_response_title_s'
            type: 'string'
          }
          {
            name: 'payload_request_page_token_s'
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
          name: 'Sentinel-GCP_IAM_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-GCP_IAM_CL']
        destinations: ['Sentinel-GCP_IAM_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), payload_status_code_d = toreal(payload_status_code_d), payload_response_etag_s = tostring(payload_response_etag_s), payload_response_name_s = tostring(payload_response_name_s), payload_response_oauth2_client_id_s = tostring(payload_response_oauth2_client_id_s), payload_request_service_account_display_name_s = tostring(payload_request_service_account_display_name_s), payload_request_service_account_description_s = tostring(payload_request_service_account_description_s), payload_request_account_id_s = tostring(payload_request_account_id_s), payload_request_name_s = tostring(payload_request_name_s), payload_request__type_s = tostring(payload_request__type_s), payload_resourceName_s = tostring(payload_resourceName_s), payload_authorizationInfo_s = tostring(payload_authorizationInfo_s), payload_methodName_s = tostring(payload_methodName_s), payload_serviceName_s = tostring(payload_serviceName_s), payload_requestMetadata_requestAttributes_time_s = tostring(payload_requestMetadata_requestAttributes_time_s), payload_requestMetadata_callerSuppliedUserAgent_s = tostring(payload_requestMetadata_callerSuppliedUserAgent_s), payload_requestMetadata_callerIp_s = tostring(payload_requestMetadata_callerIp_s), payload_response_unique_id_s = tostring(payload_response_unique_id_s), payload_authenticationInfo_principalSubject_s = tostring(payload_authenticationInfo_principalSubject_s), payload_response_description_s = tostring(payload_response_description_s), payload_response_display_name_s = tostring(payload_response_display_name_s), payload_request_options_requested_policy_version_d = toreal(payload_request_options_requested_policy_version_d), payload_request_full_resource_name_s = tostring(payload_request_full_resource_name_s), resource_labels_method_s = tostring(resource_labels_method_s), resource_labels_location_s = tostring(resource_labels_location_s), resource_labels_version_s = tostring(resource_labels_version_s), resource_labels_service_s = tostring(resource_labels_service_s), payload_response_key_algorithm_d = toreal(payload_response_key_algorithm_d), payload_response_private_key_type_d = toreal(payload_response_private_key_type_d), payload_response_key_origin_d = toreal(payload_response_key_origin_d), payload_response_key_type_d = toreal(payload_response_key_type_d), payload_response_valid_after_time_seconds_d = toreal(payload_response_valid_after_time_seconds_d), payload_response_valid_before_time_seconds_d = toreal(payload_response_valid_before_time_seconds_d), payload_request_private_key_type_d = toreal(payload_request_private_key_type_d), payload_response_email_s = tostring(payload_response_email_s), payload_response__type_s = tostring(payload_response__type_s), payload_response_project_id_s = tostring(payload_response_project_id_s), payload_authenticationInfo_principalEmail_s = tostring(payload_authenticationInfo_principalEmail_s), payload__type_s = tostring(payload__type_s), resource_labels_unique_id_s = tostring(resource_labels_unique_id_s), payload_request_view_d = toreal(payload_request_view_d), payload_request_remove_deleted_service_accounts_b = tobool(payload_request_remove_deleted_service_accounts_b), payload_request_page_size_d = toreal(payload_request_page_size_d), payload_response_auditConfigs_s = tostring(payload_response_auditConfigs_s), payload_response_bindings_s = tostring(payload_response_bindings_s), payload_request_resource_s = tostring(payload_request_resource_s), payload_request_policy_bindings_s = tostring(payload_request_policy_bindings_s), payload_request_policy_etag_s = tostring(payload_request_policy_etag_s), payload_request_policy_auditConfigs_s = tostring(payload_request_policy_auditConfigs_s), payload_serviceData_policyDelta_bindingDeltas_s = tostring(payload_serviceData_policyDelta_bindingDeltas_s), resource_labels_topic_id_s = tostring(resource_labels_topic_id_s), payload_request_update_mask_paths_s = tostring(payload_request_update_mask_paths_s), payload_serviceData_permissionDelta_removedPermissions_s = tostring(payload_serviceData_permissionDelta_removedPermissions_s), payload_request_key_types_s = tostring(payload_request_key_types_s), payload_status_message_s = tostring(payload_status_message_s), payload_request_parent_s = tostring(payload_request_parent_s), payload_request_show_deleted_b = tobool(payload_request_show_deleted_b), resource_labels_role_name_s = tostring(resource_labels_role_name_s), payload_serviceData__type_s = tostring(payload_serviceData__type_s), resource_labels_project_id_s = tostring(resource_labels_project_id_s), resource_labels_email_id_s = tostring(resource_labels_email_id_s), resource_type_s = tostring(resource_type_s), timestamp_t = todatetime(timestamp_t), severity_s = tostring(severity_s), insert_id_s = tostring(insert_id_s), log_name_s = tostring(log_name_s), payload_request_skip_visibility_check_b = tobool(payload_request_skip_visibility_check_b), payload_response_group_title_s = tostring(payload_response_group_title_s), payload_response_included_permissions_s = tostring(payload_response_included_permissions_s), payload_response_group_name_s = tostring(payload_response_group_name_s), payload_request_role_id_s = tostring(payload_request_role_id_s), payload_request_role_description_s = tostring(payload_request_role_description_s), payload_request_role_title_s = tostring(payload_request_role_title_s), payload_request_role_included_permissions_s = tostring(payload_request_role_included_permissions_s), payload_serviceData_permissionDelta_addedPermissions_s = tostring(payload_serviceData_permissionDelta_addedPermissions_s), payload_response_title_s = tostring(payload_response_title_s), payload_request_page_token_s = tostring(payload_request_page_token_s)'
        outputStream: 'Custom-GCP_IAM_CL'
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
