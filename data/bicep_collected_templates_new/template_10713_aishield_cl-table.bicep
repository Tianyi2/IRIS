// Bicep template for Log Analytics custom table: AIShield_CL
// Generated on 2025-09-19 14:13:48 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 15 (Type column filtered)
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

resource aishieldclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'AIShield_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'AIShield_CL'
      description: 'Custom table AIShield_CL - imported from JSON schema'
      displayName: 'AIShield_CL'
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
          type: 'string'
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
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'probability'
          type: 'real'
        }
        {
          name: 'RawMessage'
          type: 'string'
        }
        {
          name: 'service_name'
          type: 'string'
        }
        {
          name: 'asset_id'
          type: 'string'
        }
        {
          name: 'source_name'
          type: 'string'
        }
        {
          name: 'attack_name'
          type: 'string'
        }
        {
          name: 'timestamp'
          type: 'dateTime'
        }
        {
          name: 'SuspiciousLevel'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = aishieldclTable.name
output tableId string = aishieldclTable.id
output provisioningState string = aishieldclTable.properties.provisioningState
