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
// Data Collection Rule for Cisco_Umbrella_dns_CL
// ============================================================================
// Generated: 2025-09-19 14:19:59
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 15, DCR columns: 15 (Type column always filtered)
// Output stream: Custom-Cisco_Umbrella_dns_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Cisco_Umbrella_dns_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Cisco_Umbrella_dns_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Timestamp_t'
            type: 'string'
          }
          {
            name: 'InternalIp_s'
            type: 'string'
          }
          {
            name: 'ExternalIp_s'
            type: 'string'
          }
          {
            name: 'Action_s'
            type: 'string'
          }
          {
            name: 'Domain_s'
            type: 'string'
          }
          {
            name: 'Categories_s'
            type: 'string'
          }
          {
            name: 'Blocked_Categories_s'
            type: 'string'
          }
          {
            name: 'Identities_s'
            type: 'string'
          }
          {
            name: 'QueryType_s'
            type: 'string'
          }
          {
            name: 'ResponseCode_s'
            type: 'string'
          }
          {
            name: 'Identity_Types_s'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'Policy_Identity_s'
            type: 'string'
          }
          {
            name: 'Policy_Identity_Type_s'
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
          name: 'Sentinel-Cisco_Umbrella_dns_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Cisco_Umbrella_dns_CL']
        destinations: ['Sentinel-Cisco_Umbrella_dns_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Timestamp_t = todatetime(Timestamp_t), InternalIp_s = tostring(InternalIp_s), ExternalIp_s = tostring(ExternalIp_s), Action_s = tostring(Action_s), Domain_s = tostring(Domain_s), Categories_s = tostring(Categories_s), Blocked_Categories_s = tostring(Blocked_Categories_s), Identities_s = tostring(Identities_s), QueryType_s = tostring(QueryType_s), ResponseCode_s = tostring(ResponseCode_s), Identity_Types_s = tostring(Identity_Types_s), EventType_s = tostring(EventType_s), Policy_Identity_s = tostring(Policy_Identity_s), Policy_Identity_Type_s = tostring(Policy_Identity_Type_s)'
        outputStream: 'Custom-Cisco_Umbrella_dns_CL'
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
