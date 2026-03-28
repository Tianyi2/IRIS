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
// Data Collection Rule for MimecastSIEM_CL
// ============================================================================
// Generated: 2025-09-19 14:20:24
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-MimecastSIEM_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MimecastSIEM_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MimecastSIEM_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'datetime_d'
            type: 'string'
          }
          {
            name: 'mimecastEventId_s'
            type: 'string'
          }
          {
            name: 'reason_s'
            type: 'string'
          }
          {
            name: 'logType_s'
            type: 'string'
          }
          {
            name: 'Subject_s'
            type: 'string'
          }
          {
            name: 'MsgId_s'
            type: 'string'
          }
          {
            name: 'MsgSize_s'
            type: 'string'
          }
          {
            name: 'mimecastEventCategory_s'
            type: 'string'
          }
          {
            name: 'AttNames_s'
            type: 'string'
          }
          {
            name: 'Act_s'
            type: 'string'
          }
          {
            name: 'AttSize_s'
            type: 'string'
          }
          {
            name: 'Hld_s'
            type: 'string'
          }
          {
            name: 'Sender_s'
            type: 'string'
          }
          {
            name: 'acc_s'
            type: 'string'
          }
          {
            name: 'aCode_s'
            type: 'string'
          }
          {
            name: 'AttCnt_s'
            type: 'string'
          }
          {
            name: 'time_generated'
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
          name: 'Sentinel-MimecastSIEM_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MimecastSIEM_CL']
        destinations: ['Sentinel-MimecastSIEM_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), datetime_d = todatetime(datetime_d), mimecastEventId_s = tostring(mimecastEventId_s), reason_s = tostring(reason_s), logType_s = tostring(logType_s), Subject_s = tostring(Subject_s), MsgId_s = tostring(MsgId_s), MsgSize_s = tostring(MsgSize_s), mimecastEventCategory_s = tostring(mimecastEventCategory_s), AttNames_s = tostring(AttNames_s), Act_s = tostring(Act_s), AttSize_s = tostring(AttSize_s), Hld_s = tostring(Hld_s), Sender_s = tostring(Sender_s), acc_s = tostring(acc_s), aCode_s = tostring(aCode_s), AttCnt_s = tostring(AttCnt_s), time_generated = todatetime(time_generated)'
        outputStream: 'Custom-MimecastSIEM_CL'
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
