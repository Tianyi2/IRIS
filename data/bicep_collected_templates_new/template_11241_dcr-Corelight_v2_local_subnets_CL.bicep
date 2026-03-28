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
// Data Collection Rule for Corelight_v2_local_subnets_CL
// ============================================================================
// Generated: 2025-09-19 14:20:07
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 13, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-Corelight_v2_local_subnets_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_local_subnets_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_local_subnets_CL': {
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
            name: 'ts_t'
            type: 'string'
          }
          {
            name: 'ip_version_d'
            type: 'string'
          }
          {
            name: 'subnets_s'
            type: 'string'
          }
          {
            name: 'component_ids_s'
            type: 'string'
          }
          {
            name: 'size_of_component_d'
            type: 'string'
          }
          {
            name: 'bipartite_b'
            type: 'string'
          }
          {
            name: 'inferred_site_b'
            type: 'string'
          }
          {
            name: 'other_ips_s'
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
          name: 'Sentinel-Corelight_v2_local_subnets_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_local_subnets_CL']
        destinations: ['Sentinel-Corelight_v2_local_subnets_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), round_d = toreal(round_d), ts_t = todatetime(ts_t), ip_version_d = toreal(ip_version_d), subnets_s = tostring(subnets_s), component_ids_s = tostring(component_ids_s), size_of_component_d = toreal(size_of_component_d), bipartite_b = tobool(bipartite_b), inferred_site_b = tobool(inferred_site_b), other_ips_s = tostring(other_ips_s)'
        outputStream: 'Custom-Corelight_v2_local_subnets_CL'
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
