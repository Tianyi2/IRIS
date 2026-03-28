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
// Data Collection Rule for DuoSecurityAdministration_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 8, DCR columns: 8 (Type column always filtered)
// Output stream: Custom-DuoSecurityAdministration_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DuoSecurityAdministration_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DuoSecurityAdministration_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'isotimestamp_t'
            type: 'string'
          }
          {
            name: 'object_s'
            type: 'string'
          }
          {
            name: 'timestamp_d'
            type: 'string'
          }
          {
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'description_s'
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
          name: 'Sentinel-DuoSecurityAdministration_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DuoSecurityAdministration_CL']
        destinations: ['Sentinel-DuoSecurityAdministration_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), RawData = tostring(RawData), action_s = tostring(action_s), isotimestamp_t = todatetime(isotimestamp_t), object_s = tostring(object_s), timestamp_d = toreal(timestamp_d), username_s = tostring(username_s), description_s = tostring(description_s)'
        outputStream: 'Custom-DuoSecurityAdministration_CL'
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
