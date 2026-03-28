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
// Data Collection Rule for Corelight_v2_dns_CL
// ============================================================================
// Generated: 2025-09-19 14:20:03
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 28, DCR columns: 25 (Type column always filtered)
// Output stream: Custom-Corelight_v2_dns_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_dns_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_dns_CL': {
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
            name: 'answers_s'
            type: 'string'
          }
          {
            name: 'Z_d'
            type: 'string'
          }
          {
            name: 'RA_b'
            type: 'string'
          }
          {
            name: 'RD_b'
            type: 'string'
          }
          {
            name: 'TC_b'
            type: 'string'
          }
          {
            name: 'AA_b'
            type: 'string'
          }
          {
            name: 'rcode_name_s'
            type: 'string'
          }
          {
            name: 'rcode_d'
            type: 'string'
          }
          {
            name: 'qtype_name_s'
            type: 'string'
          }
          {
            name: 'qtype_d'
            type: 'string'
          }
          {
            name: 'qclass_name_s'
            type: 'string'
          }
          {
            name: 'qclass_d'
            type: 'string'
          }
          {
            name: 'query_s'
            type: 'string'
          }
          {
            name: 'rtt_d'
            type: 'string'
          }
          {
            name: 'trans_id_d'
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
            name: 'TTLs_s'
            type: 'string'
          }
          {
            name: 'rejected_b'
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
          name: 'Sentinel-Corelight_v2_dns_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_dns_CL']
        destinations: ['Sentinel-Corelight_v2_dns_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), answers_s = tostring(answers_s), Z_d = toreal(Z_d), RA_b = tobool(RA_b), RD_b = tobool(RD_b), TC_b = tobool(TC_b), AA_b = tobool(AA_b), rcode_name_s = tostring(rcode_name_s), rcode_d = toreal(rcode_d), qtype_name_s = tostring(qtype_name_s), qtype_d = toreal(qtype_d), qclass_name_s = tostring(qclass_name_s), qclass_d = toreal(qclass_d), query_s = tostring(query_s), rtt_d = toreal(rtt_d), trans_id_d = toreal(trans_id_d), proto_s = tostring(proto_s), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), TTLs_s = tostring(TTLs_s), rejected_b = tobool(rejected_b)'
        outputStream: 'Custom-Corelight_v2_dns_CL'
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
