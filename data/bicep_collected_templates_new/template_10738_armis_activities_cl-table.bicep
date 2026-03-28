// Bicep template for Log Analytics custom table: Armis_Activities_CL
// Generated on 2025-09-19 14:13:48 UTC
// Source: JSON schema export
// Original columns: 20, Deployed columns: 17 (Type column filtered)
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

resource armisactivitiesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Armis_Activities_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Armis_Activities_CL'
      description: 'Custom table Armis_Activities_CL - imported from JSON schema'
      displayName: 'Armis_Activities_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'ActivityUUID'
          type: 'string'
        }
        {
          name: 'Content'
          type: 'string'
        }
        {
          name: 'Protocol'
          type: 'string'
        }
        {
          name: 'SensorName'
          type: 'string'
        }
        {
          name: 'SensorType'
          type: 'string'
        }
        {
          name: 'SiteLocation'
          type: 'string'
        }
        {
          name: 'SiteName'
          type: 'string'
        }
        {
          name: 'Title'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = armisactivitiesclTable.name
output tableId string = armisactivitiesclTable.id
output provisioningState string = armisactivitiesclTable.properties.provisioningState
