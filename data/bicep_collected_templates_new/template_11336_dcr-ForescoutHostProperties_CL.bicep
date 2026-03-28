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
// Data Collection Rule for ForescoutHostProperties_CL
// ============================================================================
// Generated: 2025-09-19 14:20:19
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 6, DCR columns: 6 (Type column always filtered)
// Output stream: Custom-ForescoutHostProperties_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ForescoutHostProperties_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ForescoutHostProperties_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'HostProperties_DnsniffEvent_s'
            type: 'string'
          }
          {
            name: 'HostProperties_Ipv4Addr_s'
            type: 'string'
          }
          {
            name: 'HostProperties_Ipv6Addr_s'
            type: 'string'
          }
          {
            name: 'HostProperties_IpAddr_s'
            type: 'string'
          }
          {
            name: 'HostProperties_EmIpAddr_s'
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
          name: 'Sentinel-ForescoutHostProperties_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ForescoutHostProperties_CL']
        destinations: ['Sentinel-ForescoutHostProperties_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), HostProperties_DnsniffEvent_s = tostring(HostProperties_DnsniffEvent_s), HostProperties_Ipv4Addr_s = tostring(HostProperties_Ipv4Addr_s), HostProperties_Ipv6Addr_s = tostring(HostProperties_Ipv6Addr_s), HostProperties_IpAddr_s = tostring(HostProperties_IpAddr_s), HostProperties_EmIpAddr_s = tostring(HostProperties_EmIpAddr_s)'
        outputStream: 'Custom-ForescoutHostProperties_CL'
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
