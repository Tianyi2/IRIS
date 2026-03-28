// Bicep template for Log Analytics custom table: ASimFileEventLogs
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 124, Deployed columns: 123 (Type column filtered)
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

resource asimfileeventlogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimFileEventLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimFileEventLogs'
      description: 'Custom table ASimFileEventLogs - imported from JSON schema'
      displayName: 'ASimFileEventLogs'
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
          name: 'SrcDvcScopeId'
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
          name: 'SrcRiskLevel'
          type: 'int'
        }
        {
          name: 'SrcPortNumber'
          type: 'int'
        }
        {
          name: 'SrcOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'NetworkApplicationProtocol'
          type: 'string'
        }
        {
          name: 'HttpUserAgent'
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
          name: 'SrcDvcScope'
          type: 'string'
        }
        {
          name: 'ActingProcessName'
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
          name: 'ActorUserSid'
          type: 'string'
        }
        {
          name: 'ActorUserAadId'
          type: 'string'
        }
        {
          name: 'SrcFileSize'
          type: 'long'
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
          name: 'ActingProcessCommandLine'
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
          name: 'SrcGeoCountry'
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
          name: 'TargetUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'TargetOriginalAppType'
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
          name: 'SrcFileSHA1'
          type: 'string'
        }
        {
          name: 'SrcFileMD5'
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
          name: 'SrcDomain'
          type: 'string'
        }
        {
          name: 'SrcMacAddr'
          type: 'string'
        }
        {
          name: 'SrcHostname'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ActorUserId'
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
          name: 'HashType'
          type: 'string'
        }
        {
          name: 'TargetFileName'
          type: 'string'
        }
        {
          name: 'DvcAction'
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
          name: 'EventResultDetails'
          type: 'string'
        }
        {
          name: 'ActorUsername'
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
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'AdditionalFields'
          type: 'dynamic'
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
          name: 'SrcFileDirectory'
          type: 'string'
        }
        {
          name: 'SrcFileCreationTime'
          type: 'dateTime'
        }
        {
          name: 'TargetFileSize'
          type: 'long'
        }
        {
          name: 'TargetFileSHA512'
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
          type: 'dateTime'
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
          name: 'DvcDescription'
          type: 'string'
        }
        {
          name: 'EventOwner'
          type: 'string'
        }
        {
          name: 'EventReportUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'EventProductVersion'
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
          name: 'EventSubType'
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

output tableName string = asimfileeventlogsTable.name
output tableId string = asimfileeventlogsTable.id
output provisioningState string = asimfileeventlogsTable.properties.provisioningState
