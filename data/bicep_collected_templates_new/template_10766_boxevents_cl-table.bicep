// Bicep template for Log Analytics custom table: BoxEvents_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 72, Deployed columns: 70 (Type column filtered)
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

resource boxeventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BoxEvents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BoxEvents_CL'
      description: 'Custom table BoxEvents_CL - imported from JSON schema'
      displayName: 'BoxEvents_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'additional_details_advancedFolderSettings_oldOwnerOnlyInvite_b'
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'real'
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
          dataTypeHint: 0
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
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'additional_details_message_s'
          type: 'string'
        }
        {
          name: 'additional_details_task_id_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'additional_details_task_created_by_login_s'
          type: 'string'
        }
        {
          name: 'additional_details_task_created_by_id_d'
          type: 'real'
        }
        {
          name: 'source_file_id_s'
          type: 'string'
        }
        {
          name: 'additional_details_is_performed_by_admin_b'
          type: 'boolean'
        }
      ]
    }
  }
}

output tableName string = boxeventsclTable.name
output tableId string = boxeventsclTable.id
output provisioningState string = boxeventsclTable.properties.provisioningState
