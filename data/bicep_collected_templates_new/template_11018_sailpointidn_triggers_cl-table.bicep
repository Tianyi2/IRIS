// Bicep template for Log Analytics custom table: SailPointIDN_Triggers_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 54, Deployed columns: 54 (Type column filtered)
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

resource sailpointidntriggersclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SailPointIDN_Triggers_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SailPointIDN_Triggers_CL'
      description: 'Custom table SailPointIDN_Triggers_CL - imported from JSON schema'
      displayName: 'SailPointIDN_Triggers_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Body_attributes_created_t'
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'Body_searchResults_Identity_noun_s'
          type: 'boolean'
        }
        {
          name: 'Body_searchResults_Identity_preview_s'
          type: 'boolean'
        }
        {
          name: 'Body_signedS3Url_s'
          type: 'boolean'
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
          type: 'dateTime'
        }
        {
          name: 'Body_stats_added_d'
          type: 'real'
        }
        {
          name: 'Body_stats_changed_d'
          type: 'real'
        }
        {
          name: 'Body_stats_removed_d'
          type: 'real'
        }
        {
          name: 'Body_stats_scanned_d'
          type: 'real'
        }
        {
          name: 'Body_stats_unchanged_d'
          type: 'real'
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
          type: 'dateTime'
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
          type: 'boolean'
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
          type: 'dateTime'
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
}

output tableName string = sailpointidntriggersclTable.name
output tableId string = sailpointidntriggersclTable.id
output provisioningState string = sailpointidntriggersclTable.properties.provisioningState
