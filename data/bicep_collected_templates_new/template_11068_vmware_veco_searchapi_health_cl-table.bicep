// Bicep template for Log Analytics custom table: VMware_VECO_SearchAPI_Health_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 3, Deployed columns: 3 (Type column filtered)
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

resource vmwarevecosearchapihealthclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'VMware_VECO_SearchAPI_Health_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'VMware_VECO_SearchAPI_Health_CL'
      description: 'Custom table VMware_VECO_SearchAPI_Health_CL - imported from JSON schema'
      displayName: 'VMware_VECO_SearchAPI_Health_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'data'
          type: 'dynamic'
        }
        {
          name: 'metadata'
          type: 'dynamic'
        }
      ]
    }
  }
}

output tableName string = vmwarevecosearchapihealthclTable.name
output tableId string = vmwarevecosearchapihealthclTable.id
output provisioningState string = vmwarevecosearchapihealthclTable.properties.provisioningState
