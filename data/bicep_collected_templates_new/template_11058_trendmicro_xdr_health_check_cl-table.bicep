// Bicep template for Log Analytics custom table: TrendMicro_XDR_Health_Check_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 14, Deployed columns: 12 (Type column filtered)
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

resource trendmicroxdrhealthcheckclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TrendMicro_XDR_Health_Check_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TrendMicro_XDR_Health_Check_CL'
      description: 'Custom table TrendMicro_XDR_Health_Check_CL - imported from JSON schema'
      displayName: 'TrendMicro_XDR_Health_Check_CL'
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
          name: 'clpId'
          type: 'string'
        }
        {
          name: 'queryStartTime'
          type: 'dateTime'
        }
        {
          name: 'queryEndTime'
          type: 'dateTime'
        }
        {
          name: 'newWorkbenchCount'
          type: 'real'
        }
        {
          name: 'error_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = trendmicroxdrhealthcheckclTable.name
output tableId string = trendmicroxdrhealthcheckclTable.id
output provisioningState string = trendmicroxdrhealthcheckclTable.properties.provisioningState
