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
// Data Collection Rule for BitwardenEventLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:19:57
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 11, DCR columns: 11 (Type column always filtered)
// Output stream: Custom-BitwardenEventLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitwardenEventLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitwardenEventLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'eventType'
            type: 'string'
          }
          {
            name: 'itemId'
            type: 'string'
          }
          {
            name: 'collectionId'
            type: 'string'
          }
          {
            name: 'groupId'
            type: 'string'
          }
          {
            name: 'policyId'
            type: 'string'
          }
          {
            name: 'memberId'
            type: 'string'
          }
          {
            name: 'actingUserId'
            type: 'string'
          }
          {
            name: 'installationId'
            type: 'string'
          }
          {
            name: 'device'
            type: 'string'
          }
          {
            name: 'ipAddress'
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
          name: 'Sentinel-BitwardenEventLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitwardenEventLogs_CL']
        destinations: ['Sentinel-BitwardenEventLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), eventType = toint(eventType), itemId = tostring(itemId), collectionId = tostring(collectionId), groupId = tostring(groupId), policyId = tostring(policyId), memberId = tostring(memberId), actingUserId = tostring(actingUserId), installationId = tostring(installationId), device = toint(device), ipAddress = tostring(ipAddress)'
        outputStream: 'Custom-BitwardenEventLogs_CL'
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
