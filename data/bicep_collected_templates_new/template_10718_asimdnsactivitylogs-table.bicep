// Bicep template for Log Analytics custom table: ASimDnsActivityLogs
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 136, Deployed columns: 135 (Type column filtered)
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

resource asimdnsactivitylogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimDnsActivityLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimDnsActivityLogs'
      description: 'Custom table ASimDnsActivityLogs - imported from JSON schema'
      displayName: 'ASimDnsActivityLogs'
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
          name: 'EventProductVersion'
          type: 'string'
        }
        {
          name: 'EventOwner'
          type: 'string'
        }
        {
          name: 'DnsResponseIpRegion'
          type: 'string'
        }
        {
          name: 'DnsResponseIpCity'
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
          name: 'DvcFQDN'
          type: 'string'
        }
        {
          name: 'Dvc'
          type: 'string'
        }
        {
          name: 'EventSchemaVersion'
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
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'EventStartTime'
          type: 'dateTime'
        }
        {
          name: 'ThreatLastReportedTime_d'
          type: 'dateTime'
        }
        {
          name: 'ThreatLastReportedTime'
          type: 'string'
        }
        {
          name: 'ThreatFirstReportedTime_d'
          type: 'dateTime'
        }
        {
          name: 'ThreatFirstReportedTime'
          type: 'string'
        }
        {
          name: 'ThreatIsActive'
          type: 'boolean'
        }
        {
          name: 'ThreatOriginalRiskLevel'
          type: 'int'
        }
        {
          name: 'ThreatOriginalRiskLevel_s'
          type: 'string'
        }
        {
          name: 'ThreatRiskLevel'
          type: 'int'
        }
        {
          name: 'ThreatOriginalConfidence'
          type: 'string'
        }
        {
          name: 'ThreatConfidence'
          type: 'int'
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
          name: 'UrlCategory'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'Src'
          type: 'string'
        }
        {
          name: 'SrcHostname'
          type: 'string'
        }
        {
          name: 'SrcDomain'
          type: 'string'
        }
        {
          name: 'DnsFlagsTruncated'
          type: 'boolean'
        }
        {
          name: 'DnsFlagsRecursionAvailable'
          type: 'boolean'
        }
        {
          name: 'DnsFlagsCheckingDisabled'
          type: 'boolean'
        }
        {
          name: 'DnsFlags'
          type: 'string'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'DstDeviceType'
          type: 'string'
        }
        {
          name: 'DstDvcIdType'
          type: 'string'
        }
        {
          name: 'DstDvcScopeId'
          type: 'string'
        }
        {
          name: 'DstDvcId'
          type: 'string'
        }
        {
          name: 'DstFQDN'
          type: 'string'
        }
        {
          name: 'DstDomainType'
          type: 'string'
        }
        {
          name: 'DstDomain'
          type: 'string'
        }
        {
          name: 'DstHostname'
          type: 'string'
        }
        {
          name: 'DstPortNumber'
          type: 'int'
        }
        {
          name: 'ThreatField'
          type: 'string'
        }
        {
          name: 'Dst'
          type: 'string'
        }
        {
          name: 'SrcProcessId'
          type: 'string'
        }
        {
          name: 'SrcProcessName'
          type: 'string'
        }
        {
          name: 'SrcOriginalUserType'
          type: 'string'
        }
        {
          name: 'SrcUserType'
          type: 'string'
        }
        {
          name: 'SrcUsernameType'
          type: 'string'
        }
        {
          name: 'SrcUsername'
          type: 'string'
        }
        {
          name: 'SrcUserIdType'
          type: 'string'
        }
        {
          name: 'SrcUserId'
          type: 'string'
        }
        {
          name: 'SrcRiskLevel'
          type: 'int'
        }
        {
          name: 'SrcDeviceType'
          type: 'string'
        }
        {
          name: 'SrcDvcIdType'
          type: 'string'
        }
        {
          name: 'SrcDvcId'
          type: 'string'
        }
        {
          name: 'SrcFQDN'
          type: 'string'
        }
        {
          name: 'SrcDomainType'
          type: 'string'
        }
        {
          name: 'SrcProcessGuid'
          type: 'string'
        }
        {
          name: 'ThreatIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ThreatId'
          type: 'string'
        }
        {
          name: 'SrcUserSessionId'
          type: 'string'
        }
        {
          name: 'DnsQueryType'
          type: 'int'
        }
        {
          name: 'DnsQuery'
          type: 'string'
        }
        {
          name: 'DstGeoLongitude'
          type: 'real'
        }
        {
          name: 'DstGeoLatitude'
          type: 'real'
        }
        {
          name: 'DstGeoCity'
          type: 'string'
        }
        {
          name: 'DstGeoRegion'
          type: 'string'
        }
        {
          name: 'DstGeoCountry'
          type: 'string'
        }
        {
          name: 'DstIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcGeoLongitude'
          type: 'real'
        }
        {
          name: 'SrcGeoLatitude'
          type: 'real'
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
          name: 'SrcPortNumber'
          type: 'int'
        }
        {
          name: 'DnsQueryTypeName'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
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
          name: 'DvcHostname'
          type: 'string'
        }
        {
          name: 'DvcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventOriginalType'
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
          name: 'EventCount'
          type: 'int'
        }
        {
          name: 'AdditionalFields'
          type: 'dynamic'
        }
        {
          name: 'DnsFlagsZ'
          type: 'boolean'
        }
        {
          name: 'DnsResponseCode'
          type: 'int'
        }
        {
          name: 'TransactionIdHex'
          type: 'string'
        }
        {
          name: 'SrcUserScopeId'
          type: 'string'
        }
        {
          name: 'SrcUserScope'
          type: 'string'
        }
        {
          name: 'SrcOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'SrcDvcScopeId'
          type: 'string'
        }
        {
          name: 'SrcDvcScope'
          type: 'string'
        }
        {
          name: 'SrcDescription'
          type: 'string'
        }
        {
          name: 'DnsSessionId'
          type: 'string'
        }
        {
          name: 'DnsFlagsRecursionDesired'
          type: 'boolean'
        }
        {
          name: 'DnsFlagsAuthoritative'
          type: 'boolean'
        }
        {
          name: 'DnsFlagsAuthenticated'
          type: 'boolean'
        }
        {
          name: 'DnsNetworkDuration'
          type: 'int'
        }
        {
          name: 'DnsQueryClassName'
          type: 'string'
        }
        {
          name: 'DnsQueryClass'
          type: 'int'
        }
        {
          name: 'NetworkProtocol'
          type: 'string'
        }
        {
          name: 'DnsResponseName'
          type: 'string'
        }
        {
          name: 'DnsResponseIpLongitude'
          type: 'real'
        }
        {
          name: 'DnsResponseIpCountry'
          type: 'string'
        }
        {
          name: 'RuleNumber'
          type: 'int'
        }
        {
          name: 'RuleName'
          type: 'string'
        }
        {
          name: 'NetworkProtocolVersion'
          type: 'string'
        }
        {
          name: 'EventOriginalSeverity'
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
          name: 'DvcOriginalAction'
          type: 'string'
        }
        {
          name: 'DvcInterface'
          type: 'string'
        }
        {
          name: 'DvcDescription'
          type: 'string'
        }
        {
          name: 'DstRiskLevel'
          type: 'int'
        }
        {
          name: 'DstOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'DstDvcScope'
          type: 'string'
        }
        {
          name: 'DstDescription'
          type: 'string'
        }
        {
          name: 'DnsResponseIpLatitude'
          type: 'real'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = asimdnsactivitylogsTable.name
output tableId string = asimdnsactivitylogsTable.id
output provisioningState string = asimdnsactivitylogsTable.properties.provisioningState
