// Bicep template for Log Analytics custom table: ASimFileEventLogs_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 106, Deployed columns: 106 (Type column filtered)
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

resource asimfileeventlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimFileEventLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimFileEventLogs_CL'
      description: 'Custom table ASimFileEventLogs_CL - imported from JSON schema'
      displayName: 'ASimFileEventLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
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
          type: 'long'
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
          dataTypeHint: 3
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
          name: 'SrcGeoCountry'
          type: 'string'
        }
        {
          name: 'SrcFileCreationTime'
          type: 'dateTime'
        }
        {
          name: 'DvcSubscriptionId'
          type: 'string'
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
          name: 'DvcIpAddr'
          type: 'string'
          dataTypeHint: 3
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
          dataTypeHint: 0
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
          type: 'dateTime'
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
}

output tableName string = asimfileeventlogsclTable.name
output tableId string = asimfileeventlogsclTable.id
output provisioningState string = asimfileeventlogsclTable.properties.provisioningState
