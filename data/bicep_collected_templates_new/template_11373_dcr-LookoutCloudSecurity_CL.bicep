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
// Data Collection Rule for LookoutCloudSecurity_CL
// ============================================================================
// Generated: 2025-09-19 14:20:23
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 35, DCR columns: 33 (Type column always filtered)
// Output stream: Custom-LookoutCloudSecurity_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-LookoutCloudSecurity_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-LookoutCloudSecurity_CL': {
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
            name: 'statusCode_d'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'violation_s'
            type: 'string'
          }
          {
            name: 'scanType_s'
            type: 'string'
          }
          {
            name: 'policyName_s'
            type: 'string'
          }
          {
            name: 'externalCollaborators_s'
            type: 'string'
          }
          {
            name: 'cloudType_s'
            type: 'string'
          }
          {
            name: 'previousCity_s'
            type: 'string'
          }
          {
            name: 'previousEventId_g'
            type: 'string'
          }
          {
            name: 'currentEventId_g'
            type: 'string'
          }
          {
            name: 'previousTimestamp_t'
            type: 'string'
          }
          {
            name: 'currentTimestamp_t'
            type: 'string'
          }
          {
            name: 'currentCity_s'
            type: 'string'
          }
          {
            name: 'anomalyName_s'
            type: 'string'
          }
          {
            name: 'userEmail_s'
            type: 'string'
          }
          {
            name: 'anomalyType_s'
            type: 'string'
          }
          {
            name: 'eventId_g'
            type: 'string'
          }
          {
            name: 'contentUrl_s'
            type: 'string'
          }
          {
            name: 'contentName_s'
            type: 'string'
          }
          {
            name: 'appName_s'
            type: 'string'
          }
          {
            name: 'activityType_s'
            type: 'string'
          }
          {
            name: 'actionType_s'
            type: 'string'
          }
          {
            name: 'eventType_s'
            type: 'string'
          }
          {
            name: 'timeStamp_t'
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
            name: 'Message'
            type: 'string'
          }
          {
            name: 'data_s'
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
          name: 'Sentinel-LookoutCloudSecurity_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-LookoutCloudSecurity_CL']
        destinations: ['Sentinel-LookoutCloudSecurity_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), statusCode_d = toreal(statusCode_d), status_s = tostring(status_s), violation_s = tostring(violation_s), scanType_s = tostring(scanType_s), policyName_s = tostring(policyName_s), externalCollaborators_s = tostring(externalCollaborators_s), cloudType_s = tostring(cloudType_s), previousCity_s = tostring(previousCity_s), previousEventId_g = tostring(previousEventId_g), currentEventId_g = tostring(currentEventId_g), previousTimestamp_t = todatetime(previousTimestamp_t), currentTimestamp_t = todatetime(currentTimestamp_t), currentCity_s = tostring(currentCity_s), anomalyName_s = tostring(anomalyName_s), userEmail_s = tostring(userEmail_s), anomalyType_s = tostring(anomalyType_s), eventId_g = tostring(eventId_g), contentUrl_s = tostring(contentUrl_s), contentName_s = tostring(contentName_s), appName_s = tostring(appName_s), activityType_s = tostring(activityType_s), actionType_s = tostring(actionType_s), eventType_s = tostring(eventType_s), timeStamp_t = todatetime(timeStamp_t), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), Message = tostring(Message), data_s = tostring(data_s)'
        outputStream: 'Custom-LookoutCloudSecurity_CL'
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
