// Bicep template for Log Analytics custom table: Cofense_Triage_failed_indicators_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 19, Deployed columns: 17 (Type column filtered)
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

resource cofensetriagefailedindicatorsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Cofense_Triage_failed_indicators_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Cofense_Triage_failed_indicators_CL'
      description: 'Custom table Cofense_Triage_failed_indicators_CL - imported from JSON schema'
      displayName: 'Cofense_Triage_failed_indicators_CL'
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
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'kind_s'
          type: 'string'
        }
        {
          name: 'properties_source_s'
          type: 'string'
        }
        {
          name: 'properties_displayName_s'
          type: 'string'
        }
        {
          name: 'properties_confidence_d'
          type: 'real'
        }
        {
          name: 'properties_patternType_s'
          type: 'string'
        }
        {
          name: 'properties_threatTypes_s'
          type: 'string'
        }
        {
          name: 'properties_pattern_s'
          type: 'string'
        }
        {
          name: 'properties_created_t'
          type: 'dateTime'
        }
        {
          name: 'properties_externalLastUpdatedTimeUtc_t'
          type: 'dateTime'
        }
        {
          name: 'report_link_s'
          type: 'string'
          dataTypeHint: 0
        }
      ]
    }
  }
}

output tableName string = cofensetriagefailedindicatorsclTable.name
output tableId string = cofensetriagefailedindicatorsclTable.id
output provisioningState string = cofensetriagefailedindicatorsclTable.properties.provisioningState
