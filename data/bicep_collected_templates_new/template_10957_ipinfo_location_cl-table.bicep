// Bicep template for Log Analytics custom table: Ipinfo_Location_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 11, Deployed columns: 11 (Type column filtered)
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

resource ipinfolocationclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Ipinfo_Location_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Ipinfo_Location_CL'
      description: 'Custom table Ipinfo_Location_CL - imported from JSON schema'
      displayName: 'Ipinfo_Location_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'city'
          type: 'string'
        }
        {
          name: 'country'
          type: 'string'
        }
        {
          name: 'geoname_id'
          type: 'string'
        }
        {
          name: 'lat'
          type: 'string'
        }
        {
          name: 'lng'
          type: 'string'
        }
        {
          name: 'postal_code'
          type: 'string'
        }
        {
          name: 'region'
          type: 'string'
        }
        {
          name: 'region_code'
          type: 'string'
        }
        {
          name: 'range'
          type: 'string'
        }
        {
          name: 'timezone'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ipinfolocationclTable.name
output tableId string = ipinfolocationclTable.id
output provisioningState string = ipinfolocationclTable.properties.provisioningState
