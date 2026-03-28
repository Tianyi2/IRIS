// Bicep template for Log Analytics custom table: Ipinfo_Company_CL
// Generated on 2025-09-19 14:13:56 UTC
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

resource ipinfocompanyclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Ipinfo_Company_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Ipinfo_Company_CL'
      description: 'Custom table Ipinfo_Company_CL - imported from JSON schema'
      displayName: 'Ipinfo_Company_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'as_domain'
          type: 'string'
        }
        {
          name: 'as_name'
          type: 'string'
        }
        {
          name: 'as_type'
          type: 'string'
        }
        {
          name: 'asn'
          type: 'string'
        }
        {
          name: 'country'
          type: 'string'
        }
        {
          name: 'company_domain'
          type: 'string'
        }
        {
          name: 'company_name'
          type: 'string'
        }
        {
          name: 'company_type'
          type: 'string'
        }
        {
          name: 'range'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ipinfocompanyclTable.name
output tableId string = ipinfocompanyclTable.id
output provisioningState string = ipinfocompanyclTable.properties.provisioningState
