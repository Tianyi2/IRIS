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
// Data Collection Rule for ProofPointTAPClicksBlocked_CL
// ============================================================================
// Generated: 2025-09-19 14:20:29
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 24, DCR columns: 22 (Type column always filtered)
// Output stream: Custom-ProofPointTAPClicksBlocked_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ProofPointTAPClicksBlocked_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ProofPointTAPClicksBlocked_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'threatID_s'
            type: 'string'
          }
          {
            name: 'campaignId_s'
            type: 'string'
          }
          {
            name: 'userAgent_s'
            type: 'string'
          }
          {
            name: 'threatTime_t'
            type: 'string'
          }
          {
            name: 'classification_s'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'GUID_s'
            type: 'string'
          }
          {
            name: 'clickIP_s'
            type: 'string'
          }
          {
            name: 'threatURL_s'
            type: 'string'
          }
          {
            name: 'messageID_s'
            type: 'string'
          }
          {
            name: 'recipient_s'
            type: 'string'
          }
          {
            name: 'sender_s'
            type: 'string'
          }
          {
            name: 'clickTime_t'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'senderIP_s'
            type: 'string'
          }
          {
            name: 'threatStatus_s'
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
          name: 'Sentinel-ProofPointTAPClicksBlocked_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ProofPointTAPClicksBlocked_CL']
        destinations: ['Sentinel-ProofPointTAPClicksBlocked_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), threatID_s = tostring(threatID_s), campaignId_s = tostring(campaignId_s), userAgent_s = tostring(userAgent_s), threatTime_t = todatetime(threatTime_t), classification_s = tostring(classification_s), url_s = tostring(url_s), GUID_s = tostring(GUID_s), clickIP_s = toreal(clickIP_s), threatURL_s = tostring(threatURL_s), messageID_s = tostring(messageID_s), recipient_s = tostring(recipient_s), sender_s = tostring(sender_s), clickTime_t = todatetime(clickTime_t), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), senderIP_s = tostring(senderIP_s), threatStatus_s = tostring(threatStatus_s)'
        outputStream: 'Custom-ProofPointTAPClicksBlocked_CL'
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
