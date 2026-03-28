// Bicep template for Log Analytics custom table: ASimWebSessionLogs
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 146, Deployed columns: 145 (Type column filtered)
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

resource asimwebsessionlogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimWebSessionLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimWebSessionLogs'
      description: 'Custom table ASimWebSessionLogs - imported from JSON schema'
      displayName: 'ASimWebSessionLogs'
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
          name: 'SrcDeviceType'
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
          name: 'SrcGeoLongitude'
          type: 'real'
        }
        {
          name: 'SrcDvcIdType'
          type: 'string'
        }
        {
          name: 'SrcUserId'
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
          name: 'SrcOriginalUserType'
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
          name: 'SrcUserIdType'
          type: 'string'
        }
        {
          name: 'UrlOriginal'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'SrcDvcId'
          type: 'string'
        }
        {
          name: 'SrcDomainType'
          type: 'string'
        }
        {
          name: 'ThreatIsActive'
          type: 'boolean'
        }
        {
          name: 'ThreatFirstReportedTime'
          type: 'dateTime'
        }
        {
          name: 'ThreatLastReportedTime'
          type: 'dateTime'
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
          name: 'SrcFQDN'
          type: 'string'
        }
        {
          name: 'SrcNatPortNumber'
          type: 'int'
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
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcPortNumber'
          type: 'int'
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
          name: 'SrcAppName'
          type: 'string'
        }
        {
          name: 'ThreatOriginalConfidence'
          type: 'string'
        }
        {
          name: 'HttpVersion'
          type: 'string'
        }
        {
          name: 'HttpContentType'
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
          name: 'HttpHost'
          type: 'string'
        }
        {
          name: 'EventOwner'
          type: 'string'
        }
        {
          name: 'SrcProcessName'
          type: 'string'
        }
        {
          name: 'SrcProcessId'
          type: 'string'
        }
        {
          name: 'ThreatName'
          type: 'string'
        }
        {
          name: 'SrcProcessGuid'
          type: 'string'
        }
        {
          name: 'SrcUserScopeId'
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
          name: 'DstDvcScopeId'
          type: 'string'
        }
        {
          name: 'DstDvcScope'
          type: 'string'
        }
        {
          name: 'SrcMacAddr'
          type: 'string'
        }
        {
          name: 'SrcUserScope'
          type: 'string'
        }
        {
          name: 'HttpRequestMethod'
          type: 'string'
        }
        {
          name: 'ThreatId'
          type: 'string'
        }
        {
          name: 'RuleNumber'
          type: 'int'
        }
        {
          name: 'HttpContentFormat'
          type: 'string'
        }
        {
          name: 'HttpReferrer'
          type: 'string'
        }
        {
          name: 'HttpUserAgent'
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
          name: 'Rule'
          type: 'string'
        }
        {
          name: 'FileName'
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
          name: 'FileMD5'
          type: 'string'
        }
        {
          name: 'ThreatConfidence'
          type: 'int'
        }
        {
          name: 'ThreatField'
          type: 'string'
        }
        {
          name: 'ThreatIpAddr'
          type: 'string'
          dataTypeHint: 3
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
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'EventOriginalSeverity'
          type: 'string'
        }
        {
          name: 'EventResultDetails'
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
          name: 'EventSchemaVersion'
          type: 'string'
        }
        {
          name: 'EventReportUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'AdditionalFields'
          type: 'dynamic'
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
          name: 'EventProductVersion'
          type: 'string'
        }
        {
          name: 'DstAppType'
          type: 'string'
        }
        {
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'Dvc'
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
          name: 'DvcFQDN'
          type: 'string'
        }
        {
          name: 'EventSubType'
          type: 'string'
        }
        {
          name: 'DvcId'
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
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'EventCount'
          type: 'int'
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
          name: 'DvcIdType'
          type: 'string'
        }
        {
          name: 'DstIpAddr'
          type: 'string'
          dataTypeHint: 3
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
          name: 'NetworkProtocolVersion'
          type: 'string'
        }
        {
          name: 'NetworkDirection'
          type: 'string'
        }
        {
          name: 'NetworkDuration'
          type: 'int'
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
          name: 'NetworkConnectionHistory'
          type: 'string'
        }
        {
          name: 'NetworkProtocol'
          type: 'string'
        }
        {
          name: 'DstBytes'
          type: 'long'
        }
        {
          name: 'NetworkBytes'
          type: 'long'
        }
        {
          name: 'DstPackets'
          type: 'long'
        }
        {
          name: 'SrcPackets'
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
          name: 'ThreatOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'SrcBytes'
          type: 'long'
        }
        {
          name: 'NetworkApplicationProtocol'
          type: 'string'
        }
        {
          name: 'DstOriginalUserType'
          type: 'string'
        }
        {
          name: 'DstUserType'
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
          name: 'DstMacAddr'
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

output tableName string = asimwebsessionlogsTable.name
output tableId string = asimwebsessionlogsTable.id
output provisioningState string = asimwebsessionlogsTable.properties.provisioningState
