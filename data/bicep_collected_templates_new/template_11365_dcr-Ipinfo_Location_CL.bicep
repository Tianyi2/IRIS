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
// Data Collection Rule for Ipinfo_Location_CL
// ============================================================================
// Generated: 2025-09-19 14:20:22
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 11, DCR columns: 11 (Type column always filtered)
// Output stream: Custom-Ipinfo_Location_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Ipinfo_Location_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Ipinfo_Location_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'city'
            type: 'string'
          }
          {
            name: 'country'
            type: 'string'
          }
          {
            name: 'geoname_id'
            type: 'string'
          }
          {
            name: 'lat'
            type: 'string'
          }
          {
            name: 'lng'
            type: 'string'
          }
          {
            name: 'postal_code'
            type: 'string'
          }
          {
            name: 'region'
            type: 'string'
          }
          {
            name: 'region_code'
            type: 'string'
          }
          {
            name: 'range'
            type: 'string'
          }
          {
            name: 'timezone'
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
          name: 'Sentinel-Ipinfo_Location_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Ipinfo_Location_CL']
        destinations: ['Sentinel-Ipinfo_Location_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), city = tostring(city), country = tostring(country), geoname_id = tostring(geoname_id), lat = tostring(lat), lng = tostring(lng), postal_code = tostring(postal_code), region = tostring(region), region_code = tostring(region_code), range = tostring(range), timezone = tostring(timezone)'
        outputStream: 'Custom-Ipinfo_Location_CL'
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
