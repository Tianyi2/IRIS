// Bicep template for Log Analytics custom table: TheomAlerts_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 23 (Type column filtered)
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

resource theomalertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TheomAlerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TheomAlerts_CL'
      description: 'Custom table TheomAlerts_CL - imported from JSON schema'
      displayName: 'TheomAlerts_CL'
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
          name: 'customProps_TheomRemoteId_s'
          type: 'string'
        }
        {
          name: 'customProps_RulePriority_s'
          type: 'string'
        }
        {
          name: 'customProps_RuleId_s'
          type: 'string'
        }
        {
          name: 'customProps_RemediationIds_s'
          type: 'string'
        }
        {
          name: 'customProps_Region_s'
          type: 'string'
        }
        {
          name: 'customProps_NumTriggered_s'
          type: 'string'
        }
        {
          name: 'customProps_LastTriggered_s'
          type: 'string'
        }
        {
          name: 'customProps_AssetType_s'
          type: 'string'
        }
        {
          name: 'customProps_AssetName_s'
          type: 'string'
        }
        {
          name: 'customProps_AssetNERValue_s'
          type: 'string'
        }
        {
          name: 'customProps_AssetDeepLink_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'customProps_AssetCriticalityReason_s'
          type: 'string'
        }
        {
          name: 'customProps_AssetCriticality_s'
          type: 'string'
        }
        {
          name: 'accountId_s'
          type: 'string'
        }
        {
          name: 'priority_s'
          type: 'string'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
        {
          name: 'details_s'
          type: 'string'
        }
        {
          name: 'summary_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'customProps_TheomRule_s'
          type: 'string'
        }
        {
          name: 'deepLink_s'
          type: 'string'
          dataTypeHint: 0
        }
      ]
    }
  }
}

output tableName string = theomalertsclTable.name
output tableId string = theomalertsclTable.id
output provisioningState string = theomalertsclTable.properties.provisioningState
