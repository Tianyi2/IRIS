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
// Data Collection Rule for MimecastTTPImpersonation_CL
// ============================================================================
// Generated: 2025-09-19 14:20:25
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-MimecastTTPImpersonation_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MimecastTTPImpersonation_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MimecastTTPImpersonation_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'mimecastEventId_s'
            type: 'string'
          }
          {
            name: 'messageId_s'
            type: 'string'
          }
          {
            name: 'impersonationResults_s'
            type: 'string'
          }
          {
            name: 'eventTime_t'
            type: 'string'
          }
          {
            name: 'senderIpAddress_s'
            type: 'string'
          }
          {
            name: 'taggedMalicious_b'
            type: 'string'
          }
          {
            name: 'mimecastEventCategory_s'
            type: 'string'
          }
          {
            name: 'taggedExternal_b'
            type: 'string'
          }
          {
            name: 'identifiers_s'
            type: 'string'
          }
          {
            name: 'hits_s'
            type: 'string'
          }
          {
            name: 'definition_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'recipientAddress_s'
            type: 'string'
          }
          {
            name: 'senderAddress_s'
            type: 'string'
          }
          {
            name: 'action_s'
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
          name: 'Sentinel-MimecastTTPImpersonation_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MimecastTTPImpersonation_CL']
        destinations: ['Sentinel-MimecastTTPImpersonation_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), id_s = tostring(id_s), mimecastEventId_s = tostring(mimecastEventId_s), messageId_s = tostring(messageId_s), impersonationResults_s = tostring(impersonationResults_s), eventTime_t = todatetime(eventTime_t), senderIpAddress_s = tostring(senderIpAddress_s), taggedMalicious_b = tobool(taggedMalicious_b), mimecastEventCategory_s = tostring(mimecastEventCategory_s), taggedExternal_b = tobool(taggedExternal_b), identifiers_s = tostring(identifiers_s), hits_s = tostring(hits_s), definition_s = tostring(definition_s), subject_s = tostring(subject_s), recipientAddress_s = tostring(recipientAddress_s), senderAddress_s = tostring(senderAddress_s), action_s = tostring(action_s), time_generated = todatetime(time_generated)'
        outputStream: 'Custom-MimecastTTPImpersonation_CL'
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
