// Bicep template for Log Analytics custom table: ASimNetworkSessionLogs
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 142, Deployed columns: 141 (Type column filtered)
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

resource asimnetworksessionlogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimNetworkSessionLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimNetworkSessionLogs'
      description: 'Custom table ASimNetworkSessionLogs - imported from JSON schema'
      displayName: 'ASimNetworkSessionLogs'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'SrcDomainType'
          type: 'string'
        }
        {
          name: 'SrcDomain'
          type: 'string'
        }
        {
          name: 'SrcHostname'
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
          name: 'DvcFQDN'
          type: 'string'
        }
        {
          name: 'EventReportUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'NetworkProtocol'
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
          name: 'AdditionalFields'
          type: 'dynamic'
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
          name: 'DvcDomainType'
          type: 'string'
        }
        {
          name: 'DvcDomain'
          type: 'string'
        }
        {
          name: 'ThreatId'
          type: 'string'
        }
        {
          name: 'ThreatName'
          type: 'string'
        }
        {
          name: 'ThreatCategory'
          type: 'string'
        }
        {
          name: 'ThreatRiskLevel'
          type: 'int'
        }
        {
          name: 'ThreatOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'SrcFQDN'
          type: 'string'
        }
        {
          name: 'EventSubType'
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
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'NetworkRuleNumber'
          type: 'int'
        }
        {
          name: 'SrcDvcId'
          type: 'string'
        }
        {
          name: 'ThreatIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'DstDescription'
          type: 'string'
        }
        {
          name: 'ThreatOriginalConfidence'
          type: 'string'
        }
        {
          name: 'ThreatLastReportedTime'
          type: 'dateTime'
        }
        {
          name: 'ThreatFirstReportedTime'
          type: 'dateTime'
        }
        {
          name: 'EventOriginalResultDetails'
          type: 'string'
        }
        {
          name: 'DvcDescription'
          type: 'string'
        }
        {
          name: 'NetworkDuration'
          type: 'int'
        }
        {
          name: 'ThreatConfidence'
          type: 'int'
        }
        {
          name: 'ThreatIsActive'
          type: 'boolean'
        }
        {
          name: 'ThreatField'
          type: 'string'
        }
        {
          name: 'TcpFlagsSyn'
          type: 'boolean'
        }
        {
          name: 'TcpFlagsUrg'
          type: 'boolean'
        }
        {
          name: 'TcpFlagsRst'
          type: 'boolean'
        }
        {
          name: 'TcpFlagsPsh'
          type: 'boolean'
        }
        {
          name: 'TcpFlagsFin'
          type: 'boolean'
        }
        {
          name: 'TcpFlagsAck'
          type: 'boolean'
        }
        {
          name: 'DstDeviceType'
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
          name: 'SrcDvcIdType'
          type: 'string'
        }
        {
          name: 'SrcOriginalUserType'
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
          name: 'DstPortNumber'
          type: 'int'
        }
        {
          name: 'NetworkRuleName'
          type: 'string'
        }
        {
          name: 'DvcOutboundInterface'
          type: 'string'
        }
        {
          name: 'DvcInboundInterface'
          type: 'string'
        }
        {
          name: 'DstInterfaceName'
          type: 'string'
        }
        {
          name: 'DstZone'
          type: 'string'
        }
        {
          name: 'NetworkSessionId'
          type: 'string'
        }
        {
          name: 'NetworkPackets'
          type: 'long'
        }
        {
          name: 'SrcPackets'
          type: 'long'
        }
        {
          name: 'DstPackets'
          type: 'long'
        }
        {
          name: 'NetworkBytes'
          type: 'long'
        }
        {
          name: 'SrcBytes'
          type: 'long'
        }
        {
          name: 'DstBytes'
          type: 'long'
        }
        {
          name: 'NetworkConnectionHistory'
          type: 'string'
        }
        {
          name: 'NetworkIcmpType'
          type: 'string'
        }
        {
          name: 'NetworkIcmpCode'
          type: 'int'
        }
        {
          name: 'NetworkDirection'
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
          name: 'EventOriginalSeverity'
          type: 'string'
        }
        {
          name: 'EventCount'
          type: 'int'
        }
        {
          name: 'EventSchemaVersion'
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
          name: 'DstInterfaceGuid'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
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
          name: 'DvcMacAddr'
          type: 'string'
        }
        {
          name: 'DstMacAddr'
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
          name: 'SrcVlanId'
          type: 'string'
        }
        {
          name: 'SrcSubscriptionId'
          type: 'string'
        }
        {
          name: 'SrcGeoCountry'
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
          name: 'SrcMacAddr'
          type: 'string'
        }
        {
          name: 'SrcGeoLongitude'
          type: 'real'
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
          name: 'SrcAppName'
          type: 'string'
        }
        {
          name: 'SrcDescription'
          type: 'string'
        }
        {
          name: 'SrcInterfaceGuid'
          type: 'string'
        }
        {
          name: 'SrcZone'
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
          name: 'SrcInterfaceName'
          type: 'string'
        }
        {
          name: 'DstUserIdType'
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
          name: 'DstUsername'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = asimnetworksessionlogsTable.name
output tableId string = asimnetworksessionlogsTable.id
output provisioningState string = asimnetworksessionlogsTable.properties.provisioningState
