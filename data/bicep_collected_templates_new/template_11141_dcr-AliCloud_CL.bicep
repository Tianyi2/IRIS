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
// Data Collection Rule for AliCloud_CL
// ============================================================================
// Generated: 2025-09-19 14:19:51
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 28, DCR columns: 27 (Type column always filtered)
// Output stream: Custom-AliCloud_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-AliCloud_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-AliCloud_CL': {
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
            name: 'apiVersion'
            type: 'string'
          }
          {
            name: 'UserIdentity'
            type: 'string'
          }
          {
            name: 'UserAgent'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'ServiceName'
            type: 'string'
          }
          {
            name: 'RequestParameters'
            type: 'string'
          }
          {
            name: 'RequestParameterJson'
            type: 'string'
          }
          {
            name: 'RequestId'
            type: 'string'
          }
          {
            name: 'EventVersion'
            type: 'string'
          }
          {
            name: 'EventSource'
            type: 'string'
          }
          {
            name: 'EventRW'
            type: 'string'
          }
          {
            name: 'AdditionalEventData'
            type: 'string'
          }
          {
            name: 'EventOriginalType'
            type: 'string'
          }
          {
            name: 'EventOriginalUid'
            type: 'string'
          }
          {
            name: 'EventResult'
            type: 'string'
          }
          {
            name: 'EventSubType'
            type: 'string'
          }
          {
            name: 'AcsRegion'
            type: 'string'
          }
          {
            name: 'SourceName'
            type: 'string'
          }
          {
            name: 'ContentTopic'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'CreatedAt'
            type: 'string'
          }
          {
            name: 'EventCount'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'TenanId'
            type: 'string'
          }
          {
            name: 'SourseSystem'
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
          name: 'Sentinel-AliCloud_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-AliCloud_CL']
        destinations: ['Sentinel-AliCloud_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), apiVersion = todatetime(apiVersion), UserIdentity = tostring(UserIdentity), UserAgent = tostring(UserAgent), SrcIpAddr = tostring(SrcIpAddr), ServiceName = tostring(ServiceName), RequestParameters = tostring(RequestParameters), RequestParameterJson = tostring(RequestParameterJson), RequestId = tostring(RequestId), EventVersion = tostring(EventVersion), EventSource = tostring(EventSource), EventRW = tostring(EventRW), AdditionalEventData = tostring(AdditionalEventData), EventOriginalType = tostring(EventOriginalType), EventOriginalUid = tostring(EventOriginalUid), EventResult = tostring(EventResult), EventSubType = tostring(EventSubType), AcsRegion = tostring(AcsRegion), SourceName = tostring(SourceName), ContentTopic = tostring(ContentTopic), EventEndTime = todatetime(EventEndTime), CreatedAt = todatetime(CreatedAt), EventCount = tostring(EventCount), EventProduct = tostring(EventProduct), TenanId = tostring(TenanId), SourseSystem = tostring(SourseSystem)'
        outputStream: 'Custom-AliCloud_CL'
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
