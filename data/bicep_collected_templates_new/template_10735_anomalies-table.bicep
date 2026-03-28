// Bicep template for Log Analytics custom table: Anomalies
// Generated on 2025-09-19 14:13:48 UTC
// Source: JSON schema export
// Original columns: 36, Deployed columns: 35 (Type column filtered)
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

resource anomaliesTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Anomalies'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Anomalies'
      description: 'Custom table Anomalies - imported from JSON schema'
      displayName: 'Anomalies'
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
          name: 'ExtendedProperties'
          type: 'dynamic'
        }
        {
          name: 'Entities'
          type: 'dynamic'
        }
        {
          name: 'AnomalyReasons'
          type: 'dynamic'
        }
        {
          name: 'UserInsights'
          type: 'dynamic'
        }
        {
          name: 'DeviceInsights'
          type: 'dynamic'
        }
        {
          name: 'ActivityInsights'
          type: 'dynamic'
        }
        {
          name: 'DestinationDevice'
          type: 'string'
        }
        {
          name: 'DestinationLocation'
          type: 'dynamic'
        }
        {
          name: 'DestinationIpAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SourceDevice'
          type: 'string'
        }
        {
          name: 'SourceLocation'
          type: 'dynamic'
        }
        {
          name: 'SourceIpAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'UserPrincipalName'
          type: 'string'
        }
        {
          name: 'UserName'
          type: 'string'
        }
        {
          name: 'Techniques'
          type: 'string'
        }
        {
          name: 'Tactics'
          type: 'string'
        }
        {
          name: 'ExtendedLinks'
          type: 'dynamic'
        }
        {
          name: 'Id'
          type: 'string'
        }
        {
          name: 'WorkspaceId'
          type: 'string'
          dataTypeHint: 1
        }
        {
          name: 'VendorName'
          type: 'string'
        }
        {
          name: 'AnomalyTemplateId'
          type: 'string'
        }
        {
          name: 'AnomalyTemplateName'
          type: 'string'
        }
        {
          name: 'AnomalyTemplateVersion'
          type: 'string'
        }
        {
          name: 'AnomalyDetails'
          type: 'dynamic'
        }
        {
          name: 'RuleId'
          type: 'string'
        }
        {
          name: 'RuleName'
          type: 'string'
        }
        {
          name: 'RuleConfigVersion'
          type: 'string'
        }
        {
          name: 'Score'
          type: 'real'
        }
        {
          name: 'Description'
          type: 'string'
        }
        {
          name: 'StartTime'
          type: 'dateTime'
        }
        {
          name: 'EndTime'
          type: 'dateTime'
        }
        {
          name: 'RuleStatus'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = anomaliesTable.name
output tableId string = anomaliesTable.id
output provisioningState string = anomaliesTable.properties.provisioningState
