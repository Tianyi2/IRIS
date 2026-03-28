// Bicep template for Log Analytics custom table: WizIssuesV2_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 4, Deployed columns: 4 (Type column filtered)
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

resource wizissuesv2clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'WizIssuesV2_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'WizIssuesV2_CL'
      description: 'Custom table WizIssuesV2_CL - imported from JSON schema'
      displayName: 'WizIssuesV2_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'sourceRule_id_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'id_g'
          type: 'guid'
          dataTypeHint: 1
        }
      ]
    }
  }
}

output tableName string = wizissuesv2clTable.name
output tableId string = wizissuesv2clTable.id
output provisioningState string = wizissuesv2clTable.properties.provisioningState
