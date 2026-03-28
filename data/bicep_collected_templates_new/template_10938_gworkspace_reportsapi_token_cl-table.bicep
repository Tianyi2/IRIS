// Bicep template for Log Analytics custom table: GWorkspace_ReportsAPI_token_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 20, Deployed columns: 20 (Type column filtered)
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

resource gworkspacereportsapitokenclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GWorkspace_ReportsAPI_token_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GWorkspace_ReportsAPI_token_CL'
      description: 'Custom table GWorkspace_ReportsAPI_token_CL - imported from JSON schema'
      displayName: 'GWorkspace_ReportsAPI_token_CL'
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
          name: 'events_s'
          type: 'string'
        }
        {
          name: 'id_time_t'
          type: 'dateTime'
        }
        {
          name: 'client_type_s'
          type: 'string'
        }
        {
          name: 'app_name_s'
          type: 'string'
        }
        {
          name: 'client_id_s'
          type: 'string'
        }
        {
          name: 'event_name_s'
          type: 'string'
        }
        {
          name: 'scope_s'
          type: 'string'
        }
        {
          name: 'scope_data_s'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'kind_s'
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

output tableName string = gworkspacereportsapitokenclTable.name
output tableId string = gworkspacereportsapitokenclTable.id
output provisioningState string = gworkspacereportsapitokenclTable.properties.provisioningState
