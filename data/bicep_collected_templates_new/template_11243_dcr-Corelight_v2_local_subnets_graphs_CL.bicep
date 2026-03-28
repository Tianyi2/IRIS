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
// Data Collection Rule for Corelight_v2_local_subnets_graphs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:07
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 9, DCR columns: 6 (Type column always filtered)
// Output stream: Custom-Corelight_v2_local_subnets_graphs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_local_subnets_graphs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_local_subnets_graphs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'round_d'
            type: 'string'
          }
          {
            name: 'component_id_d'
            type: 'string'
          }
          {
            name: 'ip_version_d'
            type: 'string'
          }
          {
            name: 'v1_s'
            type: 'string'
          }
          {
            name: 'v2_s'
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
          name: 'Sentinel-Corelight_v2_local_subnets_graphs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_local_subnets_graphs_CL']
        destinations: ['Sentinel-Corelight_v2_local_subnets_graphs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), round_d = toreal(round_d), component_id_d = toreal(component_id_d), ip_version_d = toreal(ip_version_d), v1_s = tostring(v1_s), v2_s = tostring(v2_s)'
        outputStream: 'Custom-Corelight_v2_local_subnets_graphs_CL'
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
