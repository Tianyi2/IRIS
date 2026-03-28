// Bicep template for Log Analytics custom table: CognniIncidents_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 22, Deployed columns: 19 (Type column filtered)
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

resource cognniincidentsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CognniIncidents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CognniIncidents_CL'
      description: 'Custom table CognniIncidents_CL - imported from JSON schema'
      displayName: 'CognniIncidents_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'attachmentId_s'
          type: 'string'
        }
        {
          name: 'siteId_g'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'int'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'orgId_g'
          type: 'string'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'messageId_s'
          type: 'string'
        }
        {
          name: 'listItemUniqueId_g'
          type: 'string'
        }
        {
          name: 'listId_g'
          type: 'string'
        }
        {
          name: 'labels_s'
          type: 'string'
        }
        {
          name: 'internalEventId_g'
          type: 'string'
        }
        {
          name: 'insights_s'
          type: 'string'
        }
        {
          name: 'informationType_s'
          type: 'string'
        }
        {
          name: 'fileName_s'
          type: 'string'
        }
        {
          name: 'eventTime_t'
          type: 'dateTime'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'sourceFileExtension_s'
          type: 'string'
        }
        {
          name: 'userId_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = cognniincidentsclTable.name
output tableId string = cognniincidentsclTable.id
output provisioningState string = cognniincidentsclTable.properties.provisioningState
