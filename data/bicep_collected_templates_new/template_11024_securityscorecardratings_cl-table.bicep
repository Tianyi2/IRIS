// Bicep template for Log Analytics custom table: SecurityScorecardRatings_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 21 (Type column filtered)
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

resource securityscorecardratingsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SecurityScorecardRatings_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SecurityScorecardRatings_CL'
      description: 'Custom table SecurityScorecardRatings_CL - imported from JSON schema'
      displayName: 'SecurityScorecardRatings_CL'
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
          name: 'portfolioId_g'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'industry_s'
          type: 'string'
        }
        {
          name: 'scoreChange_d'
          type: 'real'
        }
        {
          name: 'scoreToday_d'
          type: 'real'
        }
        {
          name: 'scoreYesterday_d'
          type: 'real'
        }
        {
          name: 'dateToday_t'
          type: 'dateTime'
        }
        {
          name: 'dateYesterday_t'
          type: 'dateTime'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'src_s'
          type: 'string'
        }
        {
          name: 'body_s'
          type: 'string'
        }
        {
          name: 'portfolioId_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'portfolioName_s'
          type: 'string'
        }
        {
          name: 'portfolioId_g_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = securityscorecardratingsclTable.name
output tableId string = securityscorecardratingsclTable.id
output provisioningState string = securityscorecardratingsclTable.properties.provisioningState
