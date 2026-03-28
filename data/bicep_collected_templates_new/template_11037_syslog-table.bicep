// Bicep template for Log Analytics custom table: Syslog
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 16 (Type column filtered)
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

resource syslogTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Syslog'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Syslog'
      description: 'Custom table Syslog - imported from JSON schema'
      displayName: 'Syslog'
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
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'TimeCollected'
          type: 'dateTime'
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
          name: 'EventTime'
          type: 'dateTime'
        }
        {
          name: 'Facility'
          type: 'string'
        }
        {
          name: 'HostName'
          type: 'string'
        }
        {
          name: 'SeverityLevel'
          type: 'string'
        }
        {
          name: 'SyslogMessage'
          type: 'string'
        }
        {
          name: 'ProcessID'
          type: 'int'
        }
        {
          name: 'HostIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ProcessName'
          type: 'string'
        }
        {
          name: 'CollectorHostName'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = syslogTable.name
output tableId string = syslogTable.id
output provisioningState string = syslogTable.properties.provisioningState
