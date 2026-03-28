// Bicep template for Log Analytics custom table: GoogleCloudSCC
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 7, Deployed columns: 6 (Type column filtered)
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

resource googlecloudsccTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GoogleCloudSCC'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GoogleCloudSCC'
      description: 'Custom table GoogleCloudSCC - imported from JSON schema'
      displayName: 'GoogleCloudSCC'
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
          name: 'Findings'
          type: 'dynamic'
        }
        {
          name: 'FindingsResource'
          type: 'dynamic'
        }
        {
          name: 'SourceProperties'
          type: 'dynamic'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = googlecloudsccTable.name
output tableId string = googlecloudsccTable.id
output provisioningState string = googlecloudsccTable.properties.provisioningState
