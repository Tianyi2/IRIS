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
// Data Collection Rule for TheomAlerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:35
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 23 (Type column always filtered)
// Output stream: Custom-TheomAlerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TheomAlerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TheomAlerts_CL': {
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
            name: 'customProps_TheomRemoteId_s'
            type: 'string'
          }
          {
            name: 'customProps_RulePriority_s'
            type: 'string'
          }
          {
            name: 'customProps_RuleId_s'
            type: 'string'
          }
          {
            name: 'customProps_RemediationIds_s'
            type: 'string'
          }
          {
            name: 'customProps_Region_s'
            type: 'string'
          }
          {
            name: 'customProps_NumTriggered_s'
            type: 'string'
          }
          {
            name: 'customProps_LastTriggered_s'
            type: 'string'
          }
          {
            name: 'customProps_AssetType_s'
            type: 'string'
          }
          {
            name: 'customProps_AssetName_s'
            type: 'string'
          }
          {
            name: 'customProps_AssetNERValue_s'
            type: 'string'
          }
          {
            name: 'customProps_AssetDeepLink_s'
            type: 'string'
          }
          {
            name: 'customProps_AssetCriticalityReason_s'
            type: 'string'
          }
          {
            name: 'customProps_AssetCriticality_s'
            type: 'string'
          }
          {
            name: 'accountId_s'
            type: 'string'
          }
          {
            name: 'priority_s'
            type: 'string'
          }
          {
            name: 'tags_s'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'summary_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'customProps_TheomRule_s'
            type: 'string'
          }
          {
            name: 'deepLink_s'
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
          name: 'Sentinel-TheomAlerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TheomAlerts_CL']
        destinations: ['Sentinel-TheomAlerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), id_s = tostring(id_s), customProps_TheomRemoteId_s = tostring(customProps_TheomRemoteId_s), customProps_RulePriority_s = tostring(customProps_RulePriority_s), customProps_RuleId_s = tostring(customProps_RuleId_s), customProps_RemediationIds_s = tostring(customProps_RemediationIds_s), customProps_Region_s = tostring(customProps_Region_s), customProps_NumTriggered_s = tostring(customProps_NumTriggered_s), customProps_LastTriggered_s = tostring(customProps_LastTriggered_s), customProps_AssetType_s = tostring(customProps_AssetType_s), customProps_AssetName_s = tostring(customProps_AssetName_s), customProps_AssetNERValue_s = tostring(customProps_AssetNERValue_s), customProps_AssetDeepLink_s = tostring(customProps_AssetDeepLink_s), customProps_AssetCriticalityReason_s = tostring(customProps_AssetCriticalityReason_s), customProps_AssetCriticality_s = tostring(customProps_AssetCriticality_s), accountId_s = tostring(accountId_s), priority_s = tostring(priority_s), tags_s = tostring(tags_s), details_s = tostring(details_s), summary_s = tostring(summary_s), type_s = tostring(type_s), customProps_TheomRule_s = tostring(customProps_TheomRule_s), deepLink_s = tostring(deepLink_s)'
        outputStream: 'Custom-TheomAlerts_CL'
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
