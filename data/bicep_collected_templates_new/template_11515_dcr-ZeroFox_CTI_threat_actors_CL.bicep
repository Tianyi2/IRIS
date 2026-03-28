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
// Data Collection Rule for ZeroFox_CTI_threat_actors_CL
// ============================================================================
// Generated: 2025-09-19 14:20:40
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 13, DCR columns: 13 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_threat_actors_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_threat_actors_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_threat_actors_CL': {
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
            name: 'mitre_id_s'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'updated_at_t'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'references_s'
            type: 'string'
          }
          {
            name: 'software_s'
            type: 'string'
          }
          {
            name: 'associated_groups_s'
            type: 'string'
          }
          {
            name: 'target_geo_s'
            type: 'string'
          }
          {
            name: 'target_industries_s'
            type: 'string'
          }
          {
            name: 'mitre_ttps_s'
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
          name: 'Sentinel-ZeroFox_CTI_threat_actors_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_threat_actors_CL']
        destinations: ['Sentinel-ZeroFox_CTI_threat_actors_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), id_d = toreal(id_d), mitre_id_s = tostring(mitre_id_s), name_s = tostring(name_s), created_at_t = todatetime(created_at_t), updated_at_t = todatetime(updated_at_t), description_s = tostring(description_s), references_s = tostring(references_s), software_s = tostring(software_s), associated_groups_s = tostring(associated_groups_s), target_geo_s = tostring(target_geo_s), target_industries_s = tostring(target_industries_s), mitre_ttps_s = tostring(mitre_ttps_s)'
        outputStream: 'Custom-ZeroFox_CTI_threat_actors_CL'
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
