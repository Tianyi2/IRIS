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
// Data Collection Rule for Firework_CL
// ============================================================================
// Generated: 2025-09-19 14:20:18
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 7, DCR columns: 7 (Type column always filtered)
// Output stream: Custom-Firework_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Firework_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Firework_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'data_new_leaks_s'
            type: 'string'
          }
          {
            name: 'risk_score_d'
            type: 'string'
          }
          {
            name: 'last_crawled_at_t'
            type: 'string'
          }
          {
            name: 'category_name_s'
            type: 'string'
          }
          {
            name: 'risk_reasons_s'
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
          name: 'Sentinel-Firework_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Firework_CL']
        destinations: ['Sentinel-Firework_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), source_s = tostring(source_s), data_new_leaks_s = tostring(data_new_leaks_s), risk_score_d = tostring(risk_score_d), last_crawled_at_t = tostring(last_crawled_at_t), category_name_s = tostring(category_name_s), risk_reasons_s = tostring(risk_reasons_s)'
        outputStream: 'Custom-Firework_CL'
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
