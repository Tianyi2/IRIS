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
// Data Collection Rule for Corelight_v2_signatures_CL
// ============================================================================
// Generated: 2025-09-19 14:20:10
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 16, DCR columns: 13 (Type column always filtered)
// Output stream: Custom-Corelight_v2_signatures_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_signatures_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_signatures_CL': {
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
            name: 'src_addr_s'
            type: 'string'
          }
          {
            name: 'src_port_d'
            type: 'string'
          }
          {
            name: 'dst_addr_s'
            type: 'string'
          }
          {
            name: 'dst_port_d'
            type: 'string'
          }
          {
            name: 'note_s'
            type: 'string'
          }
          {
            name: 'sig_id_s'
            type: 'string'
          }
          {
            name: 'event_msg_s'
            type: 'string'
          }
          {
            name: 'sub_msg_s'
            type: 'string'
          }
          {
            name: 'sig_count_d'
            type: 'string'
          }
          {
            name: 'host_count_d'
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
          name: 'Sentinel-Corelight_v2_signatures_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_signatures_CL']
        destinations: ['Sentinel-Corelight_v2_signatures_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), uid_s = tostring(uid_s), src_addr_s = tostring(src_addr_s), src_port_d = toreal(src_port_d), dst_addr_s = tostring(dst_addr_s), dst_port_d = toreal(dst_port_d), note_s = tostring(note_s), sig_id_s = tostring(sig_id_s), event_msg_s = tostring(event_msg_s), sub_msg_s = tostring(sub_msg_s), sig_count_d = toreal(sig_count_d), host_count_d = toreal(host_count_d)'
        outputStream: 'Custom-Corelight_v2_signatures_CL'
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
