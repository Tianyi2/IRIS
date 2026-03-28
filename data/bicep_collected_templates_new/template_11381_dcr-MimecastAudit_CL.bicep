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
// Data Collection Rule for MimecastAudit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:24
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 13, DCR columns: 13 (Type column always filtered)
// Output stream: Custom-MimecastAudit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MimecastAudit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MimecastAudit_CL': {
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
            name: 'auditType_s'
            type: 'string'
          }
          {
            name: 'user_s'
            type: 'string'
          }
          {
            name: 'eventTime_d'
            type: 'string'
          }
          {
            name: 'eventInfo_s'
            type: 'string'
          }
          {
            name: 'category_s'
            type: 'string'
          }
          {
            name: 'mimecastEventId_s'
            type: 'string'
          }
          {
            name: 'mimecastEventCategory_s'
            type: 'string'
          }
          {
            name: 'time_generated'
            type: 'string'
          }
          {
            name: 'app_s'
            type: 'string'
          }
          {
            name: 'src_s'
            type: 'string'
          }
          {
            name: 'method_s'
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
          name: 'Sentinel-MimecastAudit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MimecastAudit_CL']
        destinations: ['Sentinel-MimecastAudit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), id_s = tostring(id_s), auditType_s = tostring(auditType_s), user_s = tostring(user_s), eventTime_d = todatetime(eventTime_d), eventInfo_s = tostring(eventInfo_s), category_s = tostring(category_s), mimecastEventId_s = tostring(mimecastEventId_s), mimecastEventCategory_s = tostring(mimecastEventCategory_s), time_generated = todatetime(time_generated), app_s = tostring(app_s), src_s = tostring(src_s), method_s = tostring(method_s)'
        outputStream: 'Custom-MimecastAudit_CL'
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
