// Bicep template for Log Analytics custom table: ASimDhcpEventLogs
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 97, Deployed columns: 96 (Type column filtered)
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

resource asimdhcpeventlogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimDhcpEventLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimDhcpEventLogs'
      description: 'Custom table ASimDhcpEventLogs - imported from JSON schema'
      displayName: 'ASimDhcpEventLogs'
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
          name: 'SrcUserUid'
          type: 'string'
        }
        {
          name: 'SrcUserType'
          type: 'string'
        }
        {
          name: 'SrcUserSessionId'
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
          name: 'SrcGeoCountry'
          type: 'string'
        }
        {
          name: 'SrcPortNumber'
          type: 'int'
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
          name: 'SrcDvcScopeId'
          type: 'string'
        }
        {
          name: 'SrcDvcScope'
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
          name: 'SrcDomainType'
          type: 'string'
        }
        {
          name: 'SrcDeviceType'
          type: 'string'
        }
        {
          name: 'RequestedIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcOriginalUserType'
          type: 'string'
        }
        {
          name: 'EventSubType'
          type: 'string'
        }
        {
          name: 'SrcGeoLatitude'
          type: 'real'
        }
        {
          name: 'SrcGeoRegion'
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
          name: 'EventSchemaVersion'
          type: 'string'
        }
        {
          name: 'EventSchema'
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
          name: 'ThreatIsActive'
          type: 'boolean'
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
          name: 'SrcGeoLongitude'
          type: 'real'
        }
        {
          name: 'ThreatField'
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
          name: 'ThreatOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'AdditionalFields'
          type: 'dynamic'
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
          name: 'DvcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'EventResultDetails'
          type: 'string'
        }
        {
          name: 'DhcpVendorClassId'
          type: 'string'
        }
        {
          name: 'DhcpVendorClass'
          type: 'string'
        }
        {
          name: 'DhcpUserClassId'
          type: 'string'
        }
        {
          name: 'DhcpUserClass'
          type: 'string'
        }
        {
          name: 'DhcpSubscriberId'
          type: 'string'
        }
        {
          name: 'DhcpSrcDHCId'
          type: 'string'
        }
        {
          name: 'DhcpSessionId'
          type: 'string'
        }
        {
          name: 'DvcHostname'
          type: 'string'
        }
        {
          name: 'DhcpSessionDuration'
          type: 'int'
        }
        {
          name: 'DhcpCircuitId'
          type: 'string'
        }
        {
          name: 'SrcMacAddr'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcHostname'
          type: 'string'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'EventResult'
          type: 'string'
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
          name: 'DhcpLeaseDuration'
          type: 'int'
        }
        {
          name: 'EventProductVersion'
          type: 'string'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'DvcDomain'
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
          name: 'EventOriginalSeverity'
          type: 'string'
        }
        {
          name: 'EventOriginalResultDetails'
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
          name: 'SrcDomain'
          type: 'string'
        }
        {
          name: 'DvcZone'
          type: 'string'
        }
        {
          name: 'DvcDescription'
          type: 'string'
        }
        {
          name: 'DvcScopeId'
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
          name: 'DvcOriginalAction'
          type: 'string'
        }
        {
          name: 'DvcMacAddr'
          type: 'string'
        }
        {
          name: 'DvcInterface'
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
          name: 'DvcDomainType'
          type: 'string'
        }
        {
          name: 'DvcScope'
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

output tableName string = asimdhcpeventlogsTable.name
output tableId string = asimdhcpeventlogsTable.id
output provisioningState string = asimdhcpeventlogsTable.properties.provisioningState
