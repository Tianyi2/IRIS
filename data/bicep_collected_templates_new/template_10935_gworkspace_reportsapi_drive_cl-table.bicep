// Bicep template for Log Analytics custom table: GWorkspace_ReportsAPI_drive_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 33, Deployed columns: 33 (Type column filtered)
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

resource gworkspacereportsapidriveclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GWorkspace_ReportsAPI_drive_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GWorkspace_ReportsAPI_drive_CL'
      description: 'Custom table GWorkspace_ReportsAPI_drive_CL - imported from JSON schema'
      displayName: 'GWorkspace_ReportsAPI_drive_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'actor_profileId_s'
          type: 'string'
        }
        {
          name: 'actor_email_s'
          type: 'string'
        }
        {
          name: 'etag_s'
          type: 'string'
        }
        {
          name: 'id_customerId_s'
          type: 'string'
        }
        {
          name: 'id_applicationName_s'
          type: 'string'
        }
        {
          name: 'id_uniqueQualifier_s'
          type: 'string'
        }
        {
          name: 'id_time_t'
          type: 'dateTime'
        }
        {
          name: 'kind_s'
          type: 'string'
        }
        {
          name: 'target_domain_s'
          type: 'string'
        }
        {
          name: 'old_visibility_s'
          type: 'string'
        }
        {
          name: 'target_user_s'
          type: 'string'
        }
        {
          name: 'visibility_change_s'
          type: 'string'
        }
        {
          name: 'owner_s'
          type: 'string'
        }
        {
          name: 'originating_app_id_s'
          type: 'string'
        }
        {
          name: 'visibility_s'
          type: 'string'
        }
        {
          name: 'doc_title_s'
          type: 'string'
        }
        {
          name: 'doc_type_s'
          type: 'string'
        }
        {
          name: 'doc_id_s'
          type: 'string'
        }
        {
          name: 'event_name_s'
          type: 'string'
        }
        {
          name: 'source_folder_id_s'
          type: 'string'
        }
        {
          name: 'source_folder_title_s'
          type: 'string'
        }
        {
          name: 'destination_folder_id_s'
          type: 'string'
        }
        {
          name: 'destination_folder_title_s'
          type: 'string'
        }
        {
          name: 'new_value_s'
          type: 'string'
        }
        {
          name: 'old_value_s'
          type: 'string'
        }
        {
          name: 'team_drive_id_s'
          type: 'string'
        }
        {
          name: 'ishared_drive_id_s'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'events_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = gworkspacereportsapidriveclTable.name
output tableId string = gworkspacereportsapidriveclTable.id
output provisioningState string = gworkspacereportsapidriveclTable.properties.provisioningState
