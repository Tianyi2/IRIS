// Bicep template for Log Analytics custom table: TrendMicro_XDR_RCA_Result_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 24, Deployed columns: 22 (Type column filtered)
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

resource trendmicroxdrrcaresultclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TrendMicro_XDR_RCA_Result_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TrendMicro_XDR_RCA_Result_CL'
      description: 'Custom table TrendMicro_XDR_RCA_Result_CL - imported from JSON schema'
      displayName: 'TrendMicro_XDR_RCA_Result_CL'
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
          name: 'parentObjectId_s'
          type: 'string'
        }
        {
          name: 'isMatched_b'
          type: 'boolean'
        }
        {
          name: 'objectName_s'
          type: 'string'
        }
        {
          name: 'eventId_d'
          type: 'real'
        }
        {
          name: 'objectHashId_s'
          type: 'string'
        }
        {
          name: 'workbenchId_s'
          type: 'string'
        }
        {
          name: 'agentEntity_ip_s'
          type: 'string'
        }
        {
          name: 'agentEntity_guid_g'
          type: 'string'
        }
        {
          name: 'objectMeta_s'
          type: 'string'
        }
        {
          name: 'agentEntity_hostname_s'
          type: 'string'
        }
        {
          name: 'taskId_g'
          type: 'string'
        }
        {
          name: 'xdrCustomerID_g'
          type: 'string'
        }
        {
          name: 'agentEntity_host_s'
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
          name: 'taskName_s'
          type: 'string'
        }
        {
          name: 'objectEvent_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = trendmicroxdrrcaresultclTable.name
output tableId string = trendmicroxdrrcaresultclTable.id
output provisioningState string = trendmicroxdrrcaresultclTable.properties.provisioningState
