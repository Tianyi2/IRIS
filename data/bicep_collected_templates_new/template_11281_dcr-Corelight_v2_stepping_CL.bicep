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
// Data Collection Rule for Corelight_v2_stepping_CL
// ============================================================================
// Generated: 2025-09-19 14:20:12
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 14 (Type column always filtered)
// Output stream: Custom-Corelight_v2_stepping_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_stepping_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_stepping_CL': {
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
            name: 'dt_d'
            type: 'string'
          }
          {
            name: 'uid1_s'
            type: 'string'
          }
          {
            name: 'uid2_s'
            type: 'string'
          }
          {
            name: 'direct_b'
            type: 'string'
          }
          {
            name: 'client1_h_s'
            type: 'string'
          }
          {
            name: 'client1_p_d'
            type: 'string'
          }
          {
            name: 'server1_h_s'
            type: 'string'
          }
          {
            name: 'server1_p_d'
            type: 'string'
          }
          {
            name: 'client2_h_s'
            type: 'string'
          }
          {
            name: 'client2_p_d'
            type: 'string'
          }
          {
            name: 'server2_h_s'
            type: 'string'
          }
          {
            name: 'server2_p_d'
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
          name: 'Sentinel-Corelight_v2_stepping_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_stepping_CL']
        destinations: ['Sentinel-Corelight_v2_stepping_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), dt_d = toreal(dt_d), uid1_s = tostring(uid1_s), uid2_s = tostring(uid2_s), direct_b = tobool(direct_b), client1_h_s = tostring(client1_h_s), client1_p_d = toreal(client1_p_d), server1_h_s = tostring(server1_h_s), server1_p_d = toreal(server1_p_d), client2_h_s = tostring(client2_h_s), client2_p_d = toreal(client2_p_d), server2_h_s = tostring(server2_h_s), server2_p_d = toreal(server2_p_d)'
        outputStream: 'Custom-Corelight_v2_stepping_CL'
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
