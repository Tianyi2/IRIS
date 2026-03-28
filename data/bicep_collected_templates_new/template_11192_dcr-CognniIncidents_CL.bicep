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
// Data Collection Rule for CognniIncidents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:01
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 22, DCR columns: 19 (Type column always filtered)
// Output stream: Custom-CognniIncidents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CognniIncidents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CognniIncidents_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'attachmentId_s'
            type: 'string'
          }
          {
            name: 'siteId_g'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'orgId_g'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'messageId_s'
            type: 'string'
          }
          {
            name: 'listItemUniqueId_g'
            type: 'string'
          }
          {
            name: 'listId_g'
            type: 'string'
          }
          {
            name: 'labels_s'
            type: 'string'
          }
          {
            name: 'internalEventId_g'
            type: 'string'
          }
          {
            name: 'insights_s'
            type: 'string'
          }
          {
            name: 'informationType_s'
            type: 'string'
          }
          {
            name: 'fileName_s'
            type: 'string'
          }
          {
            name: 'eventTime_t'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'sourceFileExtension_s'
            type: 'string'
          }
          {
            name: 'userId_s'
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
          name: 'Sentinel-CognniIncidents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CognniIncidents_CL']
        destinations: ['Sentinel-CognniIncidents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), attachmentId_s = tostring(attachmentId_s), siteId_g = tostring(siteId_g), Severity = toint(Severity), RawData = tostring(RawData), orgId_g = tostring(orgId_g), name_s = tostring(name_s), messageId_s = tostring(messageId_s), listItemUniqueId_g = tostring(listItemUniqueId_g), listId_g = tostring(listId_g), labels_s = tostring(labels_s), internalEventId_g = tostring(internalEventId_g), insights_s = tostring(insights_s), informationType_s = tostring(informationType_s), fileName_s = tostring(fileName_s), eventTime_t = todatetime(eventTime_t), Computer = tostring(Computer), sourceFileExtension_s = tostring(sourceFileExtension_s), userId_s = tostring(userId_s)'
        outputStream: 'Custom-CognniIncidents_CL'
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
