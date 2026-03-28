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
// Data Collection Rule for Corelight_v2_ssl_CL
// ============================================================================
// Generated: 2025-09-19 14:20:12
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-Corelight_v2_ssl_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_ssl_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_ssl_CL': {
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
            name: 'client_cert_chain_fps_s'
            type: 'string'
          }
          {
            name: 'cert_chain_fps_s'
            type: 'string'
          }
          {
            name: 'ssl_history_s'
            type: 'string'
          }
          {
            name: 'established_b'
            type: 'string'
          }
          {
            name: 'next_protocol_s'
            type: 'string'
          }
          {
            name: 'last_alert_s'
            type: 'string'
          }
          {
            name: 'resumed_b'
            type: 'string'
          }
          {
            name: 'sni_matches_cert_b'
            type: 'string'
          }
          {
            name: 'server_name_s'
            type: 'string'
          }
          {
            name: 'cipher_s'
            type: 'string'
          }
          {
            name: 'version_s'
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
            name: 'curve_s'
            type: 'string'
          }
          {
            name: 'validation_status_s'
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
          name: 'Sentinel-Corelight_v2_ssl_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_ssl_CL']
        destinations: ['Sentinel-Corelight_v2_ssl_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), client_cert_chain_fps_s = tostring(client_cert_chain_fps_s), cert_chain_fps_s = tostring(cert_chain_fps_s), ssl_history_s = tostring(ssl_history_s), established_b = tobool(established_b), next_protocol_s = tostring(next_protocol_s), last_alert_s = tostring(last_alert_s), resumed_b = tobool(resumed_b), sni_matches_cert_b = tobool(sni_matches_cert_b), server_name_s = tostring(server_name_s), cipher_s = tostring(cipher_s), version_s = tostring(version_s), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), curve_s = tostring(curve_s), validation_status_s = tostring(validation_status_s)'
        outputStream: 'Custom-Corelight_v2_ssl_CL'
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
