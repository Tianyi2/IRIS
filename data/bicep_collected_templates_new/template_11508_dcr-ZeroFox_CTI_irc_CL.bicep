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
// Data Collection Rule for ZeroFox_CTI_irc_CL
// ============================================================================
// Generated: 2025-09-19 14:20:40
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 12, DCR columns: 12 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_irc_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_irc_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_irc_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'channel_s'
            type: 'string'
          }
          {
            name: 'message_s'
            type: 'string'
          }
          {
            name: 'sender_s'
            type: 'string'
          }
          {
            name: 'timestamp_t'
            type: 'string'
          }
          {
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'hostname_s'
            type: 'string'
          }
          {
            name: 'real_name_s'
            type: 'string'
          }
          {
            name: 'server_s'
            type: 'string'
          }
          {
            name: 'server_info_s'
            type: 'string'
          }
          {
            name: 'secure_b'
            type: 'string'
          }
          {
            name: 'account_s'
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
          name: 'Sentinel-ZeroFox_CTI_irc_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_irc_CL']
        destinations: ['Sentinel-ZeroFox_CTI_irc_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), channel_s = tostring(channel_s), message_s = tostring(message_s), sender_s = tostring(sender_s), timestamp_t = todatetime(timestamp_t), username_s = tostring(username_s), hostname_s = tostring(hostname_s), real_name_s = tostring(real_name_s), server_s = tostring(server_s), server_info_s = tostring(server_info_s), secure_b = tobool(secure_b), account_s = tostring(account_s)'
        outputStream: 'Custom-ZeroFox_CTI_irc_CL'
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
