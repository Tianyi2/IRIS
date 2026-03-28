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
// Data Collection Rule for Cisco_Umbrella_ip_CL
// ============================================================================
// Generated: 2025-09-19 14:19:59
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 9, DCR columns: 9 (Type column always filtered)
// Output stream: Custom-Cisco_Umbrella_ip_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Cisco_Umbrella_ip_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Cisco_Umbrella_ip_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'Timestamp_t'
            type: 'string'
          }
          {
            name: 'Identity_s'
            type: 'string'
          }
          {
            name: 'Source_IP_s'
            type: 'string'
          }
          {
            name: 'Source_Port_s'
            type: 'string'
          }
          {
            name: 'Destination_IP_s'
            type: 'string'
          }
          {
            name: 'Destination_Port_s'
            type: 'string'
          }
          {
            name: 'Categories_s'
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
          name: 'Sentinel-Cisco_Umbrella_ip_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Cisco_Umbrella_ip_CL']
        destinations: ['Sentinel-Cisco_Umbrella_ip_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventType_s = tostring(EventType_s), Timestamp_t = todatetime(Timestamp_t), Identity_s = tostring(Identity_s), Source_IP_s = tostring(Source_IP_s), Source_Port_s = tostring(Source_Port_s), Destination_IP_s = tostring(Destination_IP_s), Destination_Port_s = tostring(Destination_Port_s), Categories_s = tostring(Categories_s)'
        outputStream: 'Custom-Cisco_Umbrella_ip_CL'
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
