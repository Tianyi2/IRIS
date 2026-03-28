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
// Data Collection Rule for DNS_Summarized_Logs_ip_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 7, DCR columns: 7 (Type column always filtered)
// Output stream: Custom-DNS_Summarized_Logs_ip_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DNS_Summarized_Logs_ip_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DNS_Summarized_Logs_ip_CL': {
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
            name: 'SrcIpAddr_s'
            type: 'string'
          }
          {
            name: 'DnsQuery_s'
            type: 'string'
          }
          {
            name: 'EventResultDetails_s'
            type: 'string'
          }
          {
            name: 'DnsResponseName_s'
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
          name: 'Sentinel-DNS_Summarized_Logs_ip_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DNS_Summarized_Logs_ip_CL']
        destinations: ['Sentinel-DNS_Summarized_Logs_ip_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventTime_t = todatetime(EventTime_t), SrcIpAddr_s = tostring(SrcIpAddr_s), DnsQuery_s = tostring(DnsQuery_s), EventResultDetails_s = tostring(EventResultDetails_s), DnsResponseName_s = tostring(DnsResponseName_s), count__d = toint(count__d)'
        outputStream: 'Custom-DNS_Summarized_Logs_ip_CL'
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
