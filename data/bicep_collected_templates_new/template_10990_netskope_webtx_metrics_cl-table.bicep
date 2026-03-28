// Bicep template for Log Analytics custom table: Netskope_WebTx_metrics_CL
// Generated on 2025-09-19 14:13:57 UTC
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

resource netskopewebtxmetricsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Netskope_WebTx_metrics_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Netskope_WebTx_metrics_CL'
      description: 'Custom table Netskope_WebTx_metrics_CL - imported from JSON schema'
      displayName: 'Netskope_WebTx_metrics_CL'
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
          name: 'timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'backlog_message_count_d'
          type: 'real'
        }
        {
          name: 'oldest_unacked_message_age_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = netskopewebtxmetricsclTable.name
output tableId string = netskopewebtxmetricsclTable.id
output provisioningState string = netskopewebtxmetricsclTable.properties.provisioningState
