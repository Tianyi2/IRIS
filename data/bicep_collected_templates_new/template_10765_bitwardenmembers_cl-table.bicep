// Bicep template for Log Analytics custom table: BitwardenMembers_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 5, Deployed columns: 5 (Type column filtered)
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

resource bitwardenmembersclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitwardenMembers_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitwardenMembers_CL'
      description: 'Custom table BitwardenMembers_CL - imported from JSON schema'
      displayName: 'BitwardenMembers_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'memberId'
          type: 'string'
        }
        {
          name: 'userId'
          type: 'string'
          dataTypeHint: 1
        }
        {
          name: 'email'
          type: 'string'
        }
        {
          name: 'name'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bitwardenmembersclTable.name
output tableId string = bitwardenmembersclTable.id
output provisioningState string = bitwardenmembersclTable.properties.provisioningState
