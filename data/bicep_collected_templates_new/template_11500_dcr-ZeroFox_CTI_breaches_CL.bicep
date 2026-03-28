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
// Data Collection Rule for ZeroFox_CTI_breaches_CL
// ============================================================================
// Generated: 2025-09-19 14:20:39
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 20, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_breaches_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_breaches_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_breaches_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'id_s'
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
            name: 'geography_country_s'
            type: 'string'
          }
          {
            name: 'geography_sub_region_s'
            type: 'string'
          }
          {
            name: 'geography_region_s'
            type: 'string'
          }
          {
            name: 'geography_country_iso_alpha3_code_s'
            type: 'string'
          }
          {
            name: 'geography_country_code_s'
            type: 'string'
          }
          {
            name: 'tlp_s'
            type: 'string'
          }
          {
            name: 'geography_sub_region_code_s'
            type: 'string'
          }
          {
            name: 'threat_type_s'
            type: 'string'
          }
          {
            name: 'record_count_d'
            type: 'string'
          }
          {
            name: 'included_fields_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'breach_date_t'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'geography_region_code_s'
            type: 'string'
          }
          {
            name: 'industry_s'
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
          name: 'Sentinel-ZeroFox_CTI_breaches_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_breaches_CL']
        destinations: ['Sentinel-ZeroFox_CTI_breaches_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), id_s = toreal(id_s), reliability_s = tostring(reliability_s), confidence_s = tostring(confidence_s), geography_country_s = tostring(geography_country_s), geography_sub_region_s = tostring(geography_sub_region_s), geography_region_s = tostring(geography_region_s), geography_country_iso_alpha3_code_s = tostring(geography_country_iso_alpha3_code_s), geography_country_code_s = tostring(geography_country_code_s), tlp_s = tostring(tlp_s), geography_sub_region_code_s = tostring(geography_sub_region_code_s), threat_type_s = tostring(threat_type_s), record_count_d = toreal(record_count_d), included_fields_s = tostring(included_fields_s), created_at_t = todatetime(created_at_t), breach_date_t = todatetime(breach_date_t), description_s = tostring(description_s), name_s = tostring(name_s), geography_region_code_s = tostring(geography_region_code_s), industry_s = tostring(industry_s)'
        outputStream: 'Custom-ZeroFox_CTI_breaches_CL'
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
