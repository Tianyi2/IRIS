// Bicep template for Log Analytics custom table: DNS_Summarized_Logs_ip_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 7, Deployed columns: 7 (Type column filtered)
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

resource dnssummarizedlogsipclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DNS_Summarized_Logs_ip_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DNS_Summarized_Logs_ip_CL'
      description: 'Custom table DNS_Summarized_Logs_ip_CL - imported from JSON schema'
      displayName: 'DNS_Summarized_Logs_ip_CL'
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
          name: 'SrcIpAddr_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'DnsQuery_s'
          type: 'string'
        }
        {
          name: 'EventResultDetails_s'
          type: 'string'
        }
        {
          name: 'DnsResponseName_s'
          type: 'string'
        }
        {
          name: 'count__d'
          type: 'int'
        }
      ]
    }
  }
}

output tableName string = dnssummarizedlogsipclTable.name
output tableId string = dnssummarizedlogsipclTable.id
output provisioningState string = dnssummarizedlogsipclTable.properties.provisioningState
