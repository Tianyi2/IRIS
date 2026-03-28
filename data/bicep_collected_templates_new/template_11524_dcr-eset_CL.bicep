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
// Data Collection Rule for eset_CL
// ============================================================================
// Generated: 2025-09-19 14:20:17
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 8, DCR columns: 8 (Type column always filtered)
// Output stream: Custom-eset_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-eset_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-eset_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'object_uri_s'
            type: 'string'
          }
          {
            name: 'hostname_s'
            type: 'string'
          }
          {
            name: 'ipv4_s'
            type: 'string'
          }
          {
            name: 'scanner_id_s'
            type: 'string'
          }
          {
            name: 'threat_name_s'
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
          name: 'Sentinel-eset_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-eset_CL']
        destinations: ['Sentinel-eset_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), event_type_s = tostring(event_type_s), username_s = tostring(username_s), object_uri_s = tostring(object_uri_s), hostname_s = tostring(hostname_s), ipv4_s = tostring(ipv4_s), scanner_id_s = tostring(scanner_id_s), threat_name_s = tostring(threat_name_s)'
        outputStream: 'Custom-eset_CL'
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
