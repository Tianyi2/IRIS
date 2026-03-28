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
// Data Collection Rule for Authomize_v2_CL
// ============================================================================
// Generated: 2025-09-19 14:19:54
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 30 (Type column always filtered)
// Output stream: Custom-Authomize_v2_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Authomize_v2_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Authomize_v2_CL': {
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
            name: 'updatedAt_t'
            type: 'string'
          }
          {
            name: 'techniques_s'
            type: 'string'
          }
          {
            name: 'tactics_s'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'slot_ID_d'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'recommendation_s'
            type: 'string'
          }
          {
            name: 'policyId_s'
            type: 'string'
          }
          {
            name: 'policy_templateId_s'
            type: 'string'
          }
          {
            name: 'policy_name_s'
            type: 'string'
          }
          {
            name: 'policy_id_s'
            type: 'string'
          }
          {
            name: 'performance_Value_d'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'measurement_Name_s'
            type: 'string'
          }
          {
            name: 'IsActive_s'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'ID_g'
            type: 'string'
          }
          {
            name: 'entities_s'
            type: 'string'
          }
          {
            name: 'duration_d'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'critical_Threshold_d'
            type: 'string'
          }
          {
            name: 'createdAt_t'
            type: 'string'
          }
          {
            name: 'compliance_s'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'availability_Value_d'
            type: 'string'
          }
          {
            name: 'assigneeId_s'
            type: 'string'
          }
          {
            name: 'isResolved_b'
            type: 'string'
          }
          {
            name: 'warning_Threshold_d'
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
          name: 'Sentinel-Authomize_v2_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Authomize_v2_CL']
        destinations: ['Sentinel-Authomize_v2_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), app_s = tostring(app_s), updatedAt_t = todatetime(updatedAt_t), techniques_s = tostring(techniques_s), tactics_s = tostring(tactics_s), status_s = tostring(status_s), slot_ID_d = toreal(slot_ID_d), severity_s = tostring(severity_s), recommendation_s = tostring(recommendation_s), policyId_s = tostring(policyId_s), policy_templateId_s = tostring(policy_templateId_s), policy_name_s = tostring(policy_name_s), policy_id_s = tostring(policy_id_s), performance_Value_d = toreal(performance_Value_d), url_s = tostring(url_s), measurement_Name_s = tostring(measurement_Name_s), IsActive_s = tostring(IsActive_s), id_s = tostring(id_s), ID_g = toguid(ID_g), entities_s = tostring(entities_s), duration_d = toreal(duration_d), description_s = tostring(description_s), critical_Threshold_d = toreal(critical_Threshold_d), createdAt_t = todatetime(createdAt_t), compliance_s = tostring(compliance_s), Category = tostring(Category), availability_Value_d = toreal(availability_Value_d), assigneeId_s = tostring(assigneeId_s), isResolved_b = tobool(isResolved_b), warning_Threshold_d = toreal(warning_Threshold_d)'
        outputStream: 'Custom-Authomize_v2_CL'
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
