// Bicep template for Log Analytics custom table: Illumio_Workloads_Summarized_API_CL
// Generated on 2025-09-19 14:13:55 UTC
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

resource illumioworkloadssummarizedapiclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Illumio_Workloads_Summarized_API_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Illumio_Workloads_Summarized_API_CL'
      description: 'Custom table Illumio_Workloads_Summarized_API_CL - imported from JSON schema'
      displayName: 'Illumio_Workloads_Summarized_API_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'vens_by_enforcement_mode'
          type: 'dynamic'
        }
        {
          name: 'vens_by_managed'
          type: 'dynamic'
        }
        {
          name: 'vens_by_os'
          type: 'dynamic'
        }
        {
          name: 'vens_by_status'
          type: 'dynamic'
        }
        {
          name: 'vens_by_sync_state'
          type: 'dynamic'
        }
        {
          name: 'vens_by_type'
          type: 'dynamic'
        }
        {
          name: 'vens_by_version'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = illumioworkloadssummarizedapiclTable.name
output tableId string = illumioworkloadssummarizedapiclTable.id
output provisioningState string = illumioworkloadssummarizedapiclTable.properties.provisioningState
