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
// Data Collection Rule for CyberpionActionItems_CL
// ============================================================================
// Generated: 2025-09-19 14:20:15
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 17 (Type column always filtered)
// Output stream: Custom-CyberpionActionItems_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CyberpionActionItems_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CyberpionActionItems_CL': {
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
            name: 'host_s'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'urgency_d'
            type: 'string'
          }
          {
            name: 'is_open_b'
            type: 'string'
          }
          {
            name: 'impact_s'
            type: 'string'
          }
          {
            name: 'summary_s'
            type: 'string'
          }
          {
            name: 'solution_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'technical_details_s'
            type: 'string'
          }
          {
            name: 'opening_datetime_t'
            type: 'string'
          }
          {
            name: 'is_acknowledged_b'
            type: 'string'
          }
          {
            name: 'acknowledged_by_s'
            type: 'string'
          }
          {
            name: 'acknowledged_reason_s'
            type: 'string'
          }
          {
            name: 'acknowledged_date_t'
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
          name: 'Sentinel-CyberpionActionItems_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CyberpionActionItems_CL']
        destinations: ['Sentinel-CyberpionActionItems_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), id_s = tostring(id_s), host_s = tostring(host_s), Category = tostring(Category), title_s = tostring(title_s), urgency_d = toreal(urgency_d), is_open_b = tobool(is_open_b), impact_s = tostring(impact_s), summary_s = tostring(summary_s), solution_s = tostring(solution_s), description_s = tostring(description_s), technical_details_s = tostring(technical_details_s), opening_datetime_t = todatetime(opening_datetime_t), is_acknowledged_b = tobool(is_acknowledged_b), acknowledged_by_s = tostring(acknowledged_by_s), acknowledged_reason_s = tostring(acknowledged_reason_s), acknowledged_date_t = todatetime(acknowledged_date_t)'
        outputStream: 'Custom-CyberpionActionItems_CL'
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
