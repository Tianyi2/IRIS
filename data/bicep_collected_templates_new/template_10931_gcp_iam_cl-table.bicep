// Bicep template for Log Analytics custom table: GCP_IAM_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 77, Deployed columns: 77 (Type column filtered)
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

resource gcpiamclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GCP_IAM_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GCP_IAM_CL'
      description: 'Custom table GCP_IAM_CL - imported from JSON schema'
      displayName: 'GCP_IAM_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'payload_status_code_d'
          type: 'real'
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
          dataTypeHint: 2
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'payload_response_private_key_type_d'
          type: 'real'
        }
        {
          name: 'payload_response_key_origin_d'
          type: 'real'
        }
        {
          name: 'payload_response_key_type_d'
          type: 'real'
        }
        {
          name: 'payload_response_valid_after_time_seconds_d'
          type: 'real'
        }
        {
          name: 'payload_response_valid_before_time_seconds_d'
          type: 'real'
        }
        {
          name: 'payload_request_private_key_type_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'payload_request_remove_deleted_service_accounts_b'
          type: 'boolean'
        }
        {
          name: 'payload_request_page_size_d'
          type: 'real'
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
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'boolean'
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
}

output tableName string = gcpiamclTable.name
output tableId string = gcpiamclTable.id
output provisioningState string = gcpiamclTable.properties.provisioningState
