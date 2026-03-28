// Bicep template for Log Analytics custom table: Report_links_data_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 8, Deployed columns: 8 (Type column filtered)
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

resource reportlinksdataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Report_links_data_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Report_links_data_CL'
      description: 'Custom table Report_links_data_CL - imported from JSON schema'
      displayName: 'Report_links_data_CL'
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
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'indicator_id_s'
          type: 'string'
        }
        {
          name: 'report_link_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'updated_at_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = reportlinksdataclTable.name
output tableId string = reportlinksdataclTable.id
output provisioningState string = reportlinksdataclTable.properties.provisioningState
