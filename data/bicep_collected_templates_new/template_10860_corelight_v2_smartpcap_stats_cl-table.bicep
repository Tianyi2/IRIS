// Bicep template for Log Analytics custom table: Corelight_v2_smartpcap_stats_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 26, Deployed columns: 23 (Type column filtered)
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

resource corelightv2smartpcapstatsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_smartpcap_stats_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_smartpcap_stats_CL'
      description: 'Custom table Corelight_v2_smartpcap_stats_CL - imported from JSON schema'
      displayName: 'Corelight_v2_smartpcap_stats_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'uncap_flows_buflimit_d'
          type: 'real'
        }
        {
          name: 'lever_failures_d'
          type: 'real'
        }
        {
          name: 'lever_triggers_d'
          type: 'real'
        }
        {
          name: 'unknown_bytes_d'
          type: 'real'
        }
        {
          name: 'unknown_packets_d'
          type: 'real'
        }
        {
          name: 'socket_connects_d'
          type: 'real'
        }
        {
          name: 'socket_writes_d'
          type: 'real'
        }
        {
          name: 'byte_writes_d'
          type: 'real'
        }
        {
          name: 'packet_writes_d'
          type: 'real'
        }
        {
          name: 'byte_drops_d'
          type: 'real'
        }
        {
          name: 'flow_resumes_d'
          type: 'real'
        }
        {
          name: 'flow_pauses_d'
          type: 'real'
        }
        {
          name: 'socket_closes_d'
          type: 'real'
        }
        {
          name: 'socket_timeouts_d'
          type: 'real'
        }
        {
          name: 'packet_drops_d'
          type: 'real'
        }
        {
          name: 'socket_errors_d'
          type: 'real'
        }
        {
          name: 'flows_buffered_d'
          type: 'real'
        }
        {
          name: 'cap_flows_d'
          type: 'real'
        }
        {
          name: 'cap_bytes_d'
          type: 'real'
        }
        {
          name: 'uncap_flows_closed_d'
          type: 'real'
        }
        {
          name: 'rule_stats_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2smartpcapstatsclTable.name
output tableId string = corelightv2smartpcapstatsclTable.id
output provisioningState string = corelightv2smartpcapstatsclTable.properties.provisioningState
