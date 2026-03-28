// Bicep template for Log Analytics custom table: TrendMicro_XDR_RCA_Task_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 26, Deployed columns: 24 (Type column filtered)
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

resource trendmicroxdrrcataskclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TrendMicro_XDR_RCA_Task_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TrendMicro_XDR_RCA_Task_CL'
      description: 'Custom table TrendMicro_XDR_RCA_Task_CL - imported from JSON schema'
      displayName: 'TrendMicro_XDR_RCA_Task_CL'
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
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'id_g'
          type: 'string'
        }
        {
          name: 'workbenchId_s'
          type: 'string'
        }
        {
          name: 'targets'
          type: 'string'
        }
        {
          name: 'completedTimestamp'
          type: 'real'
        }
        {
          name: 'lastUpdateTimestamp'
          type: 'real'
        }
        {
          name: 'createdTimestamp'
          type: 'real'
        }
        {
          name: 'criteria_conditions'
          type: 'string'
        }
        {
          name: 'criteria_operator'
          type: 'string'
        }
        {
          name: 'xdrCustomerID_g'
          type: 'string'
        }
        {
          name: 'status'
          type: 'string'
        }
        {
          name: 'workbenchId'
          type: 'string'
        }
        {
          name: 'name'
          type: 'string'
        }
        {
          name: 'id'
          type: 'string'
        }
        {
          name: 'xdrCustomerID'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'description'
          type: 'string'
        }
        {
          name: 'targets_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = trendmicroxdrrcataskclTable.name
output tableId string = trendmicroxdrrcataskclTable.id
output provisioningState string = trendmicroxdrrcataskclTable.properties.provisioningState
