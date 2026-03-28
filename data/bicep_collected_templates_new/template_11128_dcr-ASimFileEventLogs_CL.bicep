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
// Data Collection Rule for ASimFileEventLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:19:53
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 106, DCR columns: 106 (Type column always filtered)
// Output stream: Custom-ASimFileEventLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ASimFileEventLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ASimFileEventLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventMessage'
            type: 'string'
          }
          {
            name: 'ActingProcessId'
            type: 'string'
          }
          {
            name: 'ActingProcessName'
            type: 'string'
          }
          {
            name: 'ActingProcessCommandLine'
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
            name: 'ActorSessionId'
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
            name: 'ActorUserIdType'
            type: 'string'
          }
          {
            name: 'ActorScope'
            type: 'string'
          }
          {
            name: 'ActingProcessGuid'
            type: 'string'
          }
          {
            name: 'ActorUserId'
            type: 'string'
          }
          {
            name: 'SrcFileSHA512'
            type: 'string'
          }
          {
            name: 'SrcFileSHA256'
            type: 'string'
          }
          {
            name: 'SrcFileSHA1'
            type: 'string'
          }
          {
            name: 'SrcFileMD5'
            type: 'string'
          }
          {
            name: 'SrcFilePathType'
            type: 'string'
          }
          {
            name: 'SrcFilePath'
            type: 'string'
          }
          {
            name: 'SrcFileName'
            type: 'string'
          }
          {
            name: 'SrcFileMimeType'
            type: 'string'
          }
          {
            name: 'SrcFileExtension'
            type: 'string'
          }
          {
            name: 'SrcFileDirectory'
            type: 'string'
          }
          {
            name: 'SrcFileSize'
            type: 'string'
          }
          {
            name: 'HttpUserAgent'
            type: 'string'
          }
          {
            name: 'NetworkApplicationProtocol'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'ThreatLastReportedTime'
            type: 'string'
          }
          {
            name: 'ThreatFirstReportedTime'
            type: 'string'
          }
          {
            name: 'ThreatIsActive'
            type: 'string'
          }
          {
            name: 'ThreatOriginalConfidence'
            type: 'string'
          }
          {
            name: 'ThreatConfidence'
            type: 'string'
          }
          {
            name: 'ThreatField'
            type: 'string'
          }
          {
            name: 'ThreatFilePath'
            type: 'string'
          }
          {
            name: 'ThreatOriginalRiskLevel'
            type: 'string'
          }
          {
            name: 'ThreatRiskLevel'
            type: 'string'
          }
          {
            name: 'ThreatCategory'
            type: 'string'
          }
          {
            name: 'ThreatName'
            type: 'string'
          }
          {
            name: 'ThreatId'
            type: 'string'
          }
          {
            name: 'RuleNumber'
            type: 'string'
          }
          {
            name: 'RuleName'
            type: 'string'
          }
          {
            name: 'TargetUrl'
            type: 'string'
          }
          {
            name: 'TargetAppType'
            type: 'string'
          }
          {
            name: 'TargetAppId'
            type: 'string'
          }
          {
            name: 'TargetAppName'
            type: 'string'
          }
          {
            name: 'SrcGeoLongitude'
            type: 'string'
          }
          {
            name: 'SrcGeoLatitude'
            type: 'string'
          }
          {
            name: 'SrcGeoCity'
            type: 'string'
          }
          {
            name: 'SrcGeoRegion'
            type: 'string'
          }
          {
            name: 'SrcGeoCountry'
            type: 'string'
          }
          {
            name: 'SrcFileCreationTime'
            type: 'string'
          }
          {
            name: 'DvcSubscriptionId'
            type: 'string'
          }
          {
            name: 'TargetFileSize'
            type: 'string'
          }
          {
            name: 'TargetFileSHA512'
            type: 'string'
          }
          {
            name: 'DvcIpAddr'
            type: 'string'
          }
          {
            name: 'Dvc'
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
            name: 'EventSchemaVersion'
            type: 'string'
          }
          {
            name: 'EventSchema'
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
            name: 'EventOriginalSeverity'
            type: 'string'
          }
          {
            name: 'DvcHostname'
            type: 'string'
          }
          {
            name: 'EventSeverity'
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
            name: 'EventOriginalResultDetails'
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
            name: 'TargetFileSHA256'
            type: 'string'
          }
          {
            name: 'TargetFileSHA1'
            type: 'string'
          }
          {
            name: 'TargetFileMD5'
            type: 'string'
          }
          {
            name: 'TargetFilePathType'
            type: 'string'
          }
          {
            name: 'TargetFilePath'
            type: 'string'
          }
          {
            name: 'TargetFileName'
            type: 'string'
          }
          {
            name: 'TargetFileMimeType'
            type: 'string'
          }
          {
            name: 'TargetFileExtension'
            type: 'string'
          }
          {
            name: 'TargetFileDirectory'
            type: 'string'
          }
          {
            name: 'TargetFileCreationTime'
            type: 'string'
          }
          {
            name: 'AdditionalFields'
            type: 'dynamic'
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
            name: 'DvcZone'
            type: 'string'
          }
          {
            name: 'DvcMacAddr'
            type: 'string'
          }
          {
            name: 'DvcIdType'
            type: 'string'
          }
          {
            name: 'DvcId'
            type: 'string'
          }
          {
            name: 'DvcDescription'
            type: 'string'
          }
          {
            name: 'HashType'
            type: 'string'
          }
          {
            name: 'Hash'
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
          name: 'Sentinel-ASimFileEventLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ASimFileEventLogs_CL']
        destinations: ['Sentinel-ASimFileEventLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventMessage = tostring(EventMessage), ActingProcessId = tostring(ActingProcessId), ActingProcessName = tostring(ActingProcessName), ActingProcessCommandLine = tostring(ActingProcessCommandLine), ActorOriginalUserType = tostring(ActorOriginalUserType), ActorUserType = tostring(ActorUserType), ActorSessionId = tostring(ActorSessionId), ActorUsernameType = tostring(ActorUsernameType), ActorUsername = tostring(ActorUsername), ActorUserIdType = tostring(ActorUserIdType), ActorScope = tostring(ActorScope), ActingProcessGuid = tostring(ActingProcessGuid), ActorUserId = tostring(ActorUserId), SrcFileSHA512 = tostring(SrcFileSHA512), SrcFileSHA256 = tostring(SrcFileSHA256), SrcFileSHA1 = tostring(SrcFileSHA1), SrcFileMD5 = tostring(SrcFileMD5), SrcFilePathType = tostring(SrcFilePathType), SrcFilePath = tostring(SrcFilePath), SrcFileName = tostring(SrcFileName), SrcFileMimeType = tostring(SrcFileMimeType), SrcFileExtension = tostring(SrcFileExtension), SrcFileDirectory = tostring(SrcFileDirectory), SrcFileSize = tolong(SrcFileSize), HttpUserAgent = tostring(HttpUserAgent), NetworkApplicationProtocol = tostring(NetworkApplicationProtocol), SrcIpAddr = tostring(SrcIpAddr), ThreatLastReportedTime = todatetime(ThreatLastReportedTime), ThreatFirstReportedTime = todatetime(ThreatFirstReportedTime), ThreatIsActive = tobool(ThreatIsActive), ThreatOriginalConfidence = tostring(ThreatOriginalConfidence), ThreatConfidence = toint(ThreatConfidence), ThreatField = tostring(ThreatField), ThreatFilePath = tostring(ThreatFilePath), ThreatOriginalRiskLevel = tostring(ThreatOriginalRiskLevel), ThreatRiskLevel = toint(ThreatRiskLevel), ThreatCategory = tostring(ThreatCategory), ThreatName = tostring(ThreatName), ThreatId = tostring(ThreatId), RuleNumber = toint(RuleNumber), RuleName = tostring(RuleName), TargetUrl = tostring(TargetUrl), TargetAppType = tostring(TargetAppType), TargetAppId = tostring(TargetAppId), TargetAppName = tostring(TargetAppName), SrcGeoLongitude = toreal(SrcGeoLongitude), SrcGeoLatitude = toreal(SrcGeoLatitude), SrcGeoCity = tostring(SrcGeoCity), SrcGeoRegion = tostring(SrcGeoRegion), SrcGeoCountry = tostring(SrcGeoCountry), SrcFileCreationTime = todatetime(SrcFileCreationTime), DvcSubscriptionId = tostring(DvcSubscriptionId), TargetFileSize = tolong(TargetFileSize), TargetFileSHA512 = tostring(TargetFileSHA512), DvcIpAddr = tostring(DvcIpAddr), Dvc = tostring(Dvc), EventOwner = tostring(EventOwner), EventReportUrl = tostring(EventReportUrl), EventSchemaVersion = tostring(EventSchemaVersion), EventSchema = tostring(EventSchema), EventVendor = tostring(EventVendor), EventProductVersion = tostring(EventProductVersion), EventProduct = tostring(EventProduct), EventOriginalSeverity = tostring(EventOriginalSeverity), DvcHostname = tostring(DvcHostname), EventSeverity = tostring(EventSeverity), EventOriginalSubType = tostring(EventOriginalSubType), EventOriginalType = tostring(EventOriginalType), EventOriginalUid = tostring(EventOriginalUid), EventResultDetails = tostring(EventResultDetails), EventResult = tostring(EventResult), EventSubType = tostring(EventSubType), EventType = tostring(EventType), EventEndTime = todatetime(EventEndTime), EventStartTime = todatetime(EventStartTime), EventCount = toint(EventCount), EventOriginalResultDetails = tostring(EventOriginalResultDetails), DvcDomain = tostring(DvcDomain), DvcDomainType = tostring(DvcDomainType), DvcFQDN = tostring(DvcFQDN), TargetFileSHA256 = tostring(TargetFileSHA256), TargetFileSHA1 = tostring(TargetFileSHA1), TargetFileMD5 = tostring(TargetFileMD5), TargetFilePathType = tostring(TargetFilePathType), TargetFilePath = tostring(TargetFilePath), TargetFileName = tostring(TargetFileName), TargetFileMimeType = tostring(TargetFileMimeType), TargetFileExtension = tostring(TargetFileExtension), TargetFileDirectory = tostring(TargetFileDirectory), TargetFileCreationTime = todatetime(TargetFileCreationTime), AdditionalFields = todynamic(AdditionalFields), DvcScope = tostring(DvcScope), DvcScopeId = tostring(DvcScopeId), DvcInterface = tostring(DvcInterface), DvcOriginalAction = tostring(DvcOriginalAction), DvcAction = tostring(DvcAction), DvcOsVersion = tostring(DvcOsVersion), DvcOs = tostring(DvcOs), DvcZone = tostring(DvcZone), DvcMacAddr = tostring(DvcMacAddr), DvcIdType = tostring(DvcIdType), DvcId = tostring(DvcId), DvcDescription = tostring(DvcDescription), HashType = tostring(HashType), Hash = tostring(Hash)'
        outputStream: 'Custom-ASimFileEventLogs_CL'
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
