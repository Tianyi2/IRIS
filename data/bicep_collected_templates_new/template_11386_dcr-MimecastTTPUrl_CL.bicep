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
// Data Collection Rule for MimecastTTPUrl_CL
// ============================================================================
// Generated: 2025-09-19 14:20:25
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 25, DCR columns: 25 (Type column always filtered)
// Output stream: Custom-MimecastTTPUrl_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MimecastTTPUrl_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MimecastTTPUrl_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'userEmailAddress_s'
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
            name: 'emailPartsDescription_s'
            type: 'string'
          }
          {
            name: 'creationMethod_s'
            type: 'string'
          }
          {
            name: 'route_s'
            type: 'string'
          }
          {
            name: 'actions_s'
            type: 'string'
          }
          {
            name: 'date_t'
            type: 'string'
          }
          {
            name: 'userAwarenessAction_s'
            type: 'string'
          }
          {
            name: 'advancedPhishingResult_CredentialTheftEvidence_s'
            type: 'string'
          }
          {
            name: 'advancedPhishingResult_CredentialTheftTags_s'
            type: 'string'
          }
          {
            name: 'advancedPhishingResult_CredentialTheftBrands_s'
            type: 'string'
          }
          {
            name: 'sendingIp_s'
            type: 'string'
          }
          {
            name: 'category_s'
            type: 'string'
          }
          {
            name: 'scanResult_s'
            type: 'string'
          }
          {
            name: 'userOverride_s'
            type: 'string'
          }
          {
            name: 'adminOverride_s'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'ttpDefinition_s'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'fromUserEmailAddress_s'
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
          name: 'Sentinel-MimecastTTPUrl_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MimecastTTPUrl_CL']
        destinations: ['Sentinel-MimecastTTPUrl_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), userEmailAddress_s = tostring(userEmailAddress_s), mimecastEventId_s = tostring(mimecastEventId_s), messageId_s = tostring(messageId_s), emailPartsDescription_s = tostring(emailPartsDescription_s), creationMethod_s = tostring(creationMethod_s), route_s = tostring(route_s), actions_s = tostring(actions_s), date_t = todatetime(date_t), userAwarenessAction_s = tostring(userAwarenessAction_s), advancedPhishingResult_CredentialTheftEvidence_s = tostring(advancedPhishingResult_CredentialTheftEvidence_s), advancedPhishingResult_CredentialTheftTags_s = tostring(advancedPhishingResult_CredentialTheftTags_s), advancedPhishingResult_CredentialTheftBrands_s = tostring(advancedPhishingResult_CredentialTheftBrands_s), sendingIp_s = tostring(sendingIp_s), category_s = tostring(category_s), scanResult_s = tostring(scanResult_s), userOverride_s = tostring(userOverride_s), adminOverride_s = tostring(adminOverride_s), action_s = tostring(action_s), subject_s = tostring(subject_s), ttpDefinition_s = tostring(ttpDefinition_s), url_s = tostring(url_s), fromUserEmailAddress_s = tostring(fromUserEmailAddress_s), mimecastEventCategory_s = tostring(mimecastEventCategory_s), time_generated = todatetime(time_generated)'
        outputStream: 'Custom-MimecastTTPUrl_CL'
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
