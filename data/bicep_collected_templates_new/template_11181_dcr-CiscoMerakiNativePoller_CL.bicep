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
// Data Collection Rule for CiscoMerakiNativePoller_CL
// ============================================================================
// Generated: 2025-09-19 14:19:59
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 150, DCR columns: 150 (Type column always filtered)
// Output stream: Custom-CiscoMerakiNativePoller_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CiscoMerakiNativePoller_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CiscoMerakiNativePoller_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventCount'
            type: 'string'
          }
          {
            name: 'EventOriginalUid'
            type: 'string'
          }
          {
            name: 'EventReportUrl'
            type: 'string'
          }
          {
            name: 'DvcFQDN'
            type: 'string'
          }
          {
            name: 'DvcId'
            type: 'string'
          }
          {
            name: 'DvcIdType'
            type: 'string'
          }
          {
            name: 'SrcHostname'
            type: 'string'
          }
          {
            name: 'NetworkProtocol'
            type: 'string'
          }
          {
            name: 'SrcDomain'
            type: 'string'
          }
          {
            name: 'SrcFQDN'
            type: 'string'
          }
          {
            name: 'SrcDvcId'
            type: 'string'
          }
          {
            name: 'SrcDvcIdType'
            type: 'string'
          }
          {
            name: 'SrcDeviceType'
            type: 'string'
          }
          {
            name: 'SrcUserId'
            type: 'string'
          }
          {
            name: 'SrcUserIdType'
            type: 'string'
          }
          {
            name: 'SrcDomainType'
            type: 'string'
          }
          {
            name: 'DstIpAddr'
            type: 'string'
          }
          {
            name: 'SrcPortNumber'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'ThreatRiskLevelOriginal'
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
            name: 'EventOriginalType'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'EventVendor'
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
            name: 'DvcOs'
            type: 'string'
          }
          {
            name: 'DvcOsVersion'
            type: 'string'
          }
          {
            name: 'AdditionalFields'
            type: 'dynamic'
          }
          {
            name: 'SrcUsername'
            type: 'string'
          }
          {
            name: 'SrcUsernameType'
            type: 'string'
          }
          {
            name: 'SrcUserType'
            type: 'string'
          }
          {
            name: 'SrcOriginalUserType'
            type: 'string'
          }
          {
            name: 'HttpRequestXff'
            type: 'string'
          }
          {
            name: 'HttpRequestTime'
            type: 'string'
          }
          {
            name: 'HttpResponseTime'
            type: 'string'
          }
          {
            name: 'FileName'
            type: 'string'
          }
          {
            name: 'FileMD5'
            type: 'string'
          }
          {
            name: 'FileSHA1'
            type: 'string'
          }
          {
            name: 'FileSHA256'
            type: 'string'
          }
          {
            name: 'FileSHA512'
            type: 'string'
          }
          {
            name: 'Hash'
            type: 'string'
          }
          {
            name: 'FileHashType'
            type: 'string'
          }
          {
            name: 'FileSize'
            type: 'string'
          }
          {
            name: 'FileContentType'
            type: 'string'
          }
          {
            name: 'RuleName'
            type: 'string'
          }
          {
            name: 'RuleNumber'
            type: 'string'
          }
          {
            name: 'Rule'
            type: 'string'
          }
          {
            name: 'UserAgent'
            type: 'string'
          }
          {
            name: 'ThreatRiskLevel'
            type: 'string'
          }
          {
            name: 'HttpUserAgent'
            type: 'string'
          }
          {
            name: 'HttpContentFormat'
            type: 'string'
          }
          {
            name: 'DstPortNumber'
            type: 'string'
          }
          {
            name: 'DstHostname'
            type: 'string'
          }
          {
            name: 'DstDomain'
            type: 'string'
          }
          {
            name: 'DstDomainType'
            type: 'string'
          }
          {
            name: 'DstFQDN'
            type: 'string'
          }
          {
            name: 'DstDvcId'
            type: 'string'
          }
          {
            name: 'DstDvcIdType'
            type: 'string'
          }
          {
            name: 'DstDeviceType'
            type: 'string'
          }
          {
            name: 'Url'
            type: 'string'
          }
          {
            name: 'UrlCategory'
            type: 'string'
          }
          {
            name: 'UrlOriginal'
            type: 'string'
          }
          {
            name: 'HttpVersion'
            type: 'string'
          }
          {
            name: 'HttpRequestMethod'
            type: 'string'
          }
          {
            name: 'HttpStatusCode'
            type: 'string'
          }
          {
            name: 'HttpContentType'
            type: 'string'
          }
          {
            name: 'HttpReferrer'
            type: 'string'
          }
          {
            name: 'NetworkDuration'
            type: 'string'
          }
          {
            name: 'ThreatCategory'
            type: 'string'
          }
          {
            name: 'ThreatId'
            type: 'string'
          }
          {
            name: 'NetworkIcmpCode'
            type: 'string'
          }
          {
            name: 'NetworkIcmpType'
            type: 'string'
          }
          {
            name: 'NetworkConnectionHistory'
            type: 'string'
          }
          {
            name: 'DstBytes'
            type: 'string'
          }
          {
            name: 'SrcBytes'
            type: 'string'
          }
          {
            name: 'NetworkBytes'
            type: 'string'
          }
          {
            name: 'NetworkDirection'
            type: 'string'
          }
          {
            name: 'DstPackets'
            type: 'string'
          }
          {
            name: 'NetworkPackets'
            type: 'string'
          }
          {
            name: 'NetworkSessionId'
            type: 'string'
          }
          {
            name: 'DstZone'
            type: 'string'
          }
          {
            name: 'DstInterfaceName'
            type: 'string'
          }
          {
            name: 'DstInterfaceGuid'
            type: 'string'
          }
          {
            name: 'DstMacAddr'
            type: 'string'
          }
          {
            name: 'SrcPackets'
            type: 'string'
          }
          {
            name: 'NetworkProtocolVersion'
            type: 'string'
          }
          {
            name: 'NetworkApplicationProtocol'
            type: 'string'
          }
          {
            name: 'EventOriginalSubType'
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
            name: 'DvcAction'
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
            name: 'EventStartTime'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'DvcMacAddr'
            type: 'string'
          }
          {
            name: 'Dvc'
            type: 'string'
          }
          {
            name: 'DvcZone'
            type: 'string'
          }
          {
            name: 'EventProductVersion'
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
            name: 'DvcSubscriptionId'
            type: 'string'
          }
          {
            name: 'EventOriginalSeverity'
            type: 'string'
          }
          {
            name: 'DstVlanId'
            type: 'string'
          }
          {
            name: 'DstSubscriptionId'
            type: 'string'
          }
          {
            name: 'DstGeoCountry'
            type: 'string'
          }
          {
            name: 'DstGeoRegion'
            type: 'string'
          }
          {
            name: 'SrcGeoRegion'
            type: 'string'
          }
          {
            name: 'SrcGeoCity'
            type: 'string'
          }
          {
            name: 'SrcGeoLatitude'
            type: 'string'
          }
          {
            name: 'SrcGeoLongitude'
            type: 'string'
          }
          {
            name: 'SrcAppName'
            type: 'string'
          }
          {
            name: 'SrcAppId'
            type: 'string'
          }
          {
            name: 'SrcAppType'
            type: 'string'
          }
          {
            name: 'DstNatIpAddr'
            type: 'string'
          }
          {
            name: 'DstNatPortNumber'
            type: 'string'
          }
          {
            name: 'SrcNatIpAddr'
            type: 'string'
          }
          {
            name: 'SrcNatPortNumber'
            type: 'string'
          }
          {
            name: 'DvcInboundInterface'
            type: 'string'
          }
          {
            name: 'DvcOutboundInterface'
            type: 'string'
          }
          {
            name: 'NetworkRuleName'
            type: 'string'
          }
          {
            name: 'NetworkRuleNumber'
            type: 'string'
          }
          {
            name: 'SrcGeoCountry'
            type: 'string'
          }
          {
            name: 'ThreatName'
            type: 'string'
          }
          {
            name: 'SrcSubscriptionId'
            type: 'string'
          }
          {
            name: 'SrcMacAddr'
            type: 'string'
          }
          {
            name: 'DstGeoCity'
            type: 'string'
          }
          {
            name: 'DstGeoLatitude'
            type: 'string'
          }
          {
            name: 'DstGeoLongitude'
            type: 'string'
          }
          {
            name: 'DstUserId'
            type: 'string'
          }
          {
            name: 'DstUserIdType'
            type: 'string'
          }
          {
            name: 'DstUsername'
            type: 'string'
          }
          {
            name: 'DstUsernameType'
            type: 'string'
          }
          {
            name: 'DstUserType'
            type: 'string'
          }
          {
            name: 'DstOriginalUserType'
            type: 'string'
          }
          {
            name: 'DstAppName'
            type: 'string'
          }
          {
            name: 'DstAppId'
            type: 'string'
          }
          {
            name: 'DstAppType'
            type: 'string'
          }
          {
            name: 'SrcZone'
            type: 'string'
          }
          {
            name: 'SrcInterfaceName'
            type: 'string'
          }
          {
            name: 'SrcInterfaceGuid'
            type: 'string'
          }
          {
            name: 'SrcVlanId'
            type: 'string'
          }
          {
            name: 'IpAddr'
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
          name: 'Sentinel-CiscoMerakiNativePoller_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CiscoMerakiNativePoller_CL']
        destinations: ['Sentinel-CiscoMerakiNativePoller_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventCount = toint(EventCount), EventOriginalUid = tostring(EventOriginalUid), EventReportUrl = tostring(EventReportUrl), DvcFQDN = tostring(DvcFQDN), DvcId = tostring(DvcId), DvcIdType = tostring(DvcIdType), SrcHostname = tostring(SrcHostname), NetworkProtocol = tostring(NetworkProtocol), SrcDomain = tostring(SrcDomain), SrcFQDN = tostring(SrcFQDN), SrcDvcId = tostring(SrcDvcId), SrcDvcIdType = tostring(SrcDvcIdType), SrcDeviceType = tostring(SrcDeviceType), SrcUserId = tostring(SrcUserId), SrcUserIdType = tostring(SrcUserIdType), SrcDomainType = tostring(SrcDomainType), DstIpAddr = tostring(DstIpAddr), SrcPortNumber = toint(SrcPortNumber), SrcIpAddr = tostring(SrcIpAddr), ThreatRiskLevelOriginal = tostring(ThreatRiskLevelOriginal), EventType = tostring(EventType), EventSubType = tostring(EventSubType), EventResult = tostring(EventResult), EventResultDetails = tostring(EventResultDetails), EventOriginalType = tostring(EventOriginalType), EventProduct = tostring(EventProduct), EventVendor = tostring(EventVendor), DvcIpAddr = tostring(DvcIpAddr), DvcHostname = tostring(DvcHostname), DvcDomain = tostring(DvcDomain), DvcDomainType = tostring(DvcDomainType), DvcOs = tostring(DvcOs), DvcOsVersion = tostring(DvcOsVersion), AdditionalFields = todynamic(AdditionalFields), SrcUsername = tostring(SrcUsername), SrcUsernameType = tostring(SrcUsernameType), SrcUserType = tostring(SrcUserType), SrcOriginalUserType = tostring(SrcOriginalUserType), HttpRequestXff = tostring(HttpRequestXff), HttpRequestTime = toint(HttpRequestTime), HttpResponseTime = toint(HttpResponseTime), FileName = tostring(FileName), FileMD5 = tostring(FileMD5), FileSHA1 = tostring(FileSHA1), FileSHA256 = tostring(FileSHA256), FileSHA512 = tostring(FileSHA512), Hash = tostring(Hash), FileHashType = tostring(FileHashType), FileSize = toint(FileSize), FileContentType = tostring(FileContentType), RuleName = tostring(RuleName), RuleNumber = toint(RuleNumber), Rule = tostring(Rule), UserAgent = tostring(UserAgent), ThreatRiskLevel = toint(ThreatRiskLevel), HttpUserAgent = tostring(HttpUserAgent), HttpContentFormat = tostring(HttpContentFormat), DstPortNumber = toint(DstPortNumber), DstHostname = tostring(DstHostname), DstDomain = tostring(DstDomain), DstDomainType = tostring(DstDomainType), DstFQDN = tostring(DstFQDN), DstDvcId = tostring(DstDvcId), DstDvcIdType = tostring(DstDvcIdType), DstDeviceType = tostring(DstDeviceType), Url = tostring(Url), UrlCategory = tostring(UrlCategory), UrlOriginal = tostring(UrlOriginal), HttpVersion = tostring(HttpVersion), HttpRequestMethod = tostring(HttpRequestMethod), HttpStatusCode = tostring(HttpStatusCode), HttpContentType = tostring(HttpContentType), HttpReferrer = tostring(HttpReferrer), NetworkDuration = toint(NetworkDuration), ThreatCategory = tostring(ThreatCategory), ThreatId = tostring(ThreatId), NetworkIcmpCode = toint(NetworkIcmpCode), NetworkIcmpType = tostring(NetworkIcmpType), NetworkConnectionHistory = tostring(NetworkConnectionHistory), DstBytes = tolong(DstBytes), SrcBytes = tolong(SrcBytes), NetworkBytes = tolong(NetworkBytes), NetworkDirection = tostring(NetworkDirection), DstPackets = tolong(DstPackets), NetworkPackets = tolong(NetworkPackets), NetworkSessionId = tostring(NetworkSessionId), DstZone = tostring(DstZone), DstInterfaceName = tostring(DstInterfaceName), DstInterfaceGuid = tostring(DstInterfaceGuid), DstMacAddr = tostring(DstMacAddr), SrcPackets = tolong(SrcPackets), NetworkProtocolVersion = tostring(NetworkProtocolVersion), NetworkApplicationProtocol = tostring(NetworkApplicationProtocol), EventOriginalSubType = tostring(EventOriginalSubType), EventSchemaVersion = tostring(EventSchemaVersion), EventSchema = tostring(EventSchema), DvcAction = tostring(DvcAction), EventMessage = tostring(EventMessage), EventSeverity = tostring(EventSeverity), EventStartTime = todatetime(EventStartTime), EventEndTime = todatetime(EventEndTime), DvcMacAddr = tostring(DvcMacAddr), Dvc = tostring(Dvc), DvcZone = tostring(DvcZone), EventProductVersion = tostring(EventProductVersion), DvcOriginalAction = tostring(DvcOriginalAction), DvcInterface = tostring(DvcInterface), DvcSubscriptionId = tostring(DvcSubscriptionId), EventOriginalSeverity = tostring(EventOriginalSeverity), DstVlanId = tostring(DstVlanId), DstSubscriptionId = tostring(DstSubscriptionId), DstGeoCountry = tostring(DstGeoCountry), DstGeoRegion = tostring(DstGeoRegion), SrcGeoRegion = tostring(SrcGeoRegion), SrcGeoCity = tostring(SrcGeoCity), SrcGeoLatitude = toreal(SrcGeoLatitude), SrcGeoLongitude = toreal(SrcGeoLongitude), SrcAppName = tostring(SrcAppName), SrcAppId = tostring(SrcAppId), SrcAppType = tostring(SrcAppType), DstNatIpAddr = tostring(DstNatIpAddr), DstNatPortNumber = toint(DstNatPortNumber), SrcNatIpAddr = tostring(SrcNatIpAddr), SrcNatPortNumber = toint(SrcNatPortNumber), DvcInboundInterface = tostring(DvcInboundInterface), DvcOutboundInterface = tostring(DvcOutboundInterface), NetworkRuleName = tostring(NetworkRuleName), NetworkRuleNumber = toint(NetworkRuleNumber), SrcGeoCountry = tostring(SrcGeoCountry), ThreatName = tostring(ThreatName), SrcSubscriptionId = tostring(SrcSubscriptionId), SrcMacAddr = tostring(SrcMacAddr), DstGeoCity = tostring(DstGeoCity), DstGeoLatitude = toreal(DstGeoLatitude), DstGeoLongitude = toreal(DstGeoLongitude), DstUserId = tostring(DstUserId), DstUserIdType = tostring(DstUserIdType), DstUsername = tostring(DstUsername), DstUsernameType = tostring(DstUsernameType), DstUserType = tostring(DstUserType), DstOriginalUserType = tostring(DstOriginalUserType), DstAppName = tostring(DstAppName), DstAppId = tostring(DstAppId), DstAppType = tostring(DstAppType), SrcZone = tostring(SrcZone), SrcInterfaceName = tostring(SrcInterfaceName), SrcInterfaceGuid = tostring(SrcInterfaceGuid), SrcVlanId = tostring(SrcVlanId), IpAddr = tostring(IpAddr)'
        outputStream: 'Custom-CiscoMerakiNativePoller_CL'
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
