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
// Data Collection Rule for Corelight_v2_rdp_CL
// ============================================================================
// Generated: 2025-09-19 14:20:10
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 32, DCR columns: 29 (Type column always filtered)
// Output stream: Custom-Corelight_v2_rdp_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_rdp_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_rdp_CL': {
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
            name: 'rdpeudp_uid_s'
            type: 'string'
          }
          {
            name: 'inferences_s'
            type: 'string'
          }
          {
            name: 'channels_joined_d'
            type: 'string'
          }
          {
            name: 'auth_success_b'
            type: 'string'
          }
          {
            name: 'encryption_method_s'
            type: 'string'
          }
          {
            name: 'encryption_level_s'
            type: 'string'
          }
          {
            name: 'cert_permanent_b'
            type: 'string'
          }
          {
            name: 'cert_count_d'
            type: 'string'
          }
          {
            name: 'cert_type_s'
            type: 'string'
          }
          {
            name: 'requested_color_depth_s'
            type: 'string'
          }
          {
            name: 'desktop_height_d'
            type: 'string'
          }
          {
            name: 'desktop_width_d'
            type: 'string'
          }
          {
            name: 'client_dig_product_id_s'
            type: 'string'
          }
          {
            name: 'client_name_s'
            type: 'string'
          }
          {
            name: 'client_build_s'
            type: 'string'
          }
          {
            name: 'keyboard_layout_s'
            type: 'string'
          }
          {
            name: 'client_channels_s'
            type: 'string'
          }
          {
            name: 'security_protocol_s'
            type: 'string'
          }
          {
            name: 'result_s'
            type: 'string'
          }
          {
            name: 'cookie_s'
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
            name: 'rdfp_string_s'
            type: 'string'
          }
          {
            name: 'rdfp_hash_s'
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
          name: 'Sentinel-Corelight_v2_rdp_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_rdp_CL']
        destinations: ['Sentinel-Corelight_v2_rdp_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), rdpeudp_uid_s = tostring(rdpeudp_uid_s), inferences_s = tostring(inferences_s), channels_joined_d = toreal(channels_joined_d), auth_success_b = tobool(auth_success_b), encryption_method_s = tostring(encryption_method_s), encryption_level_s = tostring(encryption_level_s), cert_permanent_b = tobool(cert_permanent_b), cert_count_d = toreal(cert_count_d), cert_type_s = tostring(cert_type_s), requested_color_depth_s = tostring(requested_color_depth_s), desktop_height_d = toreal(desktop_height_d), desktop_width_d = toreal(desktop_width_d), client_dig_product_id_s = tostring(client_dig_product_id_s), client_name_s = tostring(client_name_s), client_build_s = tostring(client_build_s), keyboard_layout_s = tostring(keyboard_layout_s), client_channels_s = tostring(client_channels_s), security_protocol_s = tostring(security_protocol_s), result_s = tostring(result_s), cookie_s = tostring(cookie_s), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), rdfp_string_s = tostring(rdfp_string_s), rdfp_hash_s = tostring(rdfp_hash_s)'
        outputStream: 'Custom-Corelight_v2_rdp_CL'
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
