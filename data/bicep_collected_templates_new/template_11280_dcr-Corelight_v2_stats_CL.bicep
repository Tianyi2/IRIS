@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for Corelight_v2_stats_CL
// ============================================================================
// Generated: 2025-09-19 14:20:12
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 27 (Type column always filtered)
// Output stream: Custom-Corelight_v2_stats_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_stats_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_stats_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'ts_t'
            type: 'string'
          }
          {
            name: 'reassem_file_size_d'
            type: 'string'
          }
          {
            name: 'reassem_tcp_size_d'
            type: 'string'
          }
          {
            name: 'active_dns_requests_d'
            type: 'string'
          }
          {
            name: 'dns_requests_d'
            type: 'string'
          }
          {
            name: 'active_files_d'
            type: 'string'
          }
          {
            name: 'files_d'
            type: 'string'
          }
          {
            name: 'active_timers_d'
            type: 'string'
          }
          {
            name: 'timers_d'
            type: 'string'
          }
          {
            name: 'icmp_conns_d'
            type: 'string'
          }
          {
            name: 'udp_conns_d'
            type: 'string'
          }
          {
            name: 'tcp_conns_d'
            type: 'string'
          }
          {
            name: 'active_icmp_conns_d'
            type: 'string'
          }
          {
            name: 'active_udp_conns_d'
            type: 'string'
          }
          {
            name: 'active_tcp_conns_d'
            type: 'string'
          }
          {
            name: 'events_queued_d'
            type: 'string'
          }
          {
            name: 'events_proc_d'
            type: 'string'
          }
          {
            name: 'pkt_lag_d'
            type: 'string'
          }
          {
            name: 'pkts_link_d'
            type: 'string'
          }
          {
            name: 'pkts_dropped_d'
            type: 'string'
          }
          {
            name: 'bytes_recv_d'
            type: 'string'
          }
          {
            name: 'pkts_proc_d'
            type: 'string'
          }
          {
            name: 'mem_d'
            type: 'string'
          }
          {
            name: 'peer_s'
            type: 'string'
          }
          {
            name: 'reassem_frag_size_d'
            type: 'string'
          }
          {
            name: 'reassem_unknown_size_d'
            type: 'string'
          }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-Corelight_v2_stats_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_stats_CL']
        destinations: ['Sentinel-Corelight_v2_stats_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), reassem_file_size_d = toreal(reassem_file_size_d), reassem_tcp_size_d = toreal(reassem_tcp_size_d), active_dns_requests_d = toreal(active_dns_requests_d), dns_requests_d = toreal(dns_requests_d), active_files_d = toreal(active_files_d), files_d = toreal(files_d), active_timers_d = toreal(active_timers_d), timers_d = toreal(timers_d), icmp_conns_d = toreal(icmp_conns_d), udp_conns_d = toreal(udp_conns_d), tcp_conns_d = toreal(tcp_conns_d), active_icmp_conns_d = toreal(active_icmp_conns_d), active_udp_conns_d = toreal(active_udp_conns_d), active_tcp_conns_d = toreal(active_tcp_conns_d), events_queued_d = toreal(events_queued_d), events_proc_d = toreal(events_proc_d), pkt_lag_d = toreal(pkt_lag_d), pkts_link_d = toreal(pkts_link_d), pkts_dropped_d = toreal(pkts_dropped_d), bytes_recv_d = toreal(bytes_recv_d), pkts_proc_d = toreal(pkts_proc_d), mem_d = toreal(mem_d), peer_s = tostring(peer_s), reassem_frag_size_d = toreal(reassem_frag_size_d), reassem_unknown_size_d = toreal(reassem_unknown_size_d)'
        outputStream: 'Custom-Corelight_v2_stats_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
