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
// Data Collection Rule for Cisco_Umbrella_cloudfirewall_CL
// ============================================================================
// Generated: 2025-09-19 14:19:58
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 16, DCR columns: 16 (Type column always filtered)
// Output stream: Custom-Cisco_Umbrella_cloudfirewall_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Cisco_Umbrella_cloudfirewall_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Cisco_Umbrella_cloudfirewall_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'Timestamp_t'
            type: 'string'
          }
          {
            name: 'originId_s'
            type: 'string'
          }
          {
            name: 'Identity_s'
            type: 'string'
          }
          {
            name: 'Identity_Type_s'
            type: 'string'
          }
          {
            name: 'Direction_s'
            type: 'string'
          }
          {
            name: 'ipProtocol_s'
            type: 'string'
          }
          {
            name: 'packetSize_s'
            type: 'string'
          }
          {
            name: 'SourceIP'
            type: 'string'
          }
          {
            name: 'sourcePort_s'
            type: 'string'
          }
          {
            name: 'destinationIp_s'
            type: 'string'
          }
          {
            name: 'destinationPort_s'
            type: 'string'
          }
          {
            name: 'dataCenter_s'
            type: 'string'
          }
          {
            name: 'ruleId_s'
            type: 'string'
          }
          {
            name: 'verdict_s'
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
          name: 'Sentinel-Cisco_Umbrella_cloudfirewall_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Cisco_Umbrella_cloudfirewall_CL']
        destinations: ['Sentinel-Cisco_Umbrella_cloudfirewall_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventType_s = tostring(EventType_s), Timestamp_t = todatetime(Timestamp_t), originId_s = tostring(originId_s), Identity_s = tostring(Identity_s), Identity_Type_s = tostring(Identity_Type_s), Direction_s = tostring(Direction_s), ipProtocol_s = tostring(ipProtocol_s), packetSize_s = tostring(packetSize_s), SourceIP = tostring(SourceIP), sourcePort_s = tostring(sourcePort_s), destinationIp_s = tostring(destinationIp_s), destinationPort_s = tostring(destinationPort_s), dataCenter_s = tostring(dataCenter_s), ruleId_s = tostring(ruleId_s), verdict_s = tostring(verdict_s)'
        outputStream: 'Custom-Cisco_Umbrella_cloudfirewall_CL'
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
