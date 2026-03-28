// Bicep template for Log Analytics custom table: WebSession_Summarized_DstIP_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 14, Deployed columns: 14 (Type column filtered)
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

resource websessionsummarizeddstipclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'WebSession_Summarized_DstIP_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'WebSession_Summarized_DstIP_CL'
      description: 'Custom table WebSession_Summarized_DstIP_CL - imported from JSON schema'
      displayName: 'WebSession_Summarized_DstIP_CL'
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
          name: 'DestDomain_s'
          type: 'string'
        }
        {
          name: 'DstBytes_d'
          type: 'int'
        }
        {
          name: 'DstHostname_s'
          type: 'string'
        }
        {
          name: 'DstIpAddr_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'DstPortNumber_d'
          type: 'int'
        }
        {
          name: 'EventProduct_s'
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
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'SrcBytes_d'
          type: 'int'
        }
        {
          name: 'SrcIPIsPrivate_b'
          type: 'boolean'
        }
        {
          name: 'EventCount_d'
          type: 'int'
        }
      ]
    }
  }
}

output tableName string = websessionsummarizeddstipclTable.name
output tableId string = websessionsummarizeddstipclTable.id
output provisioningState string = websessionsummarizeddstipclTable.properties.provisioningState
