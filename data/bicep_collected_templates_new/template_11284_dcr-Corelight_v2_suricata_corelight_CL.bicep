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
// Data Collection Rule for Corelight_v2_suricata_corelight_CL
// ============================================================================
// Generated: 2025-09-19 14:20:12
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 29, DCR columns: 26 (Type column always filtered)
// Output stream: Custom-Corelight_v2_suricata_corelight_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_suricata_corelight_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_suricata_corelight_CL': {
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
            name: 'payload_s'
            type: 'string'
          }
          {
            name: 'community_id_s'
            type: 'string'
          }
          {
            name: 'alert_metadata_s'
            type: 'string'
          }
          {
            name: 'alert_severity_d'
            type: 'string'
          }
          {
            name: 'alert_category_s'
            type: 'string'
          }
          {
            name: 'alert_signature_s'
            type: 'string'
          }
          {
            name: 'alert_rev_d'
            type: 'string'
          }
          {
            name: 'alert_signature_id_d'
            type: 'string'
          }
          {
            name: 'alert_gid_d'
            type: 'string'
          }
          {
            name: 'alert_action_s'
            type: 'string'
          }
          {
            name: 'packet_s'
            type: 'string'
          }
          {
            name: 'pcap_cnt_d'
            type: 'string'
          }
          {
            name: 'flow_id_d'
            type: 'string'
          }
          {
            name: 'service_s'
            type: 'string'
          }
          {
            name: 'suri_id_s'
            type: 'string'
          }
          {
            name: 'icmp_code_d'
            type: 'string'
          }
          {
            name: 'icmp_type_d'
            type: 'string'
          }
          {
            name: 'id_resp_p_d'
            type: 'string'
          }
          {
            name: 'id_resp_h_s'
            type: 'string'
          }
          {
            name: 'id_orig_p_d'
            type: 'string'
          }
          {
            name: 'id_orig_h_s'
            type: 'string'
          }
          {
            name: 'uid_s'
            type: 'string'
          }
          {
            name: 'tx_id_d'
            type: 'string'
          }
          {
            name: 'metadata_s'
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
          name: 'Sentinel-Corelight_v2_suricata_corelight_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_suricata_corelight_CL']
        destinations: ['Sentinel-Corelight_v2_suricata_corelight_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), payload_s = tostring(payload_s), community_id_s = tostring(community_id_s), alert_metadata_s = tostring(alert_metadata_s), alert_severity_d = toreal(alert_severity_d), alert_category_s = tostring(alert_category_s), alert_signature_s = tostring(alert_signature_s), alert_rev_d = toreal(alert_rev_d), alert_signature_id_d = toreal(alert_signature_id_d), alert_gid_d = toreal(alert_gid_d), alert_action_s = tostring(alert_action_s), packet_s = tostring(packet_s), pcap_cnt_d = toreal(pcap_cnt_d), flow_id_d = toreal(flow_id_d), service_s = tostring(service_s), suri_id_s = tostring(suri_id_s), icmp_code_d = toreal(icmp_code_d), icmp_type_d = toreal(icmp_type_d), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), tx_id_d = toreal(tx_id_d), metadata_s = tostring(metadata_s)'
        outputStream: 'Custom-Corelight_v2_suricata_corelight_CL'
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
