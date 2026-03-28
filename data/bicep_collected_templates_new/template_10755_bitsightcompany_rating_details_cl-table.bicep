// Bicep template for Log Analytics custom table: BitsightCompany_rating_details_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 14 (Type column filtered)
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

resource bitsightcompanyratingdetailsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitsightCompany_rating_details_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitsightCompany_rating_details_CL'
      description: 'Custom table BitsightCompany_rating_details_CL - imported from JSON schema'
      displayName: 'BitsightCompany_rating_details_CL'
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
          name: 'CompanyName'
          type: 'string'
        }
        {
          name: 'Beta'
          type: 'boolean'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'CategoryOrder'
          type: 'real'
        }
        {
          name: 'DisplayURL'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'Grade'
          type: 'string'
        }
        {
          name: 'GradeColor'
          type: 'string'
        }
        {
          name: 'Name'
          type: 'string'
        }
        {
          name: 'Order'
          type: 'real'
        }
        {
          name: 'Percentile'
          type: 'real'
        }
        {
          name: 'Rating'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = bitsightcompanyratingdetailsclTable.name
output tableId string = bitsightcompanyratingdetailsclTable.id
output provisioningState string = bitsightcompanyratingdetailsclTable.properties.provisioningState
