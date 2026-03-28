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
// Data Collection Rule for MimecastTTPAttachment_CL
// ============================================================================
// Generated: 2025-09-19 14:20:25
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 17 (Type column always filtered)
// Output stream: Custom-MimecastTTPAttachment_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MimecastTTPAttachment_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MimecastTTPAttachment_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'senderAddress_s'
            type: 'string'
          }
          {
            name: 'recipientAddress_s'
            type: 'string'
          }
          {
            name: 'fileName_s'
            type: 'string'
          }
          {
            name: 'fileType_s'
            type: 'string'
          }
          {
            name: 'result_s'
            type: 'string'
          }
          {
            name: 'actionTriggered_s'
            type: 'string'
          }
          {
            name: 'date_t'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'route_s'
            type: 'string'
          }
          {
            name: 'messageId_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'fileHash_s'
            type: 'string'
          }
          {
            name: 'definition_s'
            type: 'string'
          }
          {
            name: 'mimecastEventId_s'
            type: 'string'
          }
          {
            name: 'mimecastEventCategory_s'
            type: 'string'
          }
          {
            name: 'time_generated'
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
          name: 'Sentinel-MimecastTTPAttachment_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MimecastTTPAttachment_CL']
        destinations: ['Sentinel-MimecastTTPAttachment_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), senderAddress_s = tostring(senderAddress_s), recipientAddress_s = tostring(recipientAddress_s), fileName_s = tostring(fileName_s), fileType_s = tostring(fileType_s), result_s = tostring(result_s), actionTriggered_s = tostring(actionTriggered_s), date_t = todatetime(date_t), details_s = tostring(details_s), route_s = tostring(route_s), messageId_s = tostring(messageId_s), subject_s = tostring(subject_s), fileHash_s = tostring(fileHash_s), definition_s = tostring(definition_s), mimecastEventId_s = tostring(mimecastEventId_s), mimecastEventCategory_s = tostring(mimecastEventCategory_s), time_generated = todatetime(time_generated)'
        outputStream: 'Custom-MimecastTTPAttachment_CL'
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
