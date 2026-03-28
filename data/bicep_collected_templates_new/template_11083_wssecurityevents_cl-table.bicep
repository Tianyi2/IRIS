// Bicep template for Log Analytics custom table: WsSecurityEvents_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 16, Deployed columns: 16 (Type column filtered)
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

resource wssecurityeventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'WsSecurityEvents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'WsSecurityEvents_CL'
      description: 'Custom table WsSecurityEvents_CL - imported from JSON schema'
      displayName: 'WsSecurityEvents_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Activity'
          type: 'string'
        }
        {
          name: 'AdditionalExtensions'
          type: 'string'
        }
        {
          name: 'DeviceAction'
          type: 'string'
        }
        {
          name: 'DeviceCustomString1'
          type: 'string'
        }
        {
          name: 'DeviceCustomString1Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomString2'
          type: 'string'
        }
        {
          name: 'DeviceCustomString2Label'
          type: 'string'
        }
        {
          name: 'DeviceEventClassID'
          type: 'string'
        }
        {
          name: 'DeviceVendor'
          type: 'string'
        }
        {
          name: 'LogSeverity'
          type: 'int'
        }
        {
          name: 'Message'
          type: 'string'
        }
        {
          name: 'SimplifiedDeviceAction'
          type: 'string'
        }
        {
          name: 'SourceHostName'
          type: 'string'
        }
        {
          name: 'SourceUserName'
          type: 'string'
        }
        {
          name: 'PersistenceTimestamp'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = wssecurityeventsclTable.name
output tableId string = wssecurityeventsclTable.id
output provisioningState string = wssecurityeventsclTable.properties.provisioningState
