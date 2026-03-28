// Bicep template for Log Analytics custom table: BetterMTDDeviceLog_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 25, Deployed columns: 23 (Type column filtered)
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

resource bettermtddevicelogclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BetterMTDDeviceLog_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BetterMTDDeviceLog_CL'
      description: 'Custom table BetterMTDDeviceLog_CL - imported from JSON schema'
      displayName: 'BetterMTDDeviceLog_CL'
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
          name: 'AddedDate'
          type: 'dateTime'
        }
        {
          name: 'ThreatScore'
          type: 'real'
        }
        {
          name: 'ThreatLevel'
          type: 'string'
        }
        {
          name: 'IsDeleted'
          type: 'boolean'
        }
        {
          name: 'UserEmail'
          type: 'string'
        }
        {
          name: 'CompanyName'
          type: 'string'
        }
        {
          name: 'LocationID'
          type: 'real'
        }
        {
          name: 'LastReported'
          type: 'dateTime'
        }
        {
          name: 'DevicePlatform'
          type: 'string'
        }
        {
          name: 'CompanyId'
          type: 'real'
        }
        {
          name: 'DeviceOS'
          type: 'string'
        }
        {
          name: 'DeviceId'
          type: 'real'
        }
        {
          name: 'Manufacturer'
          type: 'string'
        }
        {
          name: 'BuildNumber'
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
          name: 'AgentVersion'
          type: 'string'
        }
        {
          name: 'DeviceUDID'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bettermtddevicelogclTable.name
output tableId string = bettermtddevicelogclTable.id
output provisioningState string = bettermtddevicelogclTable.properties.provisioningState
