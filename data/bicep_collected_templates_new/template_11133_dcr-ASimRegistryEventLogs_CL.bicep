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
// Data Collection Rule for ASimRegistryEventLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:19:53
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 60, DCR columns: 60 (Type column always filtered)
// Output stream: Custom-ASimRegistryEventLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ASimRegistryEventLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ASimRegistryEventLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'AdditionalFields'
            type: 'dynamic'
          }
          {
            name: 'DvcOs'
            type: 'string'
          }
          {
            name: 'DvcOsVersion'
            type: 'string'
          }
          {
            name: 'DvcAction'
            type: 'string'
          }
          {
            name: 'DvcOriginalAction'
            type: 'string'
          }
          {
            name: 'DvcInterface'
            type: 'string'
          }
          {
            name: 'DvcScopeId'
            type: 'string'
          }
          {
            name: 'DvcScope'
            type: 'string'
          }
          {
            name: 'ActorUserId'
            type: 'string'
          }
          {
            name: 'ActorUserIdType'
            type: 'string'
          }
          {
            name: 'ActorScopeId'
            type: 'string'
          }
          {
            name: 'ActorScope'
            type: 'string'
          }
          {
            name: 'ActorUsername'
            type: 'string'
          }
          {
            name: 'DvcZone'
            type: 'string'
          }
          {
            name: 'ActorUsernameType'
            type: 'string'
          }
          {
            name: 'ActingProcessName'
            type: 'string'
          }
          {
            name: 'ActingProcessId'
            type: 'string'
          }
          {
            name: 'ActingProcessGuid'
            type: 'string'
          }
          {
            name: 'ParentProcessName'
            type: 'string'
          }
          {
            name: 'ParentProcessId'
            type: 'string'
          }
          {
            name: 'ParentProcessGuid'
            type: 'string'
          }
          {
            name: 'RegistryKey'
            type: 'string'
          }
          {
            name: 'RegistryValue'
            type: 'string'
          }
          {
            name: 'RegistryValueType'
            type: 'string'
          }
          {
            name: 'RegistryValueData'
            type: 'string'
          }
          {
            name: 'RegistryPreviousKey'
            type: 'string'
          }
          {
            name: 'RegistryPreviousValue'
            type: 'string'
          }
          {
            name: 'ActorSessionId'
            type: 'string'
          }
          {
            name: 'RegistryPreviousValueType'
            type: 'string'
          }
          {
            name: 'DvcMacAddr'
            type: 'string'
          }
          {
            name: 'DvcId'
            type: 'string'
          }
          {
            name: 'EventMessage'
            type: 'string'
          }
          {
            name: 'EventCount'
            type: 'string'
          }
          {
            name: 'EventStartTime'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'EventSubType'
            type: 'string'
          }
          {
            name: 'EventResult'
            type: 'string'
          }
          {
            name: 'EventResultDetails'
            type: 'string'
          }
          {
            name: 'EventOriginalUid'
            type: 'string'
          }
          {
            name: 'EventOriginalType'
            type: 'string'
          }
          {
            name: 'EventOriginalSubType'
            type: 'string'
          }
          {
            name: 'EventOriginalResultDetails'
            type: 'string'
          }
          {
            name: 'DvcIdType'
            type: 'string'
          }
          {
            name: 'EventSeverity'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'EventProductVersion'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'EventSchemaVersion'
            type: 'string'
          }
          {
            name: 'EventOwner'
            type: 'string'
          }
          {
            name: 'EventReportUrl'
            type: 'string'
          }
          {
            name: 'DvcIpAddr'
            type: 'string'
          }
          {
            name: 'DvcHostname'
            type: 'string'
          }
          {
            name: 'DvcDomain'
            type: 'string'
          }
          {
            name: 'DvcDomainType'
            type: 'string'
          }
          {
            name: 'DvcFQDN'
            type: 'string'
          }
          {
            name: 'DvcDescription'
            type: 'string'
          }
          {
            name: 'EventOriginalSeverity'
            type: 'string'
          }
          {
            name: 'RegistryPreviousValueData'
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
          name: 'Sentinel-ASimRegistryEventLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ASimRegistryEventLogs_CL']
        destinations: ['Sentinel-ASimRegistryEventLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), AdditionalFields = todynamic(AdditionalFields), DvcOs = tostring(DvcOs), DvcOsVersion = tostring(DvcOsVersion), DvcAction = tostring(DvcAction), DvcOriginalAction = tostring(DvcOriginalAction), DvcInterface = tostring(DvcInterface), DvcScopeId = tostring(DvcScopeId), DvcScope = tostring(DvcScope), ActorUserId = tostring(ActorUserId), ActorUserIdType = tostring(ActorUserIdType), ActorScopeId = tostring(ActorScopeId), ActorScope = tostring(ActorScope), ActorUsername = tostring(ActorUsername), DvcZone = tostring(DvcZone), ActorUsernameType = tostring(ActorUsernameType), ActingProcessName = tostring(ActingProcessName), ActingProcessId = tostring(ActingProcessId), ActingProcessGuid = tostring(ActingProcessGuid), ParentProcessName = tostring(ParentProcessName), ParentProcessId = tostring(ParentProcessId), ParentProcessGuid = tostring(ParentProcessGuid), RegistryKey = tostring(RegistryKey), RegistryValue = tostring(RegistryValue), RegistryValueType = tostring(RegistryValueType), RegistryValueData = tostring(RegistryValueData), RegistryPreviousKey = tostring(RegistryPreviousKey), RegistryPreviousValue = tostring(RegistryPreviousValue), ActorSessionId = tostring(ActorSessionId), RegistryPreviousValueType = tostring(RegistryPreviousValueType), DvcMacAddr = tostring(DvcMacAddr), DvcId = tostring(DvcId), EventMessage = tostring(EventMessage), EventCount = toint(EventCount), EventStartTime = todatetime(EventStartTime), EventEndTime = todatetime(EventEndTime), EventType = tostring(EventType), EventSubType = tostring(EventSubType), EventResult = tostring(EventResult), EventResultDetails = tostring(EventResultDetails), EventOriginalUid = tostring(EventOriginalUid), EventOriginalType = tostring(EventOriginalType), EventOriginalSubType = tostring(EventOriginalSubType), EventOriginalResultDetails = tostring(EventOriginalResultDetails), DvcIdType = tostring(DvcIdType), EventSeverity = tostring(EventSeverity), EventProduct = tostring(EventProduct), EventProductVersion = tostring(EventProductVersion), EventVendor = tostring(EventVendor), EventSchemaVersion = tostring(EventSchemaVersion), EventOwner = tostring(EventOwner), EventReportUrl = tostring(EventReportUrl), DvcIpAddr = tostring(DvcIpAddr), DvcHostname = tostring(DvcHostname), DvcDomain = tostring(DvcDomain), DvcDomainType = tostring(DvcDomainType), DvcFQDN = tostring(DvcFQDN), DvcDescription = tostring(DvcDescription), EventOriginalSeverity = tostring(EventOriginalSeverity), RegistryPreviousValueData = tostring(RegistryPreviousValueData)'
        outputStream: 'Custom-ASimRegistryEventLogs_CL'
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
