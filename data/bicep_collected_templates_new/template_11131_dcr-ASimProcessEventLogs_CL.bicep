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
// Data Collection Rule for ASimProcessEventLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:19:53
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 121, DCR columns: 121 (Type column always filtered)
// Output stream: Custom-ASimProcessEventLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ASimProcessEventLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ASimProcessEventLogs_CL': {
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
            name: 'ParentProcessGuid'
            type: 'string'
          }
          {
            name: 'ParentProcessId'
            type: 'string'
          }
          {
            name: 'ParentProcessInjectedAddress'
            type: 'string'
          }
          {
            name: 'ParentProcessIsHidden'
            type: 'string'
          }
          {
            name: 'ParentProcessFileVersion'
            type: 'string'
          }
          {
            name: 'ParentProcessFileProduct'
            type: 'string'
          }
          {
            name: 'ParentProcessFileDescription'
            type: 'string'
          }
          {
            name: 'ParentProcessFileCompany'
            type: 'string'
          }
          {
            name: 'ParentProcessName'
            type: 'string'
          }
          {
            name: 'ActingProcessFileSize'
            type: 'string'
          }
          {
            name: 'ActingProcessTokenElevation'
            type: 'string'
          }
          {
            name: 'ActingProcessCreationTime'
            type: 'string'
          }
          {
            name: 'ParentProcessIntegrityLevel'
            type: 'string'
          }
          {
            name: 'ActingProcessIMPHASH'
            type: 'string'
          }
          {
            name: 'ActingProcessSHA256'
            type: 'string'
          }
          {
            name: 'ActingProcessSHA1'
            type: 'string'
          }
          {
            name: 'ActingProcessMD5'
            type: 'string'
          }
          {
            name: 'ActingProcessIntegrityLevel'
            type: 'string'
          }
          {
            name: 'ActingProcessGuid'
            type: 'string'
          }
          {
            name: 'ActingProcessId'
            type: 'string'
          }
          {
            name: 'ActingProcessInjectedAddress'
            type: 'string'
          }
          {
            name: 'ActingProcessIsHidden'
            type: 'string'
          }
          {
            name: 'ActingProcessFilename'
            type: 'string'
          }
          {
            name: 'ActingProcessFileOriginalName'
            type: 'string'
          }
          {
            name: 'ActingProcessFileInternalName'
            type: 'string'
          }
          {
            name: 'ActingProcessFileVersion'
            type: 'string'
          }
          {
            name: 'ActingProcessSHA512'
            type: 'string'
          }
          {
            name: 'ActingProcessFileProduct'
            type: 'string'
          }
          {
            name: 'ParentProcessMD5'
            type: 'string'
          }
          {
            name: 'ParentProcessSHA256'
            type: 'string'
          }
          {
            name: 'TargetProcessFileSize'
            type: 'string'
          }
          {
            name: 'TargetProcessTokenElevation'
            type: 'string'
          }
          {
            name: 'TargetProcessCreationTime'
            type: 'string'
          }
          {
            name: 'TargetProcessIMPHASH'
            type: 'string'
          }
          {
            name: 'TargetProcessSHA512'
            type: 'string'
          }
          {
            name: 'TargetProcessSHA256'
            type: 'string'
          }
          {
            name: 'TargetProcessSHA1'
            type: 'string'
          }
          {
            name: 'TargetProcessMD5'
            type: 'string'
          }
          {
            name: 'TargetProcessIntegrityLevel'
            type: 'string'
          }
          {
            name: 'TargetProcessGuid'
            type: 'string'
          }
          {
            name: 'TargetProcessId'
            type: 'string'
          }
          {
            name: 'TargetProcessInjectedAddress'
            type: 'string'
          }
          {
            name: 'ParentProcessSHA1'
            type: 'string'
          }
          {
            name: 'TargetProcessIsHidden'
            type: 'string'
          }
          {
            name: 'TargetProcessFileOriginalName'
            type: 'string'
          }
          {
            name: 'TargetProcessFileInternalName'
            type: 'string'
          }
          {
            name: 'TargetProcessFileVersion'
            type: 'string'
          }
          {
            name: 'TargetProcessFileProduct'
            type: 'string'
          }
          {
            name: 'TargetProcessFileDescription'
            type: 'string'
          }
          {
            name: 'TargetProcessFileCompany'
            type: 'string'
          }
          {
            name: 'TargetProcessName'
            type: 'string'
          }
          {
            name: 'TargetProcessCommandLine'
            type: 'string'
          }
          {
            name: 'ParentProcessTokenElevation'
            type: 'string'
          }
          {
            name: 'ParentProcessCreationTime'
            type: 'string'
          }
          {
            name: 'ParentProcessIMPHASH'
            type: 'string'
          }
          {
            name: 'ParentProcessSHA512'
            type: 'string'
          }
          {
            name: 'TargetProcessFilename'
            type: 'string'
          }
          {
            name: 'ActingProcessFileDescription'
            type: 'string'
          }
          {
            name: 'ActingProcessFileCompany'
            type: 'string'
          }
          {
            name: 'ActingProcessName'
            type: 'string'
          }
          {
            name: 'DvcDescription'
            type: 'string'
          }
          {
            name: 'DvcFQDN'
            type: 'string'
          }
          {
            name: 'DvcDomainType'
            type: 'string'
          }
          {
            name: 'DvcDomain'
            type: 'string'
          }
          {
            name: 'DvcHostname'
            type: 'string'
          }
          {
            name: 'DvcIpAddr'
            type: 'string'
          }
          {
            name: 'EventReportUrl'
            type: 'string'
          }
          {
            name: 'EventOwner'
            type: 'string'
          }
          {
            name: 'EventSchemaVersion'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'EventProductVersion'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'DvcId'
            type: 'string'
          }
          {
            name: 'EventOriginalSeverity'
            type: 'string'
          }
          {
            name: 'EventOriginalResultDetails'
            type: 'string'
          }
          {
            name: 'EventOriginalSubType'
            type: 'string'
          }
          {
            name: 'EventOriginalType'
            type: 'string'
          }
          {
            name: 'EventOriginalUid'
            type: 'string'
          }
          {
            name: 'EventResultDetails'
            type: 'string'
          }
          {
            name: 'EventResult'
            type: 'string'
          }
          {
            name: 'EventSubType'
            type: 'string'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'EventStartTime'
            type: 'string'
          }
          {
            name: 'EventCount'
            type: 'string'
          }
          {
            name: 'EventMessage'
            type: 'string'
          }
          {
            name: 'EventSeverity'
            type: 'string'
          }
          {
            name: 'DvcIdType'
            type: 'string'
          }
          {
            name: 'DvcMacAddr'
            type: 'string'
          }
          {
            name: 'DvcZone'
            type: 'string'
          }
          {
            name: 'ActingProcessCommandLine'
            type: 'string'
          }
          {
            name: 'TargetUserSessionGuid'
            type: 'string'
          }
          {
            name: 'TargetUserSessionId'
            type: 'string'
          }
          {
            name: 'TargetOriginalUserType'
            type: 'string'
          }
          {
            name: 'TargetUserType'
            type: 'string'
          }
          {
            name: 'TargetUsernameType'
            type: 'string'
          }
          {
            name: 'TargetUsername'
            type: 'string'
          }
          {
            name: 'TargetScope'
            type: 'string'
          }
          {
            name: 'TargetScopeId'
            type: 'string'
          }
          {
            name: 'TargetUserIdType'
            type: 'string'
          }
          {
            name: 'TargetUserId'
            type: 'string'
          }
          {
            name: 'ActorSessionId'
            type: 'string'
          }
          {
            name: 'ActorOriginalUserType'
            type: 'string'
          }
          {
            name: 'ActorUserType'
            type: 'string'
          }
          {
            name: 'ActorUsernameType'
            type: 'string'
          }
          {
            name: 'ActorUsername'
            type: 'string'
          }
          {
            name: 'ActorScope'
            type: 'string'
          }
          {
            name: 'ActorScopeId'
            type: 'string'
          }
          {
            name: 'ActorUserIdType'
            type: 'string'
          }
          {
            name: 'ActorUserId'
            type: 'string'
          }
          {
            name: 'DvcScope'
            type: 'string'
          }
          {
            name: 'DvcScopeId'
            type: 'string'
          }
          {
            name: 'DvcInterface'
            type: 'string'
          }
          {
            name: 'DvcOriginalAction'
            type: 'string'
          }
          {
            name: 'DvcAction'
            type: 'string'
          }
          {
            name: 'DvcOsVersion'
            type: 'string'
          }
          {
            name: 'DvcOs'
            type: 'string'
          }
          {
            name: 'TargetProcessCurrentDirectory'
            type: 'string'
          }
          {
            name: 'TargetProcessStatusCode'
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
          name: 'Sentinel-ASimProcessEventLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ASimProcessEventLogs_CL']
        destinations: ['Sentinel-ASimProcessEventLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), AdditionalFields = todynamic(AdditionalFields), ParentProcessGuid = tostring(ParentProcessGuid), ParentProcessId = tostring(ParentProcessId), ParentProcessInjectedAddress = tostring(ParentProcessInjectedAddress), ParentProcessIsHidden = tobool(ParentProcessIsHidden), ParentProcessFileVersion = tostring(ParentProcessFileVersion), ParentProcessFileProduct = tostring(ParentProcessFileProduct), ParentProcessFileDescription = tostring(ParentProcessFileDescription), ParentProcessFileCompany = tostring(ParentProcessFileCompany), ParentProcessName = tostring(ParentProcessName), ActingProcessFileSize = tolong(ActingProcessFileSize), ActingProcessTokenElevation = tostring(ActingProcessTokenElevation), ActingProcessCreationTime = todatetime(ActingProcessCreationTime), ParentProcessIntegrityLevel = tostring(ParentProcessIntegrityLevel), ActingProcessIMPHASH = tostring(ActingProcessIMPHASH), ActingProcessSHA256 = tostring(ActingProcessSHA256), ActingProcessSHA1 = tostring(ActingProcessSHA1), ActingProcessMD5 = tostring(ActingProcessMD5), ActingProcessIntegrityLevel = tostring(ActingProcessIntegrityLevel), ActingProcessGuid = tostring(ActingProcessGuid), ActingProcessId = tostring(ActingProcessId), ActingProcessInjectedAddress = tostring(ActingProcessInjectedAddress), ActingProcessIsHidden = tobool(ActingProcessIsHidden), ActingProcessFilename = tostring(ActingProcessFilename), ActingProcessFileOriginalName = tostring(ActingProcessFileOriginalName), ActingProcessFileInternalName = tostring(ActingProcessFileInternalName), ActingProcessFileVersion = tostring(ActingProcessFileVersion), ActingProcessSHA512 = tostring(ActingProcessSHA512), ActingProcessFileProduct = tostring(ActingProcessFileProduct), ParentProcessMD5 = tostring(ParentProcessMD5), ParentProcessSHA256 = tostring(ParentProcessSHA256), TargetProcessFileSize = tolong(TargetProcessFileSize), TargetProcessTokenElevation = tostring(TargetProcessTokenElevation), TargetProcessCreationTime = todatetime(TargetProcessCreationTime), TargetProcessIMPHASH = tostring(TargetProcessIMPHASH), TargetProcessSHA512 = tostring(TargetProcessSHA512), TargetProcessSHA256 = tostring(TargetProcessSHA256), TargetProcessSHA1 = tostring(TargetProcessSHA1), TargetProcessMD5 = tostring(TargetProcessMD5), TargetProcessIntegrityLevel = tostring(TargetProcessIntegrityLevel), TargetProcessGuid = tostring(TargetProcessGuid), TargetProcessId = tostring(TargetProcessId), TargetProcessInjectedAddress = tostring(TargetProcessInjectedAddress), ParentProcessSHA1 = tostring(ParentProcessSHA1), TargetProcessIsHidden = tobool(TargetProcessIsHidden), TargetProcessFileOriginalName = tostring(TargetProcessFileOriginalName), TargetProcessFileInternalName = tostring(TargetProcessFileInternalName), TargetProcessFileVersion = tostring(TargetProcessFileVersion), TargetProcessFileProduct = tostring(TargetProcessFileProduct), TargetProcessFileDescription = tostring(TargetProcessFileDescription), TargetProcessFileCompany = tostring(TargetProcessFileCompany), TargetProcessName = tostring(TargetProcessName), TargetProcessCommandLine = tostring(TargetProcessCommandLine), ParentProcessTokenElevation = tostring(ParentProcessTokenElevation), ParentProcessCreationTime = todatetime(ParentProcessCreationTime), ParentProcessIMPHASH = tostring(ParentProcessIMPHASH), ParentProcessSHA512 = tostring(ParentProcessSHA512), TargetProcessFilename = tostring(TargetProcessFilename), ActingProcessFileDescription = tostring(ActingProcessFileDescription), ActingProcessFileCompany = tostring(ActingProcessFileCompany), ActingProcessName = tostring(ActingProcessName), DvcDescription = tostring(DvcDescription), DvcFQDN = tostring(DvcFQDN), DvcDomainType = tostring(DvcDomainType), DvcDomain = tostring(DvcDomain), DvcHostname = tostring(DvcHostname), DvcIpAddr = tostring(DvcIpAddr), EventReportUrl = tostring(EventReportUrl), EventOwner = tostring(EventOwner), EventSchemaVersion = tostring(EventSchemaVersion), EventVendor = tostring(EventVendor), EventProductVersion = tostring(EventProductVersion), EventProduct = tostring(EventProduct), DvcId = tostring(DvcId), EventOriginalSeverity = tostring(EventOriginalSeverity), EventOriginalResultDetails = tostring(EventOriginalResultDetails), EventOriginalSubType = tostring(EventOriginalSubType), EventOriginalType = tostring(EventOriginalType), EventOriginalUid = tostring(EventOriginalUid), EventResultDetails = tostring(EventResultDetails), EventResult = tostring(EventResult), EventSubType = tostring(EventSubType), EventType = tostring(EventType), EventEndTime = todatetime(EventEndTime), EventStartTime = todatetime(EventStartTime), EventCount = toint(EventCount), EventMessage = tostring(EventMessage), EventSeverity = tostring(EventSeverity), DvcIdType = tostring(DvcIdType), DvcMacAddr = tostring(DvcMacAddr), DvcZone = tostring(DvcZone), ActingProcessCommandLine = tostring(ActingProcessCommandLine), TargetUserSessionGuid = tostring(TargetUserSessionGuid), TargetUserSessionId = tostring(TargetUserSessionId), TargetOriginalUserType = tostring(TargetOriginalUserType), TargetUserType = tostring(TargetUserType), TargetUsernameType = tostring(TargetUsernameType), TargetUsername = tostring(TargetUsername), TargetScope = tostring(TargetScope), TargetScopeId = tostring(TargetScopeId), TargetUserIdType = tostring(TargetUserIdType), TargetUserId = tostring(TargetUserId), ActorSessionId = tostring(ActorSessionId), ActorOriginalUserType = tostring(ActorOriginalUserType), ActorUserType = tostring(ActorUserType), ActorUsernameType = tostring(ActorUsernameType), ActorUsername = tostring(ActorUsername), ActorScope = tostring(ActorScope), ActorScopeId = tostring(ActorScopeId), ActorUserIdType = tostring(ActorUserIdType), ActorUserId = tostring(ActorUserId), DvcScope = tostring(DvcScope), DvcScopeId = tostring(DvcScopeId), DvcInterface = tostring(DvcInterface), DvcOriginalAction = tostring(DvcOriginalAction), DvcAction = tostring(DvcAction), DvcOsVersion = tostring(DvcOsVersion), DvcOs = tostring(DvcOs), TargetProcessCurrentDirectory = tostring(TargetProcessCurrentDirectory), TargetProcessStatusCode = tostring(TargetProcessStatusCode)'
        outputStream: 'Custom-ASimProcessEventLogs_CL'
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
