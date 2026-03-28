// Bicep template for Log Analytics custom table: OnePasswordEventLogs_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 28, Deployed columns: 28 (Type column filtered)
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

resource onepasswordeventlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'OnePasswordEventLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'OnePasswordEventLogs_CL'
      description: 'Custom table OnePasswordEventLogs_CL - imported from JSON schema'
      displayName: 'OnePasswordEventLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'item_uuid'
          type: 'string'
        }
        {
          name: 'vault_uuid'
          type: 'string'
        }
        {
          name: 'used_version'
          type: 'int'
        }
        {
          name: 'session'
          type: 'dynamic'
        }
        {
          name: 'aux_info'
          type: 'string'
        }
        {
          name: 'aux_details'
          type: 'dynamic'
        }
        {
          name: 'aux_uuid'
          type: 'string'
        }
        {
          name: 'aux_id'
          type: 'int'
        }
        {
          name: 'object_details'
          type: 'dynamic'
        }
        {
          name: 'object_uuid'
          type: 'string'
        }
        {
          name: 'object_Type'
          type: 'string'
        }
        {
          name: 'user'
          type: 'dynamic'
        }
        {
          name: 'action'
          type: 'string'
        }
        {
          name: 'actor_uuid'
          type: 'string'
        }
        {
          name: 'location'
          type: 'dynamic'
        }
        {
          name: 'client'
          type: 'dynamic'
        }
        {
          name: 'target_user'
          type: 'dynamic'
        }
        {
          name: 'details'
          type: 'dynamic'
        }
        {
          name: 'action_Type'
          type: 'string'
        }
        {
          name: 'category'
          type: 'string'
        }
        {
          name: 'country'
          type: 'string'
        }
        {
          name: 'timestamp'
          type: 'dateTime'
        }
        {
          name: 'session_uuid'
          type: 'string'
        }
        {
          name: 'uuid_s'
          type: 'string'
        }
        {
          name: 'actor_details'
          type: 'dynamic'
        }
        {
          name: 'log_source'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = onepasswordeventlogsclTable.name
output tableId string = onepasswordeventlogsclTable.id
output provisioningState string = onepasswordeventlogsclTable.properties.provisioningState
