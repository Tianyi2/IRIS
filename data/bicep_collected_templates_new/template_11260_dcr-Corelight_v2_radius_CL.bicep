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
// Data Collection Rule for Corelight_v2_radius_CL
// ============================================================================
// Generated: 2025-09-19 14:20:09
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 15 (Type column always filtered)
// Output stream: Custom-Corelight_v2_radius_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_radius_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_radius_CL': {
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
            name: 'uid_s'
            type: 'string'
          }
          {
            name: 'id_orig_h_s'
            type: 'string'
          }
          {
            name: 'id_orig_p_d'
            type: 'string'
          }
          {
            name: 'id_resp_h_s'
            type: 'string'
          }
          {
            name: 'id_resp_p_d'
            type: 'string'
          }
          {
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'mac_s'
            type: 'string'
          }
          {
            name: 'framed_addr_s'
            type: 'string'
          }
          {
            name: 'tunnel_client_s'
            type: 'string'
          }
          {
            name: 'connect_info_s'
            type: 'string'
          }
          {
            name: 'reply_msg_s'
            type: 'string'
          }
          {
            name: 'result_s'
            type: 'string'
          }
          {
            name: 'ttl_d'
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
          name: 'Sentinel-Corelight_v2_radius_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_radius_CL']
        destinations: ['Sentinel-Corelight_v2_radius_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), uid_s = tostring(uid_s), id_orig_h_s = tostring(id_orig_h_s), id_orig_p_d = toreal(id_orig_p_d), id_resp_h_s = tostring(id_resp_h_s), id_resp_p_d = toreal(id_resp_p_d), username_s = tostring(username_s), mac_s = tostring(mac_s), framed_addr_s = tostring(framed_addr_s), tunnel_client_s = tostring(tunnel_client_s), connect_info_s = tostring(connect_info_s), reply_msg_s = tostring(reply_msg_s), result_s = tostring(result_s), ttl_d = toreal(ttl_d)'
        outputStream: 'Custom-Corelight_v2_radius_CL'
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
