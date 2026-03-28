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
// Data Collection Rule for Corelight_v2_vpn_CL
// ============================================================================
// Generated: 2025-09-19 14:20:14
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 27, DCR columns: 24 (Type column always filtered)
// Output stream: Custom-Corelight_v2_vpn_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_vpn_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_vpn_CL': {
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
            name: 'resp_city_s'
            type: 'string'
          }
          {
            name: 'resp_region_s'
            type: 'string'
          }
          {
            name: 'resp_cc_s'
            type: 'string'
          }
          {
            name: 'orig_city_s'
            type: 'string'
          }
          {
            name: 'orig_region_s'
            type: 'string'
          }
          {
            name: 'orig_cc_s'
            type: 'string'
          }
          {
            name: 'resp_bytes_d'
            type: 'string'
          }
          {
            name: 'orig_bytes_d'
            type: 'string'
          }
          {
            name: 'duration_d'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'client_info_s'
            type: 'string'
          }
          {
            name: 'inferences_s'
            type: 'string'
          }
          {
            name: 'service_s'
            type: 'string'
          }
          {
            name: 'vpn_type_s'
            type: 'string'
          }
          {
            name: 'proto_s'
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
            name: 'server_name_s'
            type: 'string'
          }
          {
            name: 'issuer_s'
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
          name: 'Sentinel-Corelight_v2_vpn_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_vpn_CL']
        destinations: ['Sentinel-Corelight_v2_vpn_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), resp_city_s = tostring(resp_city_s), resp_region_s = tostring(resp_region_s), resp_cc_s = tostring(resp_cc_s), orig_city_s = tostring(orig_city_s), orig_region_s = tostring(orig_region_s), orig_cc_s = tostring(orig_cc_s), resp_bytes_d = toreal(resp_bytes_d), orig_bytes_d = toreal(orig_bytes_d), duration_d = toreal(duration_d), subject_s = tostring(subject_s), client_info_s = tostring(client_info_s), inferences_s = tostring(inferences_s), service_s = tostring(service_s), vpn_type_s = tostring(vpn_type_s), proto_s = tostring(proto_s), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), server_name_s = tostring(server_name_s), issuer_s = tostring(issuer_s)'
        outputStream: 'Custom-Corelight_v2_vpn_CL'
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
