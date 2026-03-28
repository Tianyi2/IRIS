// Bicep template for Log Analytics custom table: Armis_Devices_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 33, Deployed columns: 30 (Type column filtered)
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

resource armisdevicesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Armis_Devices_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Armis_Devices_CL'
      description: 'Custom table Armis_Devices_CL - imported from JSON schema'
      displayName: 'Armis_Devices_CL'
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
          name: 'Tags'
          type: 'string'
        }
        {
          name: 'SiteName'
          type: 'string'
        }
        {
          name: 'SiteLocation'
          type: 'string'
        }
        {
          name: 'SensorType'
          type: 'string'
        }
        {
          name: 'SensorName'
          type: 'string'
        }
        {
          name: 'RiskLevel'
          type: 'string'
        }
        {
          name: 'PurdueLevel'
          type: 'string'
        }
        {
          name: 'PlcModule'
          type: 'string'
        }
        {
          name: 'OperatingSystem'
          type: 'string'
        }
        {
          name: 'OperatingSystemVersion'
          type: 'string'
        }
        {
          name: 'Manufacturer'
          type: 'string'
        }
        {
          name: 'Model'
          type: 'string'
        }
        {
          name: 'Visibility'
          type: 'string'
        }
        {
          name: 'MacAddress'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'Id'
          type: 'string'
        }
        {
          name: 'FirstSeen'
          type: 'string'
        }
        {
          name: 'FirmwareVersion'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'LastSeen'
          type: 'string'
        }
        {
          name: 'Name'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = armisdevicesclTable.name
output tableId string = armisdevicesclTable.id
output provisioningState string = armisdevicesclTable.properties.provisioningState
