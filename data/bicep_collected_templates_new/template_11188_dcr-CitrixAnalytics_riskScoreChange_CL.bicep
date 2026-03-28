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
// Data Collection Rule for CitrixAnalytics_riskScoreChange_CL
// ============================================================================
// Generated: 2025-09-19 14:20:00
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 10, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-CitrixAnalytics_riskScoreChange_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CitrixAnalytics_riskScoreChange_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CitrixAnalytics_riskScoreChange_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'cur_riskscore_d'
            type: 'string'
          }
          {
            name: 'entity_id_s'
            type: 'string'
          }
          {
            name: 'entity_type_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'tenant_id_s'
            type: 'string'
          }
          {
            name: 'version_d'
            type: 'string'
          }
          {
            name: 'alert_type_s'
            type: 'string'
          }
          {
            name: 'alert_value_s'
            type: 'string'
          }
          {
            name: 'alert_message_s'
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
          name: 'Sentinel-CitrixAnalytics_riskScoreChange_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CitrixAnalytics_riskScoreChange_CL']
        destinations: ['Sentinel-CitrixAnalytics_riskScoreChange_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), cur_riskscore_d = toreal(cur_riskscore_d), entity_id_s = tostring(entity_id_s), entity_type_s = tostring(entity_type_s), event_type_s = tostring(event_type_s), tenant_id_s = tostring(tenant_id_s), version_d = toreal(version_d), alert_type_s = tostring(alert_type_s), alert_value_s = tostring(alert_value_s), alert_message_s = tostring(alert_message_s)'
        outputStream: 'Custom-CitrixAnalytics_riskScoreChange_CL'
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
