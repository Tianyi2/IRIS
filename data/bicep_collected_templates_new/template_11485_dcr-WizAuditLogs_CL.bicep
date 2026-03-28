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
// Data Collection Rule for WizAuditLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:37
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 6, DCR columns: 6 (Type column always filtered)
// Output stream: Custom-WizAuditLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-WizAuditLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-WizAuditLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'user_id_s'
            type: 'string'
          }
          {
            name: 'user_name_s'
            type: 'string'
          }
          {
            name: 'serviceAccount_name_s'
            type: 'string'
          }
          {
            name: 'serviceAccount_id_s'
            type: 'string'
          }
          {
            name: 'timestamp_t'
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
          name: 'Sentinel-WizAuditLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-WizAuditLogs_CL']
        destinations: ['Sentinel-WizAuditLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), user_id_s = tostring(user_id_s), user_name_s = tostring(user_name_s), serviceAccount_name_s = tostring(serviceAccount_name_s), serviceAccount_id_s = tostring(serviceAccount_id_s), timestamp_t = todatetime(timestamp_t)'
        outputStream: 'Custom-WizAuditLogs_CL'
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
