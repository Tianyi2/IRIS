// Bicep template for Log Analytics custom table: InfobloxInsightAssets_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 21 (Type column filtered)
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

resource infobloxinsightassetsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'InfobloxInsightAssets_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'InfobloxInsightAssets_CL'
      description: 'Custom table InfobloxInsightAssets_CL - imported from JSON schema'
      displayName: 'InfobloxInsightAssets_CL'
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
          name: 'user_s'
          type: 'string'
        }
        {
          name: 'timeMin_t'
          type: 'dateTime'
        }
        {
          name: 'timeMax_t'
          type: 'dateTime'
        }
        {
          name: 'threatIndicatorDistinctCount_s'
          type: 'string'
        }
        {
          name: 'threatLevelMax_s'
          type: 'string'
        }
        {
          name: 'osVersion_s'
          type: 'string'
        }
        {
          name: 'location_s'
          type: 'string'
        }
        {
          name: 'qip_s'
          type: 'string'
        }
        {
          name: 'count_d'
          type: 'real'
        }
        {
          name: 'cmac_s'
          type: 'string'
        }
        {
          name: 'cid_s'
          type: 'string'
        }
        {
          name: 'InfobloxInsightID_s'
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

output tableName string = infobloxinsightassetsclTable.name
output tableId string = infobloxinsightassetsclTable.id
output provisioningState string = infobloxinsightassetsclTable.properties.provisioningState
