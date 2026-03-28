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
// Data Collection Rule for Corelight_v2_snmp_CL
// ============================================================================
// Generated: 2025-09-19 14:20:11
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 19, DCR columns: 16 (Type column always filtered)
// Output stream: Custom-Corelight_v2_snmp_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_snmp_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_snmp_CL': {
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
            name: 'duration_d'
            type: 'string'
          }
          {
            name: 'version_s'
            type: 'string'
          }
          {
            name: 'community_s'
            type: 'string'
          }
          {
            name: 'get_requests_d'
            type: 'string'
          }
          {
            name: 'get_bulk_requests_d'
            type: 'string'
          }
          {
            name: 'get_responses_d'
            type: 'string'
          }
          {
            name: 'set_requests_d'
            type: 'string'
          }
          {
            name: 'display_string_s'
            type: 'string'
          }
          {
            name: 'up_since_t'
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
          name: 'Sentinel-Corelight_v2_snmp_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_snmp_CL']
        destinations: ['Sentinel-Corelight_v2_snmp_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), uid_s = tostring(uid_s), id_orig_h_s = tostring(id_orig_h_s), id_orig_p_d = toreal(id_orig_p_d), id_resp_h_s = tostring(id_resp_h_s), id_resp_p_d = toreal(id_resp_p_d), duration_d = toreal(duration_d), version_s = tostring(version_s), community_s = tostring(community_s), get_requests_d = toreal(get_requests_d), get_bulk_requests_d = toreal(get_bulk_requests_d), get_responses_d = toreal(get_responses_d), set_requests_d = toreal(set_requests_d), display_string_s = tostring(display_string_s), up_since_t = todatetime(up_since_t)'
        outputStream: 'Custom-Corelight_v2_snmp_CL'
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
