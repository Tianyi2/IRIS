// Bicep template for Log Analytics custom table: Corelight_v2_stats_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 27 (Type column filtered)
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

resource corelightv2statsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_stats_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_stats_CL'
      description: 'Custom table Corelight_v2_stats_CL - imported from JSON schema'
      displayName: 'Corelight_v2_stats_CL'
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
          name: 'reassem_file_size_d'
          type: 'real'
        }
        {
          name: 'reassem_tcp_size_d'
          type: 'real'
        }
        {
          name: 'active_dns_requests_d'
          type: 'real'
        }
        {
          name: 'dns_requests_d'
          type: 'real'
        }
        {
          name: 'active_files_d'
          type: 'real'
        }
        {
          name: 'files_d'
          type: 'real'
        }
        {
          name: 'active_timers_d'
          type: 'real'
        }
        {
          name: 'timers_d'
          type: 'real'
        }
        {
          name: 'icmp_conns_d'
          type: 'real'
        }
        {
          name: 'udp_conns_d'
          type: 'real'
        }
        {
          name: 'tcp_conns_d'
          type: 'real'
        }
        {
          name: 'active_icmp_conns_d'
          type: 'real'
        }
        {
          name: 'active_udp_conns_d'
          type: 'real'
        }
        {
          name: 'active_tcp_conns_d'
          type: 'real'
        }
        {
          name: 'events_queued_d'
          type: 'real'
        }
        {
          name: 'events_proc_d'
          type: 'real'
        }
        {
          name: 'pkt_lag_d'
          type: 'real'
        }
        {
          name: 'pkts_link_d'
          type: 'real'
        }
        {
          name: 'pkts_dropped_d'
          type: 'real'
        }
        {
          name: 'bytes_recv_d'
          type: 'real'
        }
        {
          name: 'pkts_proc_d'
          type: 'real'
        }
        {
          name: 'mem_d'
          type: 'real'
        }
        {
          name: 'peer_s'
          type: 'string'
        }
        {
          name: 'reassem_frag_size_d'
          type: 'real'
        }
        {
          name: 'reassem_unknown_size_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2statsclTable.name
output tableId string = corelightv2statsclTable.id
output provisioningState string = corelightv2statsclTable.properties.provisioningState
