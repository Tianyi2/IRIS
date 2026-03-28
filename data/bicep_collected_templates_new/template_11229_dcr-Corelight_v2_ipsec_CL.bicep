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
// Data Collection Rule for Corelight_v2_ipsec_CL
// ============================================================================
// Generated: 2025-09-19 14:20:05
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 34, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-Corelight_v2_ipsec_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_ipsec_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_ipsec_CL': {
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
            name: 'length_d'
            type: 'string'
          }
          {
            name: 'transform_attributes_s'
            type: 'string'
          }
          {
            name: 'certificates_s'
            type: 'string'
          }
          {
            name: 'protocol_id_d'
            type: 'string'
          }
          {
            name: 'proposals_s'
            type: 'string'
          }
          {
            name: 'ke_dh_groups_s'
            type: 'string'
          }
          {
            name: 'transforms_s'
            type: 'string'
          }
          {
            name: 'notify_messages_s'
            type: 'string'
          }
          {
            name: 'vendor_ids_s'
            type: 'string'
          }
          {
            name: 'message_id_d'
            type: 'string'
          }
          {
            name: 'flag_r_b'
            type: 'string'
          }
          {
            name: 'flag_v_b'
            type: 'string'
          }
          {
            name: 'flag_i_b'
            type: 'string'
          }
          {
            name: 'flag_a_b'
            type: 'string'
          }
          {
            name: 'flag_c_b'
            type: 'string'
          }
          {
            name: 'flag_e_b'
            type: 'string'
          }
          {
            name: 'exchange_type_d'
            type: 'string'
          }
          {
            name: 'min_ver_d'
            type: 'string'
          }
          {
            name: 'maj_ver_d'
            type: 'string'
          }
          {
            name: 'responder_spi_s'
            type: 'string'
          }
          {
            name: 'initiator_spi_s'
            type: 'string'
          }
          {
            name: 'is_orig_b'
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
            name: 'doi_d'
            type: 'string'
          }
          {
            name: 'situation_s'
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
          name: 'Sentinel-Corelight_v2_ipsec_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_ipsec_CL']
        destinations: ['Sentinel-Corelight_v2_ipsec_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), length_d = toreal(length_d), transform_attributes_s = tostring(transform_attributes_s), certificates_s = tostring(certificates_s), protocol_id_d = toreal(protocol_id_d), proposals_s = tostring(proposals_s), ke_dh_groups_s = tostring(ke_dh_groups_s), transforms_s = tostring(transforms_s), notify_messages_s = tostring(notify_messages_s), vendor_ids_s = tostring(vendor_ids_s), message_id_d = toreal(message_id_d), flag_r_b = tobool(flag_r_b), flag_v_b = tobool(flag_v_b), flag_i_b = tobool(flag_i_b), flag_a_b = tobool(flag_a_b), flag_c_b = tobool(flag_c_b), flag_e_b = tobool(flag_e_b), exchange_type_d = toreal(exchange_type_d), min_ver_d = toreal(min_ver_d), maj_ver_d = toreal(maj_ver_d), responder_spi_s = tostring(responder_spi_s), initiator_spi_s = tostring(initiator_spi_s), is_orig_b = tobool(is_orig_b), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), doi_d = toreal(doi_d), situation_s = tostring(situation_s)'
        outputStream: 'Custom-Corelight_v2_ipsec_CL'
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
