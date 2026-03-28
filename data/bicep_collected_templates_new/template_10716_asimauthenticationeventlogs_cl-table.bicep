// Bicep template for Log Analytics custom table: ASimAuthenticationEventLogs_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 122, Deployed columns: 122 (Type column filtered)
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

resource asimauthenticationeventlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimAuthenticationEventLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimAuthenticationEventLogs_CL'
      description: 'Custom table ASimAuthenticationEventLogs_CL - imported from JSON schema'
      displayName: 'ASimAuthenticationEventLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'AdditionalFields'
          type: 'dynamic'
        }
        {
          name: 'SrcDvcScopeId'
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
          name: 'SrcDescription'
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
          name: 'SrcDomain'
          type: 'string'
        }
        {
          name: 'SrcHostname'
          type: 'string'
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
          name: 'TargetUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'TargetAppType'
          type: 'string'
        }
        {
          name: 'SrcDvcScope'
          type: 'string'
        }
        {
          name: 'TargetAppName'
          type: 'string'
        }
        {
          name: 'TargetSessionId'
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
          name: 'HttpUserAgent'
          type: 'string'
        }
        {
          name: 'ActingAppType'
          type: 'string'
        }
        {
          name: 'ActingAppName'
          type: 'string'
        }
        {
          name: 'TargetAppId'
          type: 'string'
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
          name: 'SrcGeoLatitude'
          type: 'real'
        }
        {
          name: 'TargetDvcOs'
          type: 'string'
        }
        {
          name: 'TargetOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'TargetRiskLevel'
          type: 'int'
        }
        {
          name: 'TargetGeoCity'
          type: 'string'
        }
        {
          name: 'TargetGeoRegion'
          type: 'string'
        }
        {
          name: 'TargetGeoLongitude'
          type: 'real'
        }
        {
          name: 'TargetGeoLatitude'
          type: 'real'
        }
        {
          name: 'TargetGeoCountry'
          type: 'string'
        }
        {
          name: 'TargetDeviceType'
          type: 'string'
        }
        {
          name: 'TargetDvcScope'
          type: 'string'
        }
        {
          name: 'TargetDvcScopeId'
          type: 'string'
        }
        {
          name: 'TargetDvcIdType'
          type: 'string'
        }
        {
          name: 'TargetDvcId'
          type: 'string'
        }
        {
          name: 'TargetDescription'
          type: 'string'
        }
        {
          name: 'TargetFQDN'
          type: 'string'
        }
        {
          name: 'TargetDomainType'
          type: 'string'
        }
        {
          name: 'TargetDomain'
          type: 'string'
        }
        {
          name: 'TargetHostname'
          type: 'string'
        }
        {
          name: 'TargetPortNumber'
          type: 'int'
        }
        {
          name: 'TargetIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcDvcOs'
          type: 'string'
        }
        {
          name: 'SrcIsp'
          type: 'string'
        }
        {
          name: 'SrcOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'SrcRiskLevel'
          type: 'int'
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
          name: 'SrcGeoLongitude'
          type: 'real'
        }
        {
          name: 'ActingAppId'
          type: 'string'
        }
        {
          name: 'LogonMethod'
          type: 'string'
        }
        {
          name: 'ActorSessionId'
          type: 'string'
        }
        {
          name: 'ActorUserType'
          type: 'string'
        }
        {
          name: 'ThreatRiskLevel'
          type: 'int'
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
          type: 'int'
        }
        {
          name: 'RuleName'
          type: 'string'
        }
        {
          name: 'EventReportUrl'
          type: 'string'
          dataTypeHint: 0
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
          name: 'ThreatOriginalRiskLevel'
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
          type: 'dateTime'
        }
        {
          name: 'EventStartTime'
          type: 'dateTime'
        }
        {
          name: 'EventCount'
          type: 'int'
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
          name: 'ThreatConfidence'
          type: 'int'
        }
        {
          name: 'ThreatOriginalConfidence'
          type: 'string'
        }
        {
          name: 'ThreatIsActive'
          type: 'boolean'
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
          dataTypeHint: 3
        }
        {
          name: 'ThreatIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ThreatField'
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
          name: 'ActorOriginalUserType'
          type: 'string'
        }
        {
          name: 'LogonProtocol'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = asimauthenticationeventlogsclTable.name
output tableId string = asimauthenticationeventlogsclTable.id
output provisioningState string = asimauthenticationeventlogsclTable.properties.provisioningState
