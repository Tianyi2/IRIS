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
// Data Collection Rule for Jira_Audit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:23
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-Jira_Audit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Jira_Audit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Jira_Audit_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'objectItem_parentId_s'
            type: 'string'
          }
          {
            name: 'associatedItems_s'
            type: 'string'
          }
          {
            name: 'changedValues_s'
            type: 'string'
          }
          {
            name: 'objectItem_typeName_s'
            type: 'string'
          }
          {
            name: 'objectItem_name_s'
            type: 'string'
          }
          {
            name: 'objectItem_id_s'
            type: 'string'
          }
          {
            name: 'objectItem_parentName_s'
            type: 'string'
          }
          {
            name: 'eventSource_s'
            type: 'string'
          }
          {
            name: 'authorAccountId_s'
            type: 'string'
          }
          {
            name: 'authorKey_s'
            type: 'string'
          }
          {
            name: 'remoteAddress_s'
            type: 'string'
          }
          {
            name: 'summary_s'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'created_t'
            type: 'string'
          }
          {
            name: 'Category'
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
          name: 'Sentinel-Jira_Audit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Jira_Audit_CL']
        destinations: ['Sentinel-Jira_Audit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), objectItem_parentId_s = tostring(objectItem_parentId_s), associatedItems_s = tostring(associatedItems_s), changedValues_s = tostring(changedValues_s), objectItem_typeName_s = tostring(objectItem_typeName_s), objectItem_name_s = tostring(objectItem_name_s), objectItem_id_s = tostring(objectItem_id_s), objectItem_parentName_s = tostring(objectItem_parentName_s), eventSource_s = tostring(eventSource_s), authorAccountId_s = tostring(authorAccountId_s), authorKey_s = tostring(authorKey_s), remoteAddress_s = tostring(remoteAddress_s), summary_s = tostring(summary_s), id_d = toreal(id_d), EventProduct = tostring(EventProduct), created_t = todatetime(created_t), Category = tostring(Category)'
        outputStream: 'Custom-Jira_Audit_CL'
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
