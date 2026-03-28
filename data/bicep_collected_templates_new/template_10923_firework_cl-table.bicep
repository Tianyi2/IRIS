// Bicep template for Log Analytics custom table: Firework_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 7, Deployed columns: 7 (Type column filtered)
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

resource fireworkclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Firework_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Firework_CL'
      description: 'Custom table Firework_CL - imported from JSON schema'
      displayName: 'Firework_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'source_s'
          type: 'string'
        }
        {
          name: 'data_new_leaks_s'
          type: 'string'
        }
        {
          name: 'risk_score_d'
          type: 'string'
        }
        {
          name: 'last_crawled_at_t'
          type: 'string'
        }
        {
          name: 'category_name_s'
          type: 'string'
        }
        {
          name: 'risk_reasons_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = fireworkclTable.name
output tableId string = fireworkclTable.id
output provisioningState string = fireworkclTable.properties.provisioningState
