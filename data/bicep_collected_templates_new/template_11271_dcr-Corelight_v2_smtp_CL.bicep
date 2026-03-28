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
// Data Collection Rule for Corelight_v2_smtp_CL
// ============================================================================
// Generated: 2025-09-19 14:20:11
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 33, DCR columns: 30 (Type column always filtered)
// Output stream: Custom-Corelight_v2_smtp_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_smtp_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_smtp_CL': {
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
            name: 'is_webmail_b'
            type: 'string'
          }
          {
            name: 'fuids_s'
            type: 'string'
          }
          {
            name: 'tls_b'
            type: 'string'
          }
          {
            name: 'user_agent_s'
            type: 'string'
          }
          {
            name: 'path_s'
            type: 'string'
          }
          {
            name: 'last_reply_s'
            type: 'string'
          }
          {
            name: 'second_received_s'
            type: 'string'
          }
          {
            name: 'first_received_s'
            type: 'string'
          }
          {
            name: 'x_originating_ip_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'in_reply_to_s'
            type: 'string'
          }
          {
            name: 'msg_id_s'
            type: 'string'
          }
          {
            name: 'urls_s'
            type: 'string'
          }
          {
            name: 'reply_to_s'
            type: 'string'
          }
          {
            name: 'to_s'
            type: 'string'
          }
          {
            name: 'from_s'
            type: 'string'
          }
          {
            name: 'date_s'
            type: 'string'
          }
          {
            name: 'rcptto_s'
            type: 'string'
          }
          {
            name: 'mailfrom_s'
            type: 'string'
          }
          {
            name: 'helo_s'
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
            name: 'cc_s'
            type: 'string'
          }
          {
            name: 'domains_s'
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
          name: 'Sentinel-Corelight_v2_smtp_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_smtp_CL']
        destinations: ['Sentinel-Corelight_v2_smtp_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), is_webmail_b = tobool(is_webmail_b), fuids_s = tostring(fuids_s), tls_b = tobool(tls_b), user_agent_s = tostring(user_agent_s), path_s = tostring(path_s), last_reply_s = tostring(last_reply_s), second_received_s = tostring(second_received_s), first_received_s = tostring(first_received_s), x_originating_ip_s = tostring(x_originating_ip_s), subject_s = tostring(subject_s), in_reply_to_s = tostring(in_reply_to_s), msg_id_s = tostring(msg_id_s), urls_s = tostring(urls_s), reply_to_s = tostring(reply_to_s), to_s = tostring(to_s), from_s = tostring(from_s), date_s = tostring(date_s), rcptto_s = tostring(rcptto_s), mailfrom_s = tostring(mailfrom_s), helo_s = tostring(helo_s), trans_depth_d = toreal(trans_depth_d), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), cc_s = tostring(cc_s), domains_s = tostring(domains_s)'
        outputStream: 'Custom-Corelight_v2_smtp_CL'
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
