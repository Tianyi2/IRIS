// Bicep template for Log Analytics custom table: SecurityScorecardIssues_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 25, Deployed columns: 23 (Type column filtered)
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

resource securityscorecardissuesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SecurityScorecardIssues_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SecurityScorecardIssues_CL'
      description: 'Custom table SecurityScorecardIssues_CL - imported from JSON schema'
      displayName: 'SecurityScorecardIssues_CL'
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
          name: 'detail_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'severity_value_s'
          type: 'string'
        }
        {
          name: 'totalScoreImpact_d'
          type: 'string'
        }
        {
          name: 'issueName_s'
          type: 'string'
        }
        {
          name: 'groupStatus_s'
          type: 'string'
        }
        {
          name: 'findingsCount_d'
          type: 'string'
        }
        {
          name: 'issueType_s'
          type: 'string'
        }
        {
          name: 'date_t'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'eventID_s'
          type: 'string'
        }
        {
          name: 'Factor_s'
          type: 'string'
        }
        {
          name: 'body_s'
          type: 'string'
        }
        {
          name: 'portfolioName_s'
          type: 'string'
        }
        {
          name: 'portfolioId_g'
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
          name: 'industry_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = securityscorecardissuesclTable.name
output tableId string = securityscorecardissuesclTable.id
output provisioningState string = securityscorecardissuesclTable.properties.provisioningState
