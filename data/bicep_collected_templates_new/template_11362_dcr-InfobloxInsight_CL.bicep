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
// Data Collection Rule for InfobloxInsight_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 29, DCR columns: 27 (Type column always filtered)
// Output stream: Custom-InfobloxInsight_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-InfobloxInsight_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-InfobloxInsight_CL': {
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
            name: 'dateChanged_t'
            type: 'string'
          }
          {
            name: 'eventsBlockedCount_s'
            type: 'string'
          }
          {
            name: 'mostRecentAt_t'
            type: 'string'
          }
          {
            name: 'numEvents_s'
            type: 'string'
          }
          {
            name: 'persistentDate_t'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'threatType_s'
            type: 'string'
          }
          {
            name: 'startedAt_t'
            type: 'string'
          }
          {
            name: 'feedSource_s'
            type: 'string'
          }
          {
            name: 'insightId_g'
            type: 'string'
          }
          {
            name: 'tFamily_s'
            type: 'string'
          }
          {
            name: 'tClass_s'
            type: 'string'
          }
          {
            name: 'hello_s'
            type: 'string'
          }
          {
            name: 'InfobloxInsightLogType_s'
            type: 'string'
          }
          {
            name: 'eventsNotBlockedCount_s'
            type: 'string'
          }
          {
            name: 'userComment_s'
            type: 'string'
          }
          {
            name: 'changer_s'
            type: 'string'
          }
          {
            name: 'spreadingDate_t'
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
            name: 'priorityText_s'
            type: 'string'
          }
          {
            name: 'InfobloxInsightID'
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
          name: 'Sentinel-InfobloxInsight_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-InfobloxInsight_CL']
        destinations: ['Sentinel-InfobloxInsight_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), dateChanged_t = todatetime(dateChanged_t), eventsBlockedCount_s = tostring(eventsBlockedCount_s), mostRecentAt_t = todatetime(mostRecentAt_t), numEvents_s = tostring(numEvents_s), persistentDate_t = todatetime(persistentDate_t), status_s = tostring(status_s), threatType_s = tostring(threatType_s), startedAt_t = todatetime(startedAt_t), feedSource_s = tostring(feedSource_s), insightId_g = toguid(insightId_g), tFamily_s = tostring(tFamily_s), tClass_s = tostring(tClass_s), hello_s = tostring(hello_s), InfobloxInsightLogType_s = tostring(InfobloxInsightLogType_s), eventsNotBlockedCount_s = tostring(eventsNotBlockedCount_s), userComment_s = tostring(userComment_s), changer_s = tostring(changer_s), spreadingDate_t = todatetime(spreadingDate_t), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), priorityText_s = tostring(priorityText_s), InfobloxInsightID = tostring(InfobloxInsightID)'
        outputStream: 'Custom-InfobloxInsight_CL'
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
