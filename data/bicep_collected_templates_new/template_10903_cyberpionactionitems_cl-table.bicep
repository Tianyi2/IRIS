// Bicep template for Log Analytics custom table: CyberpionActionItems_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 17 (Type column filtered)
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

resource cyberpionactionitemsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CyberpionActionItems_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CyberpionActionItems_CL'
      description: 'Custom table CyberpionActionItems_CL - imported from JSON schema'
      displayName: 'CyberpionActionItems_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'host_s'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'title_s'
          type: 'string'
        }
        {
          name: 'urgency_d'
          type: 'real'
        }
        {
          name: 'is_open_b'
          type: 'boolean'
        }
        {
          name: 'impact_s'
          type: 'string'
        }
        {
          name: 'summary_s'
          type: 'string'
        }
        {
          name: 'solution_s'
          type: 'string'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'technical_details_s'
          type: 'string'
        }
        {
          name: 'opening_datetime_t'
          type: 'dateTime'
        }
        {
          name: 'is_acknowledged_b'
          type: 'boolean'
        }
        {
          name: 'acknowledged_by_s'
          type: 'string'
        }
        {
          name: 'acknowledged_reason_s'
          type: 'string'
        }
        {
          name: 'acknowledged_date_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = cyberpionactionitemsclTable.name
output tableId string = cyberpionactionitemsclTable.id
output provisioningState string = cyberpionactionitemsclTable.properties.provisioningState
