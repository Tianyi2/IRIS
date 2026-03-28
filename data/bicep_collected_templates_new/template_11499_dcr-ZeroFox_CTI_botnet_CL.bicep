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
// Data Collection Rule for ZeroFox_CTI_botnet_CL
// ============================================================================
// Generated: 2025-09-19 14:20:38
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 21, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_botnet_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_botnet_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_botnet_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'listed_at_t'
            type: 'string'
          }
          {
            name: 'estimated_infected_at_t'
            type: 'string'
          }
          {
            name: 'logged_at_t'
            type: 'string'
          }
          {
            name: 'acquired_at_t'
            type: 'string'
          }
          {
            name: 'process_elevation_s'
            type: 'string'
          }
          {
            name: 'uac_s'
            type: 'string'
          }
          {
            name: 'available_keyboards_s'
            type: 'string'
          }
          {
            name: 'current_language_s'
            type: 'string'
          }
          {
            name: 'location_s'
            type: 'string'
          }
          {
            name: 'zip_code_s'
            type: 'string'
          }
          {
            name: 'country_code_s'
            type: 'string'
          }
          {
            name: 'anti_viruses_s'
            type: 'string'
          }
          {
            name: 'operating_system_s'
            type: 'string'
          }
          {
            name: 'file_location_s'
            type: 'string'
          }
          {
            name: 'is_common_domain_b'
            type: 'string'
          }
          {
            name: 'c2_domain_s'
            type: 'string'
          }
          {
            name: 'c2_ip_address_s'
            type: 'string'
          }
          {
            name: 'bot_name_s'
            type: 'string'
          }
          {
            name: 'breached_at'
            type: 'string'
          }
          {
            name: 'tags_s'
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
          name: 'Sentinel-ZeroFox_CTI_botnet_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_botnet_CL']
        destinations: ['Sentinel-ZeroFox_CTI_botnet_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), listed_at_t = todatetime(listed_at_t), estimated_infected_at_t = todatetime(estimated_infected_at_t), logged_at_t = todatetime(logged_at_t), acquired_at_t = todatetime(acquired_at_t), process_elevation_s = tostring(process_elevation_s), uac_s = tostring(uac_s), available_keyboards_s = tostring(available_keyboards_s), current_language_s = tostring(current_language_s), location_s = tostring(location_s), zip_code_s = tostring(zip_code_s), country_code_s = tostring(country_code_s), anti_viruses_s = tostring(anti_viruses_s), operating_system_s = tostring(operating_system_s), file_location_s = tostring(file_location_s), is_common_domain_b = tobool(is_common_domain_b), c2_domain_s = tostring(c2_domain_s), c2_ip_address_s = tostring(c2_ip_address_s), bot_name_s = tostring(bot_name_s), breached_at = todatetime(breached_at), tags_s = tostring(tags_s)'
        outputStream: 'Custom-ZeroFox_CTI_botnet_CL'
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
