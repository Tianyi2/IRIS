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
// Data Collection Rule for Entity_Scoring_Data_CL
// ============================================================================
// Generated: 2025-09-19 14:20:17
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 29, DCR columns: 27 (Type column always filtered)
// Output stream: Custom-Entity_Scoring_Data_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Entity_Scoring_Data_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Entity_Scoring_Data_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'last_detection_type_s'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'active_detection_types_s'
            type: 'string'
          }
          {
            name: 'attack_rating_d'
            type: 'string'
          }
          {
            name: 'velocity_contrib_d'
            type: 'string'
          }
          {
            name: 'urgency_score_d'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'last_detection_url_s'
            type: 'string'
          }
          {
            name: 'is_prioritized_b'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'entity_type_s'
            type: 'string'
          }
          {
            name: 'importance_d'
            type: 'string'
          }
          {
            name: 'entity_importance_d'
            type: 'string'
          }
          {
            name: 'breadth_contrib_d'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'entity_id_d'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'last_detection_id_d'
            type: 'string'
          }
          {
            name: 'event_timestamp_t'
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
          name: 'Sentinel-Entity_Scoring_Data_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Entity_Scoring_Data_CL']
        destinations: ['Sentinel-Entity_Scoring_Data_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), url_s = tostring(url_s), last_detection_type_s = tostring(last_detection_type_s), Category = tostring(Category), active_detection_types_s = tostring(active_detection_types_s), attack_rating_d = toreal(attack_rating_d), velocity_contrib_d = toreal(velocity_contrib_d), urgency_score_d = toreal(urgency_score_d), severity_s = tostring(severity_s), last_detection_url_s = tostring(last_detection_url_s), is_prioritized_b = tobool(is_prioritized_b), type_s = tostring(type_s), entity_type_s = tostring(entity_type_s), importance_d = toreal(importance_d), entity_importance_d = toreal(entity_importance_d), breadth_contrib_d = toreal(breadth_contrib_d), name_s = tostring(name_s), entity_id_d = toreal(entity_id_d), id_d = toreal(id_d), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), last_detection_id_d = toreal(last_detection_id_d), event_timestamp_t = todatetime(event_timestamp_t)'
        outputStream: 'Custom-Entity_Scoring_Data_CL'
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
