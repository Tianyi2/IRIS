// Bicep template for Log Analytics custom table: DataminrPulse_Alerts_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 19, Deployed columns: 18 (Type column filtered)
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

resource dataminrpulsealertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DataminrPulse_Alerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DataminrPulse_Alerts_CL'
      description: 'Custom table DataminrPulse_Alerts_CL - imported from JSON schema'
      displayName: 'DataminrPulse_Alerts_CL'
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
          name: 'odsStatus_timestamp_d'
          type: 'real'
        }
        {
          name: 'dataMap_headlineMds_content_s'
          type: 'string'
        }
        {
          name: 'relatedAlerts_s'
          type: 'string'
        }
        {
          name: 'EventVolume'
          type: 'real'
        }
        {
          name: 'timestamp_d'
          type: 'real'
        }
        {
          name: 'location_longitude_d'
          type: 'real'
        }
        {
          name: 'watchlistsMatchedByType_s'
          type: 'string'
        }
        {
          name: 'location_latitude_d'
          type: 'real'
        }
        {
          name: 'companies_s'
          type: 'string'
        }
        {
          name: 'headline_s'
          type: 'string'
        }
        {
          name: 'availableRelatedAlerts_d'
          type: 'real'
        }
        {
          name: 'alertType_name_s'
          type: 'string'
        }
        {
          name: 'index_s'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'categories_s'
          type: 'string'
        }
        {
          name: 'location_name_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = dataminrpulsealertsclTable.name
output tableId string = dataminrpulsealertsclTable.id
output provisioningState string = dataminrpulsealertsclTable.properties.provisioningState
