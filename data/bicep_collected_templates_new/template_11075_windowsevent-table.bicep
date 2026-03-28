// Bicep template for Log Analytics custom table: WindowsEvent
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 25, Deployed columns: 24 (Type column filtered)
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

resource windowseventTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'WindowsEvent'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'WindowsEvent'
      description: 'Custom table WindowsEvent - imported from JSON schema'
      displayName: 'WindowsEvent'
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
          name: 'EventOriginId'
          type: 'string'
        }
        {
          name: 'EventID'
          type: 'int'
        }
        {
          name: 'RawEventData'
          type: 'string'
        }
        {
          name: 'EventData'
          type: 'dynamic'
        }
        {
          name: 'Data'
          type: 'dynamic'
        }
        {
          name: 'EventRecordId'
          type: 'string'
        }
        {
          name: 'SystemThreadId'
          type: 'int'
        }
        {
          name: 'SystemProcessId'
          type: 'int'
        }
        {
          name: 'Correlation'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Keywords'
          type: 'string'
        }
        {
          name: 'Version'
          type: 'int'
        }
        {
          name: 'SystemUserId'
          type: 'string'
        }
        {
          name: 'EventLevelName'
          type: 'string'
        }
        {
          name: 'EventLevel'
          type: 'int'
        }
        {
          name: 'Task'
          type: 'int'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'Channel'
          type: 'string'
        }
        {
          name: 'Provider'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'Opcode'
          type: 'string'
        }
        {
          name: 'TimeCreated'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = windowseventTable.name
output tableId string = windowseventTable.id
output provisioningState string = windowseventTable.properties.provisioningState
