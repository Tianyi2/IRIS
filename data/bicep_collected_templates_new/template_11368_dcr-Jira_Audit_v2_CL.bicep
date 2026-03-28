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
// Data Collection Rule for Jira_Audit_v2_CL
// ============================================================================
// Generated: 2025-09-19 14:20:23
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 19, DCR columns: 19 (Type column always filtered)
// Output stream: Custom-Jira_Audit_v2_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Jira_Audit_v2_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Jira_Audit_v2_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'AssociatedItems'
            type: 'dynamic'
          }
          {
            name: 'ObjectItemTypeName'
            type: 'string'
          }
          {
            name: 'ObjectItemName'
            type: 'string'
          }
          {
            name: 'ObjectItemId'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'EventMessage'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'objectItem'
            type: 'dynamic'
          }
          {
            name: 'EventId'
            type: 'string'
          }
          {
            name: 'EventSource'
            type: 'string'
          }
          {
            name: 'EventCreationTime'
            type: 'string'
          }
          {
            name: 'ChangedValues'
            type: 'dynamic'
          }
          {
            name: 'EventCategoryType'
            type: 'string'
          }
          {
            name: 'UserName'
            type: 'string'
          }
          {
            name: 'UserSid'
            type: 'string'
          }
          {
            name: 'ObjectItemParentId'
            type: 'string'
          }
          {
            name: 'ObjectItemParentName'
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
          name: 'Sentinel-Jira_Audit_v2_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Jira_Audit_v2_CL']
        destinations: ['Sentinel-Jira_Audit_v2_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), AssociatedItems = todynamic(AssociatedItems), ObjectItemTypeName = tostring(ObjectItemTypeName), ObjectItemName = tostring(ObjectItemName), ObjectItemId = tostring(ObjectItemId), EventProduct = tostring(EventProduct), EventVendor = tostring(EventVendor), EventMessage = tostring(EventMessage), SrcIpAddr = tostring(SrcIpAddr), objectItem = todynamic(objectItem), EventId = toint(EventId), EventSource = tostring(EventSource), EventCreationTime = todatetime(EventCreationTime), ChangedValues = todynamic(ChangedValues), EventCategoryType = tostring(EventCategoryType), UserName = tostring(UserName), UserSid = tostring(UserSid), ObjectItemParentId = tostring(ObjectItemParentId), ObjectItemParentName = tostring(ObjectItemParentName)'
        outputStream: 'Custom-Jira_Audit_v2_CL'
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
