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
// Data Collection Rule for Corelight_v2_kerberos_CL
// ============================================================================
// Generated: 2025-09-19 14:20:06
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 24, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-Corelight_v2_kerberos_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_kerberos_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_kerberos_CL': {
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
            name: 'client_cert_fuid_s'
            type: 'string'
          }
          {
            name: 'client_cert_subject_s'
            type: 'string'
          }
          {
            name: 'renewable_b'
            type: 'string'
          }
          {
            name: 'forwardable_b'
            type: 'string'
          }
          {
            name: 'cipher_s'
            type: 'string'
          }
          {
            name: 'till_t'
            type: 'string'
          }
          {
            name: 'from_t'
            type: 'string'
          }
          {
            name: 'error_msg_s'
            type: 'string'
          }
          {
            name: 'success_b'
            type: 'string'
          }
          {
            name: 'service_s'
            type: 'string'
          }
          {
            name: 'client_s'
            type: 'string'
          }
          {
            name: 'request_type_s'
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
            name: 'server_cert_subject_s'
            type: 'string'
          }
          {
            name: 'server_cert_fuid_s'
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
          name: 'Sentinel-Corelight_v2_kerberos_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_kerberos_CL']
        destinations: ['Sentinel-Corelight_v2_kerberos_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), client_cert_fuid_s = tostring(client_cert_fuid_s), client_cert_subject_s = tostring(client_cert_subject_s), renewable_b = tobool(renewable_b), forwardable_b = tobool(forwardable_b), cipher_s = tostring(cipher_s), till_t = todatetime(till_t), from_t = todatetime(from_t), error_msg_s = tostring(error_msg_s), success_b = tobool(success_b), service_s = tostring(service_s), client_s = tostring(client_s), request_type_s = tostring(request_type_s), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), server_cert_subject_s = tostring(server_cert_subject_s), server_cert_fuid_s = tostring(server_cert_fuid_s)'
        outputStream: 'Custom-Corelight_v2_kerberos_CL'
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
