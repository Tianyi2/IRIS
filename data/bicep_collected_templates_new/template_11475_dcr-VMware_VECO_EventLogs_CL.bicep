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
// Data Collection Rule for VMware_VECO_EventLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:37
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 7, DCR columns: 7 (Type column always filtered)
// Output stream: Custom-VMware_VECO_EventLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-VMware_VECO_EventLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-VMware_VECO_EventLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'category'
            type: 'string'
          }
          {
            name: 'detail'
            type: 'string'
          }
          {
            name: 'event'
            type: 'string'
          }
          {
            name: 'eventTime'
            type: 'string'
          }
          {
            name: 'message'
            type: 'string'
          }
          {
            name: 'severity'
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
          name: 'Sentinel-VMware_VECO_EventLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-VMware_VECO_EventLogs_CL']
        destinations: ['Sentinel-VMware_VECO_EventLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), category = tostring(category), detail = tostring(detail), event = tostring(event), eventTime = todatetime(eventTime), message = tostring(message), severity = tostring(severity)'
        outputStream: 'Custom-VMware_VECO_EventLogs_CL'
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
