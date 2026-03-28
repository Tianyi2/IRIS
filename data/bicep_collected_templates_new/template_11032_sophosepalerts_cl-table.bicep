// Bicep template for Log Analytics custom table: SophosEPAlerts_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 18, Deployed columns: 18 (Type column filtered)
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

resource sophosepalertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SophosEPAlerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SophosEPAlerts_CL'
      description: 'Custom table SophosEPAlerts_CL - imported from JSON schema'
      displayName: 'SophosEPAlerts_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'CustomerId'
          type: 'string'
        }
        {
          name: 'ThreatName'
          type: 'string'
        }
        {
          name: 'info'
          type: 'dynamic'
        }
        {
          name: 'Source'
          type: 'string'
        }
        {
          name: 'data'
          type: 'dynamic'
        }
        {
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'DvcHostname'
          type: 'string'
        }
        {
          name: 'threat_cleanable'
          type: 'boolean'
        }
        {
          name: 'description'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'event_service_event_id'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'Created'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = sophosepalertsclTable.name
output tableId string = sophosepalertsclTable.id
output provisioningState string = sophosepalertsclTable.properties.provisioningState
