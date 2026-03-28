// Bicep template for Log Analytics custom table: CitrixAnalytics_riskScoreChange_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 10, Deployed columns: 10 (Type column filtered)
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

resource citrixanalyticsriskscorechangeclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CitrixAnalytics_riskScoreChange_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CitrixAnalytics_riskScoreChange_CL'
      description: 'Custom table CitrixAnalytics_riskScoreChange_CL - imported from JSON schema'
      displayName: 'CitrixAnalytics_riskScoreChange_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'cur_riskscore_d'
          type: 'real'
        }
        {
          name: 'entity_id_s'
          type: 'string'
        }
        {
          name: 'entity_type_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'tenant_id_s'
          type: 'string'
        }
        {
          name: 'version_d'
          type: 'real'
        }
        {
          name: 'alert_type_s'
          type: 'string'
        }
        {
          name: 'alert_value_s'
          type: 'string'
        }
        {
          name: 'alert_message_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = citrixanalyticsriskscorechangeclTable.name
output tableId string = citrixanalyticsriskscorechangeclTable.id
output provisioningState string = citrixanalyticsriskscorechangeclTable.properties.provisioningState
