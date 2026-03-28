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
// Data Collection Rule for ZeroFox_CTI_discord_CL
// ============================================================================
// Generated: 2025-09-19 14:20:39
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 7, DCR columns: 7 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_discord_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_discord_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_discord_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'author_id_s'
            type: 'string'
          }
          {
            name: 'author_username_s'
            type: 'string'
          }
          {
            name: 'channel_name_s'
            type: 'string'
          }
          {
            name: 'content_s'
            type: 'string'
          }
          {
            name: 'server_name_s'
            type: 'string'
          }
          {
            name: 'timestamp_t'
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
          name: 'Sentinel-ZeroFox_CTI_discord_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_discord_CL']
        destinations: ['Sentinel-ZeroFox_CTI_discord_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), author_id_s = tostring(author_id_s), author_username_s = tostring(author_username_s), channel_name_s = tostring(channel_name_s), content_s = tostring(content_s), server_name_s = tostring(server_name_s), timestamp_t = todatetime(timestamp_t)'
        outputStream: 'Custom-ZeroFox_CTI_discord_CL'
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
