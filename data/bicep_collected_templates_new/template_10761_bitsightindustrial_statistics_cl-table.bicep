// Bicep template for Log Analytics custom table: BitsightIndustrial_statistics_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 9, Deployed columns: 8 (Type column filtered)
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

resource bitsightindustrialstatisticsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitsightIndustrial_statistics_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitsightIndustrial_statistics_CL'
      description: 'Custom table BitsightIndustrial_statistics_CL - imported from JSON schema'
      displayName: 'BitsightIndustrial_statistics_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'Count'
          type: 'real'
        }
        {
          name: 'CountPeriod'
          type: 'string'
        }
        {
          name: 'AverageDurationDays'
          type: 'real'
        }
        {
          name: 'RiskVector'
          type: 'string'
        }
        {
          name: 'CompanyName'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bitsightindustrialstatisticsclTable.name
output tableId string = bitsightindustrialstatisticsclTable.id
output provisioningState string = bitsightindustrialstatisticsclTable.properties.provisioningState
