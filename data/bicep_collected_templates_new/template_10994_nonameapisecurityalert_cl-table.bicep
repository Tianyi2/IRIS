// Bicep template for Log Analytics custom table: NonameAPISecurityAlert_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 15 (Type column filtered)
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

resource nonameapisecurityalertclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'NonameAPISecurityAlert_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'NonameAPISecurityAlert_CL'
      description: 'Custom table NonameAPISecurityAlert_CL - imported from JSON schema'
      displayName: 'NonameAPISecurityAlert_CL'
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
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'data_host_s'
          type: 'string'
        }
        {
          name: 'data_id_s'
          type: 'string'
        }
        {
          name: 'data_method_s'
          type: 'string'
        }
        {
          name: 'data_path_s'
          type: 'string'
        }
        {
          name: 'data_self_s'
          type: 'string'
        }
        {
          name: 'data_ts_t'
          type: 'dateTime'
        }
        {
          name: 'data_type_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = nonameapisecurityalertclTable.name
output tableId string = nonameapisecurityalertclTable.id
output provisioningState string = nonameapisecurityalertclTable.properties.provisioningState
