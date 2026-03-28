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
// Data Collection Rule for ZeroFox_CTI_disruption_CL
// ============================================================================
// Generated: 2025-09-19 14:20:39
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 14, DCR columns: 14 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_disruption_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_disruption_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_disruption_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'fqdn_s'
            type: 'string'
          }
          {
            name: 'ip_s'
            type: 'string'
          }
          {
            name: 'host_s'
            type: 'string'
          }
          {
            name: 'registrar_s'
            type: 'string'
          }
          {
            name: 'threat_type_s'
            type: 'string'
          }
          {
            name: 'http_status_d'
            type: 'string'
          }
          {
            name: 'asn_d'
            type: 'string'
          }
          {
            name: 'iana_d'
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
            name: 'category_s'
            type: 'string'
          }
          {
            name: 'network_s'
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
          name: 'Sentinel-ZeroFox_CTI_disruption_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_disruption_CL']
        destinations: ['Sentinel-ZeroFox_CTI_disruption_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), url_s = tostring(url_s), fqdn_s = tostring(fqdn_s), ip_s = tostring(ip_s), host_s = tostring(host_s), registrar_s = tostring(registrar_s), threat_type_s = tostring(threat_type_s), http_status_d = toreal(http_status_d), asn_d = toreal(asn_d), iana_d = toreal(iana_d), created_at_t = todatetime(created_at_t), updated_at_t = todatetime(updated_at_t), category_s = tostring(category_s), network_s = tostring(network_s)'
        outputStream: 'Custom-ZeroFox_CTI_disruption_CL'
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
