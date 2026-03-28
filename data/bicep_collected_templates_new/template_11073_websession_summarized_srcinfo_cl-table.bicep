// Bicep template for Log Analytics custom table: WebSession_Summarized_SrcInfo_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 15 (Type column filtered)
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

resource websessionsummarizedsrcinfoclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'WebSession_Summarized_SrcInfo_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'WebSession_Summarized_SrcInfo_CL'
      description: 'Custom table WebSession_Summarized_SrcInfo_CL - imported from JSON schema'
      displayName: 'WebSession_Summarized_SrcInfo_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventTime_t'
          type: 'dateTime'
        }
        {
          name: 'HttpUserAgent_s'
          type: 'string'
        }
        {
          name: 'EventResultDetails_s'
          type: 'string'
        }
        {
          name: 'EventResult_s'
          type: 'string'
        }
        {
          name: 'UrlCategory_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'NetworkApplicationProtocol_s'
          type: 'string'
        }
        {
          name: 'HttpRequestMethod_s'
          type: 'string'
        }
        {
          name: 'HttpContentType_s'
          type: 'string'
        }
        {
          name: 'EventProduct_s'
          type: 'string'
        }
        {
          name: 'EventVendor_s'
          type: 'string'
        }
        {
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'SrcBytes_d'
          type: 'int'
        }
        {
          name: 'DstBytes_d'
          type: 'int'
        }
        {
          name: 'EventCount_d'
          type: 'int'
        }
      ]
    }
  }
}

output tableName string = websessionsummarizedsrcinfoclTable.name
output tableId string = websessionsummarizedsrcinfoclTable.id
output provisioningState string = websessionsummarizedsrcinfoclTable.properties.provisioningState
