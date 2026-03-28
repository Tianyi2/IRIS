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
// Data Collection Rule for Corelight_v2_sip_CL
// ============================================================================
// Generated: 2025-09-19 14:20:10
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 31, DCR columns: 28 (Type column always filtered)
// Output stream: Custom-Corelight_v2_sip_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_sip_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_sip_CL': {
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
            name: 'request_body_len_d'
            type: 'string'
          }
          {
            name: 'warning_s'
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
            name: 'user_agent_s'
            type: 'string'
          }
          {
            name: 'response_path_s'
            type: 'string'
          }
          {
            name: 'request_path_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'seq_s'
            type: 'string'
          }
          {
            name: 'call_id_s'
            type: 'string'
          }
          {
            name: 'reply_to_s'
            type: 'string'
          }
          {
            name: 'response_body_len_d'
            type: 'string'
          }
          {
            name: 'response_to_s'
            type: 'string'
          }
          {
            name: 'request_to_s'
            type: 'string'
          }
          {
            name: 'request_from_s'
            type: 'string'
          }
          {
            name: 'date_s'
            type: 'string'
          }
          {
            name: 'uri_s'
            type: 'string'
          }
          {
            name: 'method_s'
            type: 'string'
          }
          {
            name: 'trans_depth_d'
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
            name: 'response_from_s'
            type: 'string'
          }
          {
            name: 'content_type_s'
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
          name: 'Sentinel-Corelight_v2_sip_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_sip_CL']
        destinations: ['Sentinel-Corelight_v2_sip_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), request_body_len_d = toreal(request_body_len_d), warning_s = tostring(warning_s), status_msg_s = tostring(status_msg_s), status_code_d = toreal(status_code_d), user_agent_s = tostring(user_agent_s), response_path_s = tostring(response_path_s), request_path_s = tostring(request_path_s), subject_s = tostring(subject_s), seq_s = tostring(seq_s), call_id_s = tostring(call_id_s), reply_to_s = tostring(reply_to_s), response_body_len_d = toreal(response_body_len_d), response_to_s = tostring(response_to_s), request_to_s = tostring(request_to_s), request_from_s = tostring(request_from_s), date_s = tostring(date_s), uri_s = tostring(uri_s), method_s = tostring(method_s), trans_depth_d = toreal(trans_depth_d), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), response_from_s = tostring(response_from_s), content_type_s = tostring(content_type_s)'
        outputStream: 'Custom-Corelight_v2_sip_CL'
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
