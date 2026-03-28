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
// Data Collection Rule for ZeroFox_CTI_advanced_dark_web_CL
// ============================================================================
// Generated: 2025-09-19 14:20:38
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_advanced_dark_web_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_advanced_dark_web_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_advanced_dark_web_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'tags_s'
            type: 'string'
          }
          {
            name: 'actors_s'
            type: 'string'
          }
          {
            name: 'languages_s'
            type: 'string'
          }
          {
            name: 'target_industries_s'
            type: 'string'
          }
          {
            name: 'target_regions_s'
            type: 'string'
          }
          {
            name: 'target_targets_s'
            type: 'string'
          }
          {
            name: 'source_urls_s'
            type: 'string'
          }
          {
            name: 'threat_types_s'
            type: 'string'
          }
          {
            name: 'contents_s'
            type: 'string'
          }
          {
            name: 'tlp'
            type: 'string'
          }
          {
            name: 'reliability_s'
            type: 'string'
          }
          {
            name: 'confidence_s'
            type: 'string'
          }
          {
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'comments_s'
            type: 'string'
          }
          {
            name: 'source_names_s'
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
          name: 'Sentinel-ZeroFox_CTI_advanced_dark_web_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_advanced_dark_web_CL']
        destinations: ['Sentinel-ZeroFox_CTI_advanced_dark_web_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), id_d = toreal(id_d), tags_s = tostring(tags_s), actors_s = tostring(actors_s), languages_s = tostring(languages_s), target_industries_s = tostring(target_industries_s), target_regions_s = tostring(target_regions_s), target_targets_s = tostring(target_targets_s), source_urls_s = tostring(source_urls_s), threat_types_s = tostring(threat_types_s), contents_s = tostring(contents_s), tlp = tostring(tlp), reliability_s = tostring(reliability_s), confidence_s = tostring(confidence_s), title_s = tostring(title_s), created_at_t = todatetime(created_at_t), comments_s = tostring(comments_s), source_names_s = tostring(source_names_s)'
        outputStream: 'Custom-ZeroFox_CTI_advanced_dark_web_CL'
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
