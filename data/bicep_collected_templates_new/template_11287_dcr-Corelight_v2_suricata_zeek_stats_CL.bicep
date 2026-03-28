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
// Data Collection Rule for Corelight_v2_suricata_zeek_stats_CL
// ============================================================================
// Generated: 2025-09-19 14:20:13
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 12, DCR columns: 9 (Type column always filtered)
// Output stream: Custom-Corelight_v2_suricata_zeek_stats_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_suricata_zeek_stats_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_suricata_zeek_stats_CL': {
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
            name: 'raised_alerts_d'
            type: 'string'
          }
          {
            name: 'matched_conn_alerts_d'
            type: 'string'
          }
          {
            name: 'unparsed_alerts_d'
            type: 'string'
          }
          {
            name: 'closed_conn_alerts_d'
            type: 'string'
          }
          {
            name: 'unmatched_conn_alerts_d'
            type: 'string'
          }
          {
            name: 'uniq_matched_conns_d'
            type: 'string'
          }
          {
            name: 'uniq_closed_conns_d'
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
          name: 'Sentinel-Corelight_v2_suricata_zeek_stats_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_suricata_zeek_stats_CL']
        destinations: ['Sentinel-Corelight_v2_suricata_zeek_stats_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), raised_alerts_d = toreal(raised_alerts_d), matched_conn_alerts_d = toreal(matched_conn_alerts_d), unparsed_alerts_d = toreal(unparsed_alerts_d), closed_conn_alerts_d = toreal(closed_conn_alerts_d), unmatched_conn_alerts_d = toreal(unmatched_conn_alerts_d), uniq_matched_conns_d = toreal(uniq_matched_conns_d), uniq_closed_conns_d = toreal(uniq_closed_conns_d)'
        outputStream: 'Custom-Corelight_v2_suricata_zeek_stats_CL'
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
