// Bicep template for Log Analytics custom table: AliCloud_CL
// Generated on 2025-09-19 14:13:48 UTC
// Source: JSON schema export
// Original columns: 28, Deployed columns: 27 (Type column filtered)
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

resource alicloudclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'AliCloud_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'AliCloud_CL'
      description: 'Custom table AliCloud_CL - imported from JSON schema'
      displayName: 'AliCloud_CL'
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
          name: 'apiVersion'
          type: 'dateTime'
        }
        {
          name: 'UserIdentity'
          type: 'string'
        }
        {
          name: 'UserAgent'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ServiceName'
          type: 'string'
        }
        {
          name: 'RequestParameters'
          type: 'string'
        }
        {
          name: 'RequestParameterJson'
          type: 'string'
        }
        {
          name: 'RequestId'
          type: 'string'
        }
        {
          name: 'EventVersion'
          type: 'string'
        }
        {
          name: 'EventSource'
          type: 'string'
        }
        {
          name: 'EventRW'
          type: 'string'
        }
        {
          name: 'AdditionalEventData'
          type: 'string'
        }
        {
          name: 'EventOriginalType'
          type: 'string'
        }
        {
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'EventSubType'
          type: 'string'
        }
        {
          name: 'AcsRegion'
          type: 'string'
        }
        {
          name: 'SourceName'
          type: 'string'
        }
        {
          name: 'ContentTopic'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'CreatedAt'
          type: 'dateTime'
        }
        {
          name: 'EventCount'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'TenanId'
          type: 'string'
        }
        {
          name: 'SourseSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = alicloudclTable.name
output tableId string = alicloudclTable.id
output provisioningState string = alicloudclTable.properties.provisioningState
