// Bicep template for Log Analytics custom table: BitsightBreaches_data_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 16, Deployed columns: 15 (Type column filtered)
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

resource bitsightbreachesdataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitsightBreaches_data_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitsightBreaches_data_CL'
      description: 'Custom table BitsightBreaches_data_CL - imported from JSON schema'
      displayName: 'BitsightBreaches_data_CL'
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
          name: 'GUID'
          type: 'string'
        }
        {
          name: 'Date'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'int'
        }
        {
          name: 'Text'
          type: 'string'
        }
        {
          name: 'DateCreated'
          type: 'string'
        }
        {
          name: 'PreviwURL'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'EventTypeDescription'
          type: 'string'
        }
        {
          name: 'BreachedCompanies'
          type: 'string'
        }
        {
          name: 'DependentCompanies'
          type: 'string'
        }
        {
          name: 'Companyname'
          type: 'string'
        }
        {
          name: 'CompanyGUID'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bitsightbreachesdataclTable.name
output tableId string = bitsightbreachesdataclTable.id
output provisioningState string = bitsightbreachesdataclTable.properties.provisioningState
