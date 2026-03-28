// Bicep template for Log Analytics custom table: BitsightFindings_summary_CL
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

resource bitsightfindingssummaryclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitsightFindings_summary_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitsightFindings_summary_CL'
      description: 'Custom table BitsightFindings_summary_CL - imported from JSON schema'
      displayName: 'BitsightFindings_summary_CL'
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
          name: 'Company'
          type: 'string'
        }
        {
          name: 'Confidence'
          type: 'string'
        }
        {
          name: 'Description'
          type: 'string'
        }
        {
          name: 'EndDate'
          type: 'string'
        }
        {
          name: 'EventCount'
          type: 'real'
        }
        {
          name: 'FirstSeen'
          type: 'string'
        }
        {
          name: 'HostCount'
          type: 'real'
        }
        {
          name: 'Id'
          type: 'string'
        }
        {
          name: 'Name'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'string'
        }
        {
          name: 'StartDate'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bitsightfindingssummaryclTable.name
output tableId string = bitsightfindingssummaryclTable.id
output provisioningState string = bitsightfindingssummaryclTable.properties.provisioningState
