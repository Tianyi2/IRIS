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
// Data Collection Rule for WebSession_Summarized_SrcInfo_CL
// ============================================================================
// Generated: 2025-09-19 14:20:37
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 15, DCR columns: 15 (Type column always filtered)
// Output stream: Custom-WebSession_Summarized_SrcInfo_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-WebSession_Summarized_SrcInfo_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-WebSession_Summarized_SrcInfo_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventTime_t'
            type: 'string'
          }
          {
            name: 'HttpUserAgent_s'
            type: 'string'
          }
          {
            name: 'EventResultDetails_s'
            type: 'string'
          }
          {
            name: 'EventResult_s'
            type: 'string'
          }
          {
            name: 'UrlCategory_s'
            type: 'string'
          }
          {
            name: 'NetworkApplicationProtocol_s'
            type: 'string'
          }
          {
            name: 'HttpRequestMethod_s'
            type: 'string'
          }
          {
            name: 'HttpContentType_s'
            type: 'string'
          }
          {
            name: 'EventProduct_s'
            type: 'string'
          }
          {
            name: 'EventVendor_s'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'SrcBytes_d'
            type: 'string'
          }
          {
            name: 'DstBytes_d'
            type: 'string'
          }
          {
            name: 'EventCount_d'
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
          name: 'Sentinel-WebSession_Summarized_SrcInfo_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-WebSession_Summarized_SrcInfo_CL']
        destinations: ['Sentinel-WebSession_Summarized_SrcInfo_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventTime_t = todatetime(EventTime_t), HttpUserAgent_s = tostring(HttpUserAgent_s), EventResultDetails_s = tostring(EventResultDetails_s), EventResult_s = tostring(EventResult_s), UrlCategory_s = tostring(UrlCategory_s), NetworkApplicationProtocol_s = tostring(NetworkApplicationProtocol_s), HttpRequestMethod_s = tostring(HttpRequestMethod_s), HttpContentType_s = tostring(HttpContentType_s), EventProduct_s = tostring(EventProduct_s), EventVendor_s = tostring(EventVendor_s), EventType_s = tostring(EventType_s), SrcBytes_d = toint(SrcBytes_d), DstBytes_d = toint(DstBytes_d), EventCount_d = toint(EventCount_d)'
        outputStream: 'Custom-WebSession_Summarized_SrcInfo_CL'
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
