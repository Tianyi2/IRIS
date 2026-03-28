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
// Data Collection Rule for Corelight_v2_http2_CL
// ============================================================================
// Generated: 2025-09-19 14:20:05
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 28, DCR columns: 25 (Type column always filtered)
// Output stream: Custom-Corelight_v2_http2_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_http2_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_http2_CL': {
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
            name: 'password_s'
            type: 'string'
          }
          {
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'encoding_s'
            type: 'string'
          }
          {
            name: 'info_msg_s'
            type: 'string'
          }
          {
            name: 'info_code_d'
            type: 'string'
          }
          {
            name: 'status_msg_s'
            type: 'string'
          }
          {
            name: 'status_code_d'
            type: 'string'
          }
          {
            name: 'response_body_len_d'
            type: 'string'
          }
          {
            name: 'request_body_len_d'
            type: 'string'
          }
          {
            name: 'user_agent_s'
            type: 'string'
          }
          {
            name: 'version_s'
            type: 'string'
          }
          {
            name: 'referrer_s'
            type: 'string'
          }
          {
            name: 'uri_s'
            type: 'string'
          }
          {
            name: 'host_s'
            type: 'string'
          }
          {
            name: 'method_s'
            type: 'string'
          }
          {
            name: 'stream_id_d'
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
            name: 'proxied_s'
            type: 'string'
          }
          {
            name: 'push_b'
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
          name: 'Sentinel-Corelight_v2_http2_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_http2_CL']
        destinations: ['Sentinel-Corelight_v2_http2_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), password_s = tostring(password_s), username_s = tostring(username_s), encoding_s = tostring(encoding_s), info_msg_s = tostring(info_msg_s), info_code_d = toreal(info_code_d), status_msg_s = tostring(status_msg_s), status_code_d = toreal(status_code_d), response_body_len_d = toreal(response_body_len_d), request_body_len_d = toreal(request_body_len_d), user_agent_s = tostring(user_agent_s), version_s = tostring(version_s), referrer_s = tostring(referrer_s), uri_s = tostring(uri_s), host_s = tostring(host_s), method_s = tostring(method_s), stream_id_d = toreal(stream_id_d), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), proxied_s = tostring(proxied_s), push_b = tobool(push_b)'
        outputStream: 'Custom-Corelight_v2_http2_CL'
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
