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
// Data Collection Rule for DNS_Summarized_Logs_sourceInfo_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 8, DCR columns: 8 (Type column always filtered)
// Output stream: Custom-DNS_Summarized_Logs_sourceInfo_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DNS_Summarized_Logs_sourceInfo_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DNS_Summarized_Logs_sourceInfo_CL': {
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
            name: 'EventProduct_s'
            type: 'string'
          }
          {
            name: 'DvcHostname_s'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'EventSubType_s'
            type: 'string'
          }
          {
            name: 'DnsQueryTypeName_s'
            type: 'string'
          }
          {
            name: 'count__d'
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
          name: 'Sentinel-DNS_Summarized_Logs_sourceInfo_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DNS_Summarized_Logs_sourceInfo_CL']
        destinations: ['Sentinel-DNS_Summarized_Logs_sourceInfo_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventTime_t = todatetime(EventTime_t), EventProduct_s = tostring(EventProduct_s), DvcHostname_s = tostring(DvcHostname_s), EventType_s = tostring(EventType_s), EventSubType_s = tostring(EventSubType_s), DnsQueryTypeName_s = tostring(DnsQueryTypeName_s), count__d = toint(count__d)'
        outputStream: 'Custom-DNS_Summarized_Logs_sourceInfo_CL'
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
