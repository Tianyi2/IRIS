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
// Data Collection Rule for DigitalShadows_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 22, DCR columns: 22 (Type column always filtered)
// Output stream: Custom-DigitalShadows_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DigitalShadows_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DigitalShadows_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'app_s'
            type: 'string'
          }
          {
            name: 'triage_raised_time_t'
            type: 'string'
          }
          {
            name: 'triage_id_g'
            type: 'string'
          }
          {
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'risk_level_s'
            type: 'string'
          }
          {
            name: 'risk_factors_s'
            type: 'string'
          }
          {
            name: 'risk_assessment_risk_level_s'
            type: 'string'
          }
          {
            name: 'raised_t'
            type: 'string'
          }
          {
            name: 'triage_updated_time_t'
            type: 'string'
          }
          {
            name: 'portal_id_s'
            type: 'string'
          }
          {
            name: 'impact_description_s'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'comments_s'
            type: 'string'
          }
          {
            name: 'classification_s'
            type: 'string'
          }
          {
            name: 'assets_s'
            type: 'string'
          }
          {
            name: 'mitigation_s'
            type: 'string'
          }
          {
            name: 'updated_t'
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
          name: 'Sentinel-DigitalShadows_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DigitalShadows_CL']
        destinations: ['Sentinel-DigitalShadows_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), app_s = tostring(app_s), triage_raised_time_t = todatetime(triage_raised_time_t), triage_id_g = tostring(triage_id_g), title_s = todatetime(title_s), status_s = tostring(status_s), risk_level_s = tostring(risk_level_s), risk_factors_s = tostring(risk_factors_s), risk_assessment_risk_level_s = tostring(risk_assessment_risk_level_s), raised_t = todatetime(raised_t), triage_updated_time_t = todatetime(triage_updated_time_t), portal_id_s = tostring(portal_id_s), impact_description_s = tostring(impact_description_s), id_g = tostring(id_g), id_d = toreal(id_d), description_s = tostring(description_s), Computer = tostring(Computer), comments_s = tostring(comments_s), classification_s = tostring(classification_s), assets_s = tostring(assets_s), mitigation_s = tostring(mitigation_s), updated_t = todatetime(updated_t)'
        outputStream: 'Custom-DigitalShadows_CL'
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
