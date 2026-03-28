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
// Data Collection Rule for ProofPointTAPMessagesDelivered_CL
// ============================================================================
// Generated: 2025-09-19 14:20:29
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 10, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-ProofPointTAPMessagesDelivered_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ProofPointTAPMessagesDelivered_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ProofPointTAPMessagesDelivered_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'threatsInfoMap_s'
            type: 'dynamic'
          }
          {
            name: 'messageParts_s'
            type: 'dynamic'
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
            name: 'threatType'
            type: 'string'
          }
          {
            name: 'classification'
            type: 'string'
          }
          {
            name: 'filename'
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
          name: 'Sentinel-ProofPointTAPMessagesDelivered_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ProofPointTAPMessagesDelivered_CL']
        destinations: ['Sentinel-ProofPointTAPMessagesDelivered_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), threatsInfoMap_s = todynamic(threatsInfoMap_s), messageParts_s = todynamic(messageParts_s), sender_s = tostring(sender_s), senderIP_s = tostring(senderIP_s), recipient_s = tostring(recipient_s), subject_s = tostring(subject_s), threatType = tostring(threatType), classification = tostring(classification), filename = tostring(filename)'
        outputStream: 'Custom-ProofPointTAPMessagesDelivered_CL'
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
