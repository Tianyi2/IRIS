// Bicep template for Log Analytics custom table: BitsightFindings_data_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 29 (Type column filtered)
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

resource bitsightfindingsdataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitsightFindings_data_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitsightFindings_data_CL'
      description: 'Custom table BitsightFindings_data_CL - imported from JSON schema'
      displayName: 'BitsightFindings_data_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'dateTime'
        }
        {
          name: 'RemediationHistoryLastRefreshStatusDate'
          type: 'string'
        }
        {
          name: 'RemediationHistoryLastRequestedRefreshDate'
          type: 'string'
        }
        {
          name: 'RemainingDecay'
          type: 'real'
        }
        {
          name: 'CompanyName'
          type: 'string'
        }
        {
          name: 'AttributedCompanies'
          type: 'string'
        }
        {
          name: 'AssetOverrides'
          type: 'string'
        }
        {
          name: 'Tags'
          type: 'string'
        }
        {
          name: 'SeverityCategory'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'int'
        }
        {
          name: 'RolledupObservationId'
          type: 'string'
        }
        {
          name: 'RiskVectorLabel'
          type: 'string'
        }
        {
          name: 'RiskVector'
          type: 'string'
        }
        {
          name: 'RiskCategory'
          type: 'string'
        }
        {
          name: 'RelatedFindings'
          type: 'string'
        }
        {
          name: 'LastSeen'
          type: 'string'
        }
        {
          name: 'FirstSeen'
          type: 'string'
        }
        {
          name: 'EvidenceKey'
          type: 'string'
        }
        {
          name: 'Details'
          type: 'string'
        }
        {
          name: 'Assets'
          type: 'string'
        }
        {
          name: 'AffectsRating'
          type: 'boolean'
        }
        {
          name: 'TemporaryId'
          type: 'string'
        }
        {
          name: 'Duration'
          type: 'string'
        }
        {
          name: 'PcapID'
          type: 'string'
        }
        {
          name: 'Comments'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'boolean'
        }
        {
          name: 'RemediationHistoryLastRefreshStatusLabel'
          type: 'string'
        }
        {
          name: 'RemediationHistoryLastRefreshReasonCode'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bitsightfindingsdataclTable.name
output tableId string = bitsightfindingsdataclTable.id
output provisioningState string = bitsightfindingsdataclTable.properties.provisioningState
