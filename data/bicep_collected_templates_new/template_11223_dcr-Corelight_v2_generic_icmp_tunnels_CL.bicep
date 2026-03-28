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
// Data Collection Rule for Corelight_v2_generic_icmp_tunnels_CL
// ============================================================================
// Generated: 2025-09-19 14:20:05
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 14, DCR columns: 11 (Type column always filtered)
// Output stream: Custom-Corelight_v2_generic_icmp_tunnels_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_generic_icmp_tunnels_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_generic_icmp_tunnels_CL': {
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
            name: 'detection_s'
            type: 'string'
          }
          {
            name: 'orig_s'
            type: 'string'
          }
          {
            name: 'resp_s'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'seq_d'
            type: 'string'
          }
          {
            name: 'bytes_d'
            type: 'string'
          }
          {
            name: 'payload_len_d'
            type: 'string'
          }
          {
            name: 'payload_s'
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
          name: 'Sentinel-Corelight_v2_generic_icmp_tunnels_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_generic_icmp_tunnels_CL']
        destinations: ['Sentinel-Corelight_v2_generic_icmp_tunnels_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), uid_s = tostring(uid_s), detection_s = tostring(detection_s), orig_s = tostring(orig_s), resp_s = tostring(resp_s), id_d = toreal(id_d), seq_d = toreal(seq_d), bytes_d = toreal(bytes_d), payload_len_d = toreal(payload_len_d), payload_s = tostring(payload_s)'
        outputStream: 'Custom-Corelight_v2_generic_icmp_tunnels_CL'
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
