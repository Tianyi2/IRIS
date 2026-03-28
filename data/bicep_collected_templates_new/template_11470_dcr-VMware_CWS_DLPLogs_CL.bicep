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
// Data Collection Rule for VMware_CWS_DLPLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:36
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 20, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-VMware_CWS_DLPLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-VMware_CWS_DLPLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-VMware_CWS_DLPLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'action'
            type: 'string'
          }
          {
            name: 'streamName'
            type: 'string'
          }
          {
            name: 'status'
            type: 'string'
          }
          {
            name: 'srcUrl'
            type: 'string'
          }
          {
            name: 'sha256'
            type: 'string'
          }
          {
            name: 'ruleName'
            type: 'string'
          }
          {
            name: 'ruleId'
            type: 'string'
          }
          {
            name: 'requestType'
            type: 'string'
          }
          {
            name: 'userId'
            type: 'string'
          }
          {
            name: 'protocol'
            type: 'string'
          }
          {
            name: 'filename'
            type: 'string'
          }
          {
            name: 'eventTime'
            type: 'string'
          }
          {
            name: 'eventId'
            type: 'string'
          }
          {
            name: 'dstUrl'
            type: 'string'
          }
          {
            name: 'domain'
            type: 'string'
          }
          {
            name: 'ccl'
            type: 'dynamic'
          }
          {
            name: 'alerted'
            type: 'string'
          }
          {
            name: 'fileType'
            type: 'string'
          }
          {
            name: 'userInput'
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
          name: 'Sentinel-VMware_CWS_DLPLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-VMware_CWS_DLPLogs_CL']
        destinations: ['Sentinel-VMware_CWS_DLPLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), action = tostring(action), streamName = tostring(streamName), status = tostring(status), srcUrl = tostring(srcUrl), sha256 = tostring(sha256), ruleName = tostring(ruleName), ruleId = tostring(ruleId), requestType = tostring(requestType), userId = tostring(userId), protocol = tostring(protocol), filename = tostring(filename), eventTime = todatetime(eventTime), eventId = tostring(eventId), dstUrl = tostring(dstUrl), domain = tostring(domain), ccl = todynamic(ccl), alerted = tostring(alerted), fileType = tostring(fileType), userInput = tostring(userInput)'
        outputStream: 'Custom-VMware_CWS_DLPLogs_CL'
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
