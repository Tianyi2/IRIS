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
// Data Collection Rule for DuoSecurityTelephony_CL
// ============================================================================
// Generated: 2025-09-19 14:20:17
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 7, DCR columns: 7 (Type column always filtered)
// Output stream: Custom-DuoSecurityTelephony_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DuoSecurityTelephony_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DuoSecurityTelephony_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'context_s'
            type: 'string'
          }
          {
            name: 'credits_d'
            type: 'string'
          }
          {
            name: 'isotimestamp_t'
            type: 'string'
          }
          {
            name: 'phone_s'
            type: 'string'
          }
          {
            name: 'timestamp_d'
            type: 'string'
          }
          {
            name: 'type_s'
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
          name: 'Sentinel-DuoSecurityTelephony_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DuoSecurityTelephony_CL']
        destinations: ['Sentinel-DuoSecurityTelephony_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), context_s = tostring(context_s), credits_d = toreal(credits_d), isotimestamp_t = todatetime(isotimestamp_t), phone_s = tostring(phone_s), timestamp_d = toreal(timestamp_d), type_s = tostring(type_s)'
        outputStream: 'Custom-DuoSecurityTelephony_CL'
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
