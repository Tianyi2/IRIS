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
// Data Collection Rule for MarkLogicAudit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:24
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 29 (Type column always filtered)
// Output stream: Custom-MarkLogicAudit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MarkLogicAudit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MarkLogicAudit_CL': {
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
            name: 'EventSubType'
            type: 'string'
          }
          {
            name: 'Roles'
            type: 'string'
          }
          {
            name: 'Function'
            type: 'string'
          }
          {
            name: 'Expr'
            type: 'string'
          }
          {
            name: 'Database'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'EventSeverity'
            type: 'string'
          }
          {
            name: 'EventOriginalResult'
            type: 'string'
          }
          {
            name: 'HttpUserAgentOriginal'
            type: 'string'
          }
          {
            name: 'HttpReferrerOriginal'
            type: 'string'
          }
          {
            name: 'HttpResponseBodyBytes'
            type: 'string'
          }
          {
            name: 'HttpStatusCode'
            type: 'string'
          }
          {
            name: 'HttpVersion'
            type: 'string'
          }
          {
            name: 'HttpRequestMethod'
            type: 'string'
          }
          {
            name: 'SrcUserName'
            type: 'string'
          }
          {
            name: 'ClientIdentity'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'EventResult'
            type: 'string'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'SourseSystem'
            type: 'string'
          }
          {
            name: 'TenanId'
            type: 'string'
          }
          {
            name: 'EventStartTime'
            type: 'string'
          }
          {
            name: 'EventCount'
            type: 'string'
          }
          {
            name: 'EventSchemaVersion'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'ActorUsername'
            type: 'string'
          }
          {
            name: 'UrlOriginal'
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
          name: 'Sentinel-MarkLogicAudit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MarkLogicAudit_CL']
        destinations: ['Sentinel-MarkLogicAudit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), EventSubType = tostring(EventSubType), Roles = tostring(Roles), Function = tostring(Function), Expr = tostring(Expr), Database = tostring(Database), Computer = tostring(Computer), EventSeverity = tostring(EventSeverity), EventOriginalResult = tostring(EventOriginalResult), HttpUserAgentOriginal = tostring(HttpUserAgentOriginal), HttpReferrerOriginal = tostring(HttpReferrerOriginal), HttpResponseBodyBytes = tostring(HttpResponseBodyBytes), HttpStatusCode = tostring(HttpStatusCode), HttpVersion = tostring(HttpVersion), HttpRequestMethod = tostring(HttpRequestMethod), SrcUserName = tostring(SrcUserName), ClientIdentity = tostring(ClientIdentity), SrcIpAddr = tostring(SrcIpAddr), EventResult = tostring(EventResult), EventType = tostring(EventType), SourseSystem = tostring(SourseSystem), TenanId = tostring(TenanId), EventStartTime = todatetime(EventStartTime), EventCount = tostring(EventCount), EventSchemaVersion = tostring(EventSchemaVersion), EventProduct = tostring(EventProduct), ActorUsername = tostring(ActorUsername), UrlOriginal = tostring(UrlOriginal)'
        outputStream: 'Custom-MarkLogicAudit_CL'
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
