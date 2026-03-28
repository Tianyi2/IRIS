// Bicep template for Log Analytics custom table: InfobloxInsight_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 29, Deployed columns: 27 (Type column filtered)
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

resource infobloxinsightclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'InfobloxInsight_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'InfobloxInsight_CL'
      description: 'Custom table InfobloxInsight_CL - imported from JSON schema'
      displayName: 'InfobloxInsight_CL'
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
          name: 'dateChanged_t'
          type: 'dateTime'
        }
        {
          name: 'eventsBlockedCount_s'
          type: 'string'
        }
        {
          name: 'mostRecentAt_t'
          type: 'dateTime'
        }
        {
          name: 'numEvents_s'
          type: 'string'
        }
        {
          name: 'persistentDate_t'
          type: 'dateTime'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'threatType_s'
          type: 'string'
        }
        {
          name: 'startedAt_t'
          type: 'dateTime'
        }
        {
          name: 'feedSource_s'
          type: 'string'
        }
        {
          name: 'insightId_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'tFamily_s'
          type: 'string'
        }
        {
          name: 'tClass_s'
          type: 'string'
        }
        {
          name: 'hello_s'
          type: 'string'
        }
        {
          name: 'InfobloxInsightLogType_s'
          type: 'string'
        }
        {
          name: 'eventsNotBlockedCount_s'
          type: 'string'
        }
        {
          name: 'userComment_s'
          type: 'string'
        }
        {
          name: 'changer_s'
          type: 'string'
        }
        {
          name: 'spreadingDate_t'
          type: 'dateTime'
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
          name: 'priorityText_s'
          type: 'string'
        }
        {
          name: 'InfobloxInsightID'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = infobloxinsightclTable.name
output tableId string = infobloxinsightclTable.id
output provisioningState string = infobloxinsightclTable.properties.provisioningState
