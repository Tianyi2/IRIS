// Bicep template for Log Analytics custom table: CiscoMerakiNativePoller_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 150, Deployed columns: 150 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource ciscomerakinativepollerclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CiscoMerakiNativePoller_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CiscoMerakiNativePoller_CL'
      description: 'Custom table CiscoMerakiNativePoller_CL - imported from JSON schema'
      displayName: 'CiscoMerakiNativePoller_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventCount'
          type: 'int'
        }
        {
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'EventReportUrl'
          type: 'string'
          dataTypeHint: 0
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
          dataTypeHint: 3
        }
        {
          name: 'SrcPortNumber'
          type: 'int'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
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
          dataTypeHint: 3
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
          type: 'int'
        }
        {
          name: 'HttpResponseTime'
          type: 'int'
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
          type: 'int'
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
          type: 'int'
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
          type: 'int'
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
          type: 'int'
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
          dataTypeHint: 0
        }
        {
          name: 'UrlCategory'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'UrlOriginal'
          type: 'string'
          dataTypeHint: 0
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
          type: 'int'
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
          type: 'int'
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
          type: 'long'
        }
        {
          name: 'SrcBytes'
          type: 'long'
        }
        {
          name: 'NetworkBytes'
          type: 'long'
        }
        {
          name: 'NetworkDirection'
          type: 'string'
        }
        {
          name: 'DstPackets'
          type: 'long'
        }
        {
          name: 'NetworkPackets'
          type: 'long'
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
          type: 'long'
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
          type: 'dateTime'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
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
          type: 'real'
        }
        {
          name: 'SrcGeoLongitude'
          type: 'real'
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
          dataTypeHint: 3
        }
        {
          name: 'DstNatPortNumber'
          type: 'int'
        }
        {
          name: 'SrcNatIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcNatPortNumber'
          type: 'int'
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
          type: 'int'
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
          type: 'real'
        }
        {
          name: 'DstGeoLongitude'
          type: 'real'
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
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = ciscomerakinativepollerclTable.name
output tableId string = ciscomerakinativepollerclTable.id
output provisioningState string = ciscomerakinativepollerclTable.properties.provisioningState
