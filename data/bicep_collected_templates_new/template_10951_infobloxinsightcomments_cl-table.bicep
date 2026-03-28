// Bicep template for Log Analytics custom table: InfobloxInsightComments_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 13 (Type column filtered)
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

resource infobloxinsightcommentsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'InfobloxInsightComments_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'InfobloxInsightComments_CL'
      description: 'Custom table InfobloxInsightComments_CL - imported from JSON schema'
      displayName: 'InfobloxInsightComments_CL'
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
          name: 'commentsChanger_s'
          type: 'string'
        }
        {
          name: 'newComment_s'
          type: 'string'
        }
        {
          name: 'dateChanged_t'
          type: 'dateTime'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'InfobloxInsightID_g'
          type: 'string'
        }
        {
          name: 'InfobloxInsightLogType_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = infobloxinsightcommentsclTable.name
output tableId string = infobloxinsightcommentsclTable.id
output provisioningState string = infobloxinsightcommentsclTable.properties.provisioningState
