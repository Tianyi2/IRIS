// Bicep template for Log Analytics custom table: TaniumComplyVulnerabilities_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 12, Deployed columns: 11 (Type column filtered)
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

resource taniumcomplyvulnerabilitiesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TaniumComplyVulnerabilities_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TaniumComplyVulnerabilities_CL'
      description: 'Custom table TaniumComplyVulnerabilities_CL - imported from JSON schema'
      displayName: 'TaniumComplyVulnerabilities_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'Computer_Name_s'
          type: 'string'
        }
        {
          name: 'CVE_s'
          type: 'string'
        }
        {
          name: 'CVE_Year_s'
          type: 'string'
        }
        {
          name: 'CVSS_Score_s'
          type: 'string'
        }
        {
          name: 'IP_Address_s'
          type: 'string'
        }
        {
          name: 'Operating_System_Generation_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Severity_s'
          type: 'string'
        }
        {
          name: 'Title_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = taniumcomplyvulnerabilitiesclTable.name
output tableId string = taniumcomplyvulnerabilitiesclTable.id
output provisioningState string = taniumcomplyvulnerabilitiesclTable.properties.provisioningState
