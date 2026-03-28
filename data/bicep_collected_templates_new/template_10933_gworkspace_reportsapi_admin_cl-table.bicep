// Bicep template for Log Analytics custom table: GWorkspace_ReportsAPI_admin_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 26, Deployed columns: 26 (Type column filtered)
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

resource gworkspacereportsapiadminclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GWorkspace_ReportsAPI_admin_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GWorkspace_ReportsAPI_admin_CL'
      description: 'Custom table GWorkspace_ReportsAPI_admin_CL - imported from JSON schema'
      displayName: 'GWorkspace_ReportsAPI_admin_CL'
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
          name: 'actor_email_s'
          type: 'string'
        }
        {
          name: 'NEW_VALUE_s'
          type: 'string'
        }
        {
          name: 'PRODUCT_NAME_s'
          type: 'string'
        }
        {
          name: 'USER_EMAIL_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'event_name_s'
          type: 'string'
        }
        {
          name: 'events_s'
          type: 'string'
        }
        {
          name: 'actor_key_s'
          type: 'string'
        }
        {
          name: 'actor_callerType_s'
          type: 'string'
        }
        {
          name: 'etag_s'
          type: 'string'
        }
        {
          name: 'actor_profileId_s'
          type: 'string'
        }
        {
          name: 'id_customerId_s'
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
          name: 'OLD_VALUE_s'
          type: 'string'
        }
        {
          name: 'ROLE_NAME_s'
          type: 'string'
        }
        {
          name: 'APPLICATION_EDITION_s'
          type: 'string'
        }
        {
          name: 'SETTING_NAME_s'
          type: 'string'
        }
        {
          name: 'ORG_UNIT_NAME_s'
          type: 'string'
        }
        {
          name: 'APPLICATION_NAME_s'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'id_applicationName_s'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = gworkspacereportsapiadminclTable.name
output tableId string = gworkspacereportsapiadminclTable.id
output provisioningState string = gworkspacereportsapiadminclTable.properties.provisioningState
