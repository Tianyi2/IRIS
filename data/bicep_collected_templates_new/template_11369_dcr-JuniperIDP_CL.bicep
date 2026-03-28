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
// Data Collection Rule for JuniperIDP_CL
// ============================================================================
// Generated: 2025-09-19 14:20:23
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 41, DCR columns: 41 (Type column always filtered)
// Output stream: Custom-JuniperIDP_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-JuniperIDP_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-JuniperIDP_CL': {
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
            name: 'SrcNatIpAddr'
            type: 'string'
          }
          {
            name: 'SrcNatPortNumber'
            type: 'string'
          }
          {
            name: 'DstNatIpAddr'
            type: 'string'
          }
          {
            name: 'DstNatPortNumber'
            type: 'string'
          }
          {
            name: 'NetworkDuration'
            type: 'string'
          }
          {
            name: 'DstBytes'
            type: 'string'
          }
          {
            name: 'SrcBytes'
            type: 'string'
          }
          {
            name: 'ThreatName'
            type: 'string'
          }
          {
            name: 'DstPackets'
            type: 'string'
          }
          {
            name: 'SrcZone'
            type: 'string'
          }
          {
            name: 'SrcIntefaceName'
            type: 'string'
          }
          {
            name: 'DstZone'
            type: 'string'
          }
          {
            name: 'DstInterfaceName'
            type: 'string'
          }
          {
            name: 'PacketLogId'
            type: 'string'
          }
          {
            name: 'IsAlert'
            type: 'string'
          }
          {
            name: 'DstUserName'
            type: 'string'
          }
          {
            name: 'SrcPackets'
            type: 'string'
          }
          {
            name: 'EventSeverity'
            type: 'string'
          }
          {
            name: 'DvcAction'
            type: 'string'
          }
          {
            name: 'RepeatCount'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'DvcHostname'
            type: 'string'
          }
          {
            name: 'SrcDvcType'
            type: 'string'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'SrcDvcOs'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'MessageType'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'DstIpAddr'
            type: 'string'
          }
          {
            name: 'DstPortNumber'
            type: 'string'
          }
          {
            name: 'NetworkProtocol'
            type: 'string'
          }
          {
            name: 'ServiceName'
            type: 'string'
          }
          {
            name: 'NetworkApplicationProtocol'
            type: 'string'
          }
          {
            name: 'NetworkRuleNumber'
            type: 'string'
          }
          {
            name: 'NetworkRulebaseName'
            type: 'string'
          }
          {
            name: 'PolicyName'
            type: 'string'
          }
          {
            name: 'ExportId'
            type: 'string'
          }
          {
            name: 'Roles'
            type: 'string'
          }
          {
            name: 'EventMessage'
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
          name: 'Sentinel-JuniperIDP_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-JuniperIDP_CL']
        destinations: ['Sentinel-JuniperIDP_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), SrcNatIpAddr = tostring(SrcNatIpAddr), SrcNatPortNumber = tostring(SrcNatPortNumber), DstNatIpAddr = tostring(DstNatIpAddr), DstNatPortNumber = tostring(DstNatPortNumber), NetworkDuration = tostring(NetworkDuration), DstBytes = tostring(DstBytes), SrcBytes = tostring(SrcBytes), ThreatName = tostring(ThreatName), DstPackets = tostring(DstPackets), SrcZone = tostring(SrcZone), SrcIntefaceName = tostring(SrcIntefaceName), DstZone = tostring(DstZone), DstInterfaceName = tostring(DstInterfaceName), PacketLogId = tostring(PacketLogId), IsAlert = tostring(IsAlert), DstUserName = tostring(DstUserName), SrcPackets = tostring(SrcPackets), EventSeverity = tostring(EventSeverity), DvcAction = tostring(DvcAction), RepeatCount = tostring(RepeatCount), EventProduct = tostring(EventProduct), DvcHostname = tostring(DvcHostname), SrcDvcType = tostring(SrcDvcType), EventType = tostring(EventType), SrcDvcOs = tostring(SrcDvcOs), EventEndTime = tostring(EventEndTime), MessageType = tostring(MessageType), SrcIpAddr = tostring(SrcIpAddr), DstIpAddr = tostring(DstIpAddr), DstPortNumber = tostring(DstPortNumber), NetworkProtocol = tostring(NetworkProtocol), ServiceName = tostring(ServiceName), NetworkApplicationProtocol = tostring(NetworkApplicationProtocol), NetworkRuleNumber = tostring(NetworkRuleNumber), NetworkRulebaseName = tostring(NetworkRulebaseName), PolicyName = tostring(PolicyName), ExportId = tostring(ExportId), Roles = tostring(Roles), EventMessage = tostring(EventMessage)'
        outputStream: 'Custom-JuniperIDP_CL'
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
