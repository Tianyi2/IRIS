// Bicep template for Log Analytics custom table: BitwardenEventLogs_CL
// Generated on 2025-09-19 14:13:50 UTC
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

resource bitwardeneventlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitwardenEventLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitwardenEventLogs_CL'
      description: 'Custom table BitwardenEventLogs_CL - imported from JSON schema'
      displayName: 'BitwardenEventLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'eventType'
          type: 'int'
        }
        {
          name: 'itemId'
          type: 'string'
        }
        {
          name: 'collectionId'
          type: 'string'
        }
        {
          name: 'groupId'
          type: 'string'
        }
        {
          name: 'policyId'
          type: 'string'
        }
        {
          name: 'memberId'
          type: 'string'
        }
        {
          name: 'actingUserId'
          type: 'string'
        }
        {
          name: 'installationId'
          type: 'string'
        }
        {
          name: 'device'
          type: 'int'
        }
        {
          name: 'ipAddress'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = bitwardeneventlogsclTable.name
output tableId string = bitwardeneventlogsclTable.id
output provisioningState string = bitwardeneventlogsclTable.properties.provisioningState
