// Bicep template for Log Analytics custom table: ZeroFox_CTI_vulnerabilities_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 12, Deployed columns: 12 (Type column filtered)
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

resource zerofoxctivulnerabilitiesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_vulnerabilities_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_vulnerabilities_CL'
      description: 'Custom table ZeroFox_CTI_vulnerabilities_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_vulnerabilities_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'base_score_d'
          type: 'real'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'exploitability_score_d'
          type: 'real'
        }
        {
          name: 'impact_score_d'
          type: 'real'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
        {
          name: 'updated_at_t'
          type: 'dateTime'
        }
        {
          name: 'vector_string_s'
          type: 'string'
        }
        {
          name: 'cve_s'
          type: 'string'
        }
        {
          name: 'summary_s'
          type: 'string'
        }
        {
          name: 'remediation_s'
          type: 'string'
        }
        {
          name: 'products_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxctivulnerabilitiesclTable.name
output tableId string = zerofoxctivulnerabilitiesclTable.id
output provisioningState string = zerofoxctivulnerabilitiesclTable.properties.provisioningState
