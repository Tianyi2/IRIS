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
// Data Collection Rule for Corelight_v2_smartpcap_stats_CL
// ============================================================================
// Generated: 2025-09-19 14:20:10
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 26, DCR columns: 23 (Type column always filtered)
// Output stream: Custom-Corelight_v2_smartpcap_stats_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_smartpcap_stats_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_smartpcap_stats_CL': {
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
            name: 'uncap_flows_buflimit_d'
            type: 'string'
          }
          {
            name: 'lever_failures_d'
            type: 'string'
          }
          {
            name: 'lever_triggers_d'
            type: 'string'
          }
          {
            name: 'unknown_bytes_d'
            type: 'string'
          }
          {
            name: 'unknown_packets_d'
            type: 'string'
          }
          {
            name: 'socket_connects_d'
            type: 'string'
          }
          {
            name: 'socket_writes_d'
            type: 'string'
          }
          {
            name: 'byte_writes_d'
            type: 'string'
          }
          {
            name: 'packet_writes_d'
            type: 'string'
          }
          {
            name: 'byte_drops_d'
            type: 'string'
          }
          {
            name: 'flow_resumes_d'
            type: 'string'
          }
          {
            name: 'flow_pauses_d'
            type: 'string'
          }
          {
            name: 'socket_closes_d'
            type: 'string'
          }
          {
            name: 'socket_timeouts_d'
            type: 'string'
          }
          {
            name: 'packet_drops_d'
            type: 'string'
          }
          {
            name: 'socket_errors_d'
            type: 'string'
          }
          {
            name: 'flows_buffered_d'
            type: 'string'
          }
          {
            name: 'cap_flows_d'
            type: 'string'
          }
          {
            name: 'cap_bytes_d'
            type: 'string'
          }
          {
            name: 'uncap_flows_closed_d'
            type: 'string'
          }
          {
            name: 'rule_stats_s'
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
          name: 'Sentinel-Corelight_v2_smartpcap_stats_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_smartpcap_stats_CL']
        destinations: ['Sentinel-Corelight_v2_smartpcap_stats_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), uncap_flows_buflimit_d = toreal(uncap_flows_buflimit_d), lever_failures_d = toreal(lever_failures_d), lever_triggers_d = toreal(lever_triggers_d), unknown_bytes_d = toreal(unknown_bytes_d), unknown_packets_d = toreal(unknown_packets_d), socket_connects_d = toreal(socket_connects_d), socket_writes_d = toreal(socket_writes_d), byte_writes_d = toreal(byte_writes_d), packet_writes_d = toreal(packet_writes_d), byte_drops_d = toreal(byte_drops_d), flow_resumes_d = toreal(flow_resumes_d), flow_pauses_d = toreal(flow_pauses_d), socket_closes_d = toreal(socket_closes_d), socket_timeouts_d = toreal(socket_timeouts_d), packet_drops_d = toreal(packet_drops_d), socket_errors_d = toreal(socket_errors_d), flows_buffered_d = toreal(flows_buffered_d), cap_flows_d = toreal(cap_flows_d), cap_bytes_d = toreal(cap_bytes_d), uncap_flows_closed_d = toreal(uncap_flows_closed_d), rule_stats_s = tostring(rule_stats_s)'
        outputStream: 'Custom-Corelight_v2_smartpcap_stats_CL'
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
