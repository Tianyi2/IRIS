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
// Data Collection Rule for Corelight_v2_ftp_CL
// ============================================================================
// Generated: 2025-09-19 14:20:04
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-Corelight_v2_ftp_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_ftp_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_ftp_CL': {
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
            name: 'data_channel_resp_h_s'
            type: 'string'
          }
          {
            name: 'data_channel_orig_h_s'
            type: 'string'
          }
          {
            name: 'data_channel_passive_b'
            type: 'string'
          }
          {
            name: 'reply_msg_s'
            type: 'string'
          }
          {
            name: 'reply_code_d'
            type: 'string'
          }
          {
            name: 'file_size_d'
            type: 'string'
          }
          {
            name: 'mime_type_s'
            type: 'string'
          }
          {
            name: 'data_channel_resp_p_d'
            type: 'string'
          }
          {
            name: 'arg_s'
            type: 'string'
          }
          {
            name: 'password_s'
            type: 'string'
          }
          {
            name: 'user_s'
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
            name: 'command_s'
            type: 'string'
          }
          {
            name: 'fuid_s'
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
          name: 'Sentinel-Corelight_v2_ftp_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_ftp_CL']
        destinations: ['Sentinel-Corelight_v2_ftp_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), data_channel_resp_h_s = tostring(data_channel_resp_h_s), data_channel_orig_h_s = tostring(data_channel_orig_h_s), data_channel_passive_b = tobool(data_channel_passive_b), reply_msg_s = tostring(reply_msg_s), reply_code_d = toreal(reply_code_d), file_size_d = toreal(file_size_d), mime_type_s = tostring(mime_type_s), data_channel_resp_p_d = toreal(data_channel_resp_p_d), arg_s = tostring(arg_s), password_s = tostring(password_s), user_s = tostring(user_s), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), command_s = tostring(command_s), fuid_s = tostring(fuid_s)'
        outputStream: 'Custom-Corelight_v2_ftp_CL'
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
