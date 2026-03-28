// Bicep template for Log Analytics custom table: GWorkspace_ReportsAPI_mobile_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 31, Deployed columns: 31 (Type column filtered)
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

resource gworkspacereportsapimobileclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GWorkspace_ReportsAPI_mobile_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GWorkspace_ReportsAPI_mobile_CL'
      description: 'Custom table GWorkspace_ReportsAPI_mobile_CL - imported from JSON schema'
      displayName: 'GWorkspace_ReportsAPI_mobile_CL'
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
          name: 'actor_profileId_s'
          type: 'string'
        }
        {
          name: 'actor_email_s'
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
          name: 'IOS_VENDOR_ID_g'
          type: 'string'
        }
        {
          name: 'OS_VERSION_s'
          type: 'string'
        }
        {
          name: 'IOS_VENDOR_ID_s'
          type: 'string'
        }
        {
          name: 'RESOURCE_ID_s'
          type: 'string'
        }
        {
          name: 'DEVICE_MODEL_s'
          type: 'string'
        }
        {
          name: 'DEVICE_TYPE_s'
          type: 'string'
        }
        {
          name: 'SERIAL_NUMBER_s'
          type: 'string'
        }
        {
          name: 'DEVICE_ID_g'
          type: 'string'
        }
        {
          name: 'USER_EMAIL_s'
          type: 'string'
        }
        {
          name: 'event_name_s'
          type: 'string'
        }
        {
          name: 'REGISTER_PRIVILEGE_s'
          type: 'string'
        }
        {
          name: 'ACCOUNT_STATE_s'
          type: 'string'
        }
        {
          name: 'LAST_SYNC_AUDIT_DATE_s'
          type: 'string'
        }
        {
          name: 'OS_PROPERTY_s'
          type: 'string'
        }
        {
          name: 'NEW_VALUE_s'
          type: 'string'
        }
        {
          name: 'OLD_VALUE_s'
          type: 'string'
        }
        {
          name: 'DEVICE_ID_s'
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

output tableName string = gworkspacereportsapimobileclTable.name
output tableId string = gworkspacereportsapimobileclTable.id
output provisioningState string = gworkspacereportsapimobileclTable.properties.provisioningState
