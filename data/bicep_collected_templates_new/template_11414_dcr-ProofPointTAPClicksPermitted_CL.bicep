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
// Data Collection Rule for ProofPointTAPClicksPermitted_CL
// ============================================================================
// Generated: 2025-09-19 14:20:29
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 10, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-ProofPointTAPClicksPermitted_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ProofPointTAPClicksPermitted_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ProofPointTAPClicksPermitted_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'threatsInfoMap_s'
            type: 'string'
          }
          {
            name: 'messageParts_s'
            type: 'string'
          }
          {
            name: 'sender_s'
            type: 'string'
          }
          {
            name: 'senderIP_s'
            type: 'string'
          }
          {
            name: 'recipient_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'clickTime_t'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'classification_s'
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
          name: 'Sentinel-ProofPointTAPClicksPermitted_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ProofPointTAPClicksPermitted_CL']
        destinations: ['Sentinel-ProofPointTAPClicksPermitted_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), threatsInfoMap_s = tostring(threatsInfoMap_s), messageParts_s = tostring(messageParts_s), sender_s = tostring(sender_s), senderIP_s = tostring(senderIP_s), recipient_s = tostring(recipient_s), subject_s = tostring(subject_s), clickTime_t = todatetime(clickTime_t), url_s = tostring(url_s), classification_s = tostring(classification_s)'
        outputStream: 'Custom-ProofPointTAPClicksPermitted_CL'
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
