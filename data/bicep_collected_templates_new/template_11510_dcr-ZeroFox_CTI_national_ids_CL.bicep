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
// Data Collection Rule for ZeroFox_CTI_national_ids_CL
// ============================================================================
// Generated: 2025-09-19 14:20:40
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 9, DCR columns: 9 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_national_ids_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_national_ids_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_national_ids_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'national_identifier_s'
            type: 'string'
          }
          {
            name: 'country_s'
            type: 'string'
          }
          {
            name: 'first_name_s'
            type: 'string'
          }
          {
            name: 'last_name_s'
            type: 'string'
          }
          {
            name: 'person_name_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'breach_name_s'
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
          name: 'Sentinel-ZeroFox_CTI_national_ids_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_national_ids_CL']
        destinations: ['Sentinel-ZeroFox_CTI_national_ids_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), national_identifier_s = tostring(national_identifier_s), country_s = tostring(country_s), first_name_s = tostring(first_name_s), last_name_s = tostring(last_name_s), person_name_s = tostring(person_name_s), created_at_t = todatetime(created_at_t), source_s = tostring(source_s), breach_name_s = tostring(breach_name_s)'
        outputStream: 'Custom-ZeroFox_CTI_national_ids_CL'
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
