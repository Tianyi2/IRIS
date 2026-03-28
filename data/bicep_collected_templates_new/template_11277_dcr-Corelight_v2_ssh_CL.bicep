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
// Data Collection Rule for Corelight_v2_ssh_CL
// ============================================================================
// Generated: 2025-09-19 14:20:12
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 33, DCR columns: 30 (Type column always filtered)
// Output stream: Custom-Corelight_v2_ssh_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_ssh_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_ssh_CL': {
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
            name: 'sshka_s'
            type: 'string'
          }
          {
            name: 'hasshAlgorithms_s'
            type: 'string'
          }
          {
            name: 'cshka_s'
            type: 'string'
          }
          {
            name: 'hasshVersion_s'
            type: 'string'
          }
          {
            name: 'remote_location_longitude_d'
            type: 'string'
          }
          {
            name: 'remote_location_latitude_d'
            type: 'string'
          }
          {
            name: 'remote_location_city_s'
            type: 'string'
          }
          {
            name: 'remote_location_region_s'
            type: 'string'
          }
          {
            name: 'remote_location_country_code_s'
            type: 'string'
          }
          {
            name: 'host_key_s'
            type: 'string'
          }
          {
            name: 'host_key_alg_s'
            type: 'string'
          }
          {
            name: 'kex_alg_s'
            type: 'string'
          }
          {
            name: 'hasshServerAlgorithms_s'
            type: 'string'
          }
          {
            name: 'compression_alg_s'
            type: 'string'
          }
          {
            name: 'cipher_alg_s'
            type: 'string'
          }
          {
            name: 'server_s'
            type: 'string'
          }
          {
            name: 'client_s'
            type: 'string'
          }
          {
            name: 'direction_s'
            type: 'string'
          }
          {
            name: 'auth_attempts_d'
            type: 'string'
          }
          {
            name: 'auth_success_b'
            type: 'string'
          }
          {
            name: 'version_d'
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
            name: 'mac_alg_s'
            type: 'string'
          }
          {
            name: 'inferences_s'
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
          name: 'Sentinel-Corelight_v2_ssh_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_ssh_CL']
        destinations: ['Sentinel-Corelight_v2_ssh_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), sshka_s = tostring(sshka_s), hasshAlgorithms_s = tostring(hasshAlgorithms_s), cshka_s = tostring(cshka_s), hasshVersion_s = tostring(hasshVersion_s), remote_location_longitude_d = toreal(remote_location_longitude_d), remote_location_latitude_d = toreal(remote_location_latitude_d), remote_location_city_s = tostring(remote_location_city_s), remote_location_region_s = tostring(remote_location_region_s), remote_location_country_code_s = tostring(remote_location_country_code_s), host_key_s = tostring(host_key_s), host_key_alg_s = tostring(host_key_alg_s), kex_alg_s = tostring(kex_alg_s), hasshServerAlgorithms_s = tostring(hasshServerAlgorithms_s), compression_alg_s = tostring(compression_alg_s), cipher_alg_s = tostring(cipher_alg_s), server_s = tostring(server_s), client_s = tostring(client_s), direction_s = tostring(direction_s), auth_attempts_d = toreal(auth_attempts_d), auth_success_b = tobool(auth_success_b), version_d = toreal(version_d), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), mac_alg_s = tostring(mac_alg_s), inferences_s = tostring(inferences_s)'
        outputStream: 'Custom-Corelight_v2_ssh_CL'
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
