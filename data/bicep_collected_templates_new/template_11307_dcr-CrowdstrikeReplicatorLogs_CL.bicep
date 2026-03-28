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
// Data Collection Rule for CrowdstrikeReplicatorLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:15
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 46, DCR columns: 44 (Type column always filtered)
// Output stream: Custom-CrowdstrikeReplicatorLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CrowdstrikeReplicatorLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CrowdstrikeReplicatorLogs_CL': {
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
            name: 'RawProcessId'
            type: 'string'
          }
          {
            name: 'ConfigStateHash'
            type: 'string'
          }
          {
            name: 'MD5HashData'
            type: 'string'
          }
          {
            name: 'SHA256HashData'
            type: 'string'
          }
          {
            name: 'ProcessSxsFlags'
            type: 'string'
          }
          {
            name: 'AuthenticationId'
            type: 'string'
          }
          {
            name: 'ConfigBuild'
            type: 'string'
          }
          {
            name: 'WindowFlags'
            type: 'string'
          }
          {
            name: 'event_simpleName'
            type: 'string'
          }
          {
            name: 'CommandLine'
            type: 'string'
          }
          {
            name: 'TargetProcessId'
            type: 'string'
          }
          {
            name: 'ImageFileName'
            type: 'string'
          }
          {
            name: 'SourceThreadId'
            type: 'string'
          }
          {
            name: 'Entitlements'
            type: 'string'
          }
          {
            name: 'name'
            type: 'string'
          }
          {
            name: 'ProcessStartTime'
            type: 'string'
          }
          {
            name: 'ProcessParameterFlags'
            type: 'string'
          }
          {
            name: 'aid'
            type: 'string'
          }
          {
            name: 'ParentAuthenticationId'
            type: 'string'
          }
          {
            name: 'SignInfoFlags'
            type: 'string'
          }
          {
            name: 'timestamp'
            type: 'string'
          }
          {
            name: 'SessionId'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'ProcessCreateFlags'
            type: 'string'
          }
          {
            name: 'IntegrityLevel'
            type: 'string'
          }
          {
            name: 'ParentProcessId'
            type: 'string'
          }
          {
            name: 'SourceProcessId'
            type: 'string'
          }
          {
            name: 'aip'
            type: 'string'
          }
          {
            name: 'SHA1HashData'
            type: 'string'
          }
          {
            name: 'Tags'
            type: 'string'
          }
          {
            name: 'UserSid'
            type: 'string'
          }
          {
            name: 'TokenType'
            type: 'string'
          }
          {
            name: 'ProcessEndTime'
            type: 'string'
          }
          {
            name: 'AuthenticodeHashData'
            type: 'string'
          }
          {
            name: 'ParentBaseFileName'
            type: 'string'
          }
          {
            name: 'RpcClientProcessId'
            type: 'string'
          }
          {
            name: 'ImageSubsystem'
            type: 'string'
          }
          {
            name: 'id'
            type: 'string'
          }
          {
            name: 'EffectiveTransmissionClass'
            type: 'string'
          }
          {
            name: 'event_platform'
            type: 'string'
          }
          {
            name: 'cid'
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
          name: 'Sentinel-CrowdstrikeReplicatorLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CrowdstrikeReplicatorLogs_CL']
        destinations: ['Sentinel-CrowdstrikeReplicatorLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), RawProcessId = tostring(RawProcessId), ConfigStateHash = tostring(ConfigStateHash), MD5HashData = tostring(MD5HashData), SHA256HashData = tostring(SHA256HashData), ProcessSxsFlags = tostring(ProcessSxsFlags), AuthenticationId = tostring(AuthenticationId), ConfigBuild = tostring(ConfigBuild), WindowFlags = toreal(WindowFlags), event_simpleName = tostring(event_simpleName), CommandLine = tostring(CommandLine), TargetProcessId = tostring(TargetProcessId), ImageFileName = tostring(ImageFileName), SourceThreadId = tostring(SourceThreadId), Entitlements = tostring(Entitlements), name = tostring(name), ProcessStartTime = tostring(ProcessStartTime), ProcessParameterFlags = tostring(ProcessParameterFlags), aid = tostring(aid), ParentAuthenticationId = tostring(ParentAuthenticationId), SignInfoFlags = tostring(SignInfoFlags), timestamp = tostring(timestamp), SessionId = tostring(SessionId), SourceSystem = tostring(SourceSystem), Computer = tostring(Computer), ProcessCreateFlags = tostring(ProcessCreateFlags), IntegrityLevel = toreal(IntegrityLevel), ParentProcessId = tostring(ParentProcessId), SourceProcessId = tostring(SourceProcessId), aip = tostring(aip), SHA1HashData = tostring(SHA1HashData), Tags = tostring(Tags), UserSid = tostring(UserSid), TokenType = toreal(TokenType), ProcessEndTime = tostring(ProcessEndTime), AuthenticodeHashData = tostring(AuthenticodeHashData), ParentBaseFileName = tostring(ParentBaseFileName), RpcClientProcessId = tostring(RpcClientProcessId), ImageSubsystem = tostring(ImageSubsystem), id = tostring(id), EffectiveTransmissionClass = toreal(EffectiveTransmissionClass), event_platform = tostring(event_platform), cid = tostring(cid)'
        outputStream: 'Custom-CrowdstrikeReplicatorLogs_CL'
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
