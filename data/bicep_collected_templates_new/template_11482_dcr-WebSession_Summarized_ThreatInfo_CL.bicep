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
// Data Collection Rule for WebSession_Summarized_ThreatInfo_CL
// ============================================================================
// Generated: 2025-09-19 14:20:37
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 14, DCR columns: 14 (Type column always filtered)
// Output stream: Custom-WebSession_Summarized_ThreatInfo_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-WebSession_Summarized_ThreatInfo_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-WebSession_Summarized_ThreatInfo_CL': {
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
            name: 'DestDomain_s'
            type: 'string'
          }
          {
            name: 'DstIpAddr_s'
            type: 'string'
          }
          {
            name: 'EventCount_d'
            type: 'string'
          }
          {
            name: 'EventResult_s'
            type: 'string'
          }
          {
            name: 'EventSeverity_s'
            type: 'string'
          }
          {
            name: 'SrcUsername_s'
            type: 'string'
          }
          {
            name: 'ThreatCategory_s'
            type: 'string'
          }
          {
            name: 'ThreatField_s'
            type: 'string'
          }
          {
            name: 'ThreatName_s'
            type: 'string'
          }
          {
            name: 'ThreatOriginalConfidence_d'
            type: 'string'
          }
          {
            name: 'ThreatRiskLevel_d'
            type: 'string'
          }
          {
            name: 'SrcIpAddr_s'
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
          name: 'Sentinel-WebSession_Summarized_ThreatInfo_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-WebSession_Summarized_ThreatInfo_CL']
        destinations: ['Sentinel-WebSession_Summarized_ThreatInfo_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventTime_t = todatetime(EventTime_t), DestDomain_s = tostring(DestDomain_s), DstIpAddr_s = tostring(DstIpAddr_s), EventCount_d = tostring(EventCount_d), EventResult_s = tostring(EventResult_s), EventSeverity_s = tostring(EventSeverity_s), SrcUsername_s = tostring(SrcUsername_s), ThreatCategory_s = tostring(ThreatCategory_s), ThreatField_s = tostring(ThreatField_s), ThreatName_s = tostring(ThreatName_s), ThreatOriginalConfidence_d = toint(ThreatOriginalConfidence_d), ThreatRiskLevel_d = toint(ThreatRiskLevel_d), SrcIpAddr_s = tostring(SrcIpAddr_s)'
        outputStream: 'Custom-WebSession_Summarized_ThreatInfo_CL'
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
