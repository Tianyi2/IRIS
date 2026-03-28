// Bicep template for Log Analytics custom table: TransmitSecurityAdminActivity_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 9, Deployed columns: 9 (Type column filtered)
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

resource transmitsecurityadminactivityclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TransmitSecurityAdminActivity_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TransmitSecurityAdminActivity_CL'
      description: 'Custom table TransmitSecurityAdminActivity_CL - imported from JSON schema'
      displayName: 'TransmitSecurityAdminActivity_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'activity'
          type: 'string'
        }
        {
          name: 'actor_id'
          type: 'string'
        }
        {
          name: 'actor_type'
          type: 'string'
        }
        {
          name: 'ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'target_resource_id'
          type: 'string'
        }
        {
          name: 'target_resource_type'
          type: 'string'
        }
        {
          name: 'timestamp'
          type: 'dateTime'
        }
        {
          name: 'user_agent'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = transmitsecurityadminactivityclTable.name
output tableId string = transmitsecurityadminactivityclTable.id
output provisioningState string = transmitsecurityadminactivityclTable.properties.provisioningState
