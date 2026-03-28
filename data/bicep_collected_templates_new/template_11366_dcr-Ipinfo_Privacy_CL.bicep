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
// Data Collection Rule for Ipinfo_Privacy_CL
// ============================================================================
// Generated: 2025-09-19 14:20:22
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 8, DCR columns: 8 (Type column always filtered)
// Output stream: Custom-Ipinfo_Privacy_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Ipinfo_Privacy_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Ipinfo_Privacy_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'hosting'
            type: 'string'
          }
          {
            name: 'proxy'
            type: 'string'
          }
          {
            name: 'relay'
            type: 'string'
          }
          {
            name: 'service'
            type: 'string'
          }
          {
            name: 'tor'
            type: 'string'
          }
          {
            name: 'vpn'
            type: 'string'
          }
          {
            name: 'range'
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
          name: 'Sentinel-Ipinfo_Privacy_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Ipinfo_Privacy_CL']
        destinations: ['Sentinel-Ipinfo_Privacy_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), hosting = tostring(hosting), proxy = tostring(proxy), relay = tostring(relay), service = tostring(service), tor = tostring(tor), vpn = tostring(vpn), range = tostring(range)'
        outputStream: 'Custom-Ipinfo_Privacy_CL'
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
