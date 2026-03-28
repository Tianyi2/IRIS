// Bicep template for Log Analytics custom table: LastPassNativePoller_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 12, Deployed columns: 10 (Type column filtered)
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

resource lastpassnativepollerclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'LastPassNativePoller_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'LastPassNativePoller_CL'
      description: 'Custom table LastPassNativePoller_CL - imported from JSON schema'
      displayName: 'LastPassNativePoller_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
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
          name: 'Time_s'
          type: 'string'
        }
        {
          name: 'Username_s'
          type: 'string'
        }
        {
          name: 'IP_Address_s'
          type: 'string'
        }
        {
          name: 'Action_s'
          type: 'string'
        }
        {
          name: 'Data_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = lastpassnativepollerclTable.name
output tableId string = lastpassnativepollerclTable.id
output provisioningState string = lastpassnativepollerclTable.properties.provisioningState
