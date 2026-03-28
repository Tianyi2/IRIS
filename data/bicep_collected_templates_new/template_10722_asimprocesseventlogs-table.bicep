// Bicep template for Log Analytics custom table: ASimProcessEventLogs
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 137, Deployed columns: 136 (Type column filtered)
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

resource asimprocesseventlogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimProcessEventLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimProcessEventLogs'
      description: 'Custom table ASimProcessEventLogs - imported from JSON schema'
      displayName: 'ASimProcessEventLogs'
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
          name: 'TargetProcessName'
          type: 'string'
        }
        {
          name: 'TargetProcessCommandLine'
          type: 'string'
        }
        {
          name: 'ParentProcessTokenElevation'
          type: 'string'
        }
        {
          name: 'ParentProcessCreationTime'
          type: 'dateTime'
        }
        {
          name: 'ParentProcessIMPHASH'
          type: 'string'
        }
        {
          name: 'ParentProcessSHA512'
          type: 'string'
        }
        {
          name: 'ParentProcessSHA256'
          type: 'string'
        }
        {
          name: 'ParentProcessSHA1'
          type: 'string'
        }
        {
          name: 'ParentProcessMD5'
          type: 'string'
        }
        {
          name: 'ParentProcessIntegrityLevel'
          type: 'string'
        }
        {
          name: 'ParentProcessGuid'
          type: 'string'
        }
        {
          name: 'ParentProcessId'
          type: 'string'
        }
        {
          name: 'ParentProcessInjectedAddress'
          type: 'string'
        }
        {
          name: 'ParentProcessIsHidden'
          type: 'boolean'
        }
        {
          name: 'TargetProcessFileCompany'
          type: 'string'
        }
        {
          name: 'ParentProcessFileVersion'
          type: 'string'
        }
        {
          name: 'ParentProcessFileDescription'
          type: 'string'
        }
        {
          name: 'ParentProcessFileCompany'
          type: 'string'
        }
        {
          name: 'ParentProcessName'
          type: 'string'
        }
        {
          name: 'ActingProcessFileSize'
          type: 'long'
        }
        {
          name: 'ActingProcessTokenElevation'
          type: 'string'
        }
        {
          name: 'ActingProcessCreationTime'
          type: 'dateTime'
        }
        {
          name: 'ActingProcessIMPHASH'
          type: 'string'
        }
        {
          name: 'ActingProcessSHA512'
          type: 'string'
        }
        {
          name: 'ActingProcessSHA256'
          type: 'string'
        }
        {
          name: 'ActingProcessSHA1'
          type: 'string'
        }
        {
          name: 'ActingProcessMD5'
          type: 'string'
        }
        {
          name: 'ActingProcessIntegrityLevel'
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
          name: 'ParentProcessFileProduct'
          type: 'string'
        }
        {
          name: 'ActingProcessInjectedAddress'
          type: 'string'
        }
        {
          name: 'TargetProcessFileDescription'
          type: 'string'
        }
        {
          name: 'TargetProcessFileVersion'
          type: 'string'
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
          name: 'TargetProcessStatusCode'
          type: 'string'
        }
        {
          name: 'TargetProcessCurrentDirectory'
          type: 'string'
        }
        {
          name: 'TargetProcessFileProduct'
          type: 'string'
        }
        {
          name: 'TargetProcessFileSize'
          type: 'long'
        }
        {
          name: 'TargetProcessCreationTime'
          type: 'dateTime'
        }
        {
          name: 'TargetProcessIMPHASH'
          type: 'string'
        }
        {
          name: 'TargetProcessSHA512'
          type: 'string'
        }
        {
          name: 'TargetProcessSHA256'
          type: 'string'
        }
        {
          name: 'TargetProcessSHA1'
          type: 'string'
        }
        {
          name: 'TargetProcessMD5'
          type: 'string'
        }
        {
          name: 'TargetProcessIntegrityLevel'
          type: 'string'
        }
        {
          name: 'TargetProcessGuid'
          type: 'string'
        }
        {
          name: 'TargetProcessId'
          type: 'string'
        }
        {
          name: 'TargetProcessInjectedAddress'
          type: 'string'
        }
        {
          name: 'TargetProcessIsHidden'
          type: 'boolean'
        }
        {
          name: 'TargetProcessFilename'
          type: 'string'
        }
        {
          name: 'TargetProcessFileOriginalName'
          type: 'string'
        }
        {
          name: 'TargetProcessFileInternalName'
          type: 'string'
        }
        {
          name: 'TargetProcessTokenElevation'
          type: 'string'
        }
        {
          name: 'ThreatLastReportedTime'
          type: 'dateTime'
        }
        {
          name: 'ActingProcessIsHidden'
          type: 'boolean'
        }
        {
          name: 'ActingProcessFileOriginalName'
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
          name: 'DvcZone'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventSeverity'
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
          name: 'AdditionalFields'
          type: 'dynamic'
        }
        {
          name: 'EventOriginalSeverity'
          type: 'string'
        }
        {
          name: 'ActingProcessFilename'
          type: 'string'
        }
        {
          name: 'DvcOs'
          type: 'string'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'ActingProcessFileInternalName'
          type: 'string'
        }
        {
          name: 'ActingProcessFileVersion'
          type: 'string'
        }
        {
          name: 'ActingProcessFileProduct'
          type: 'string'
        }
        {
          name: 'ActingProcessFileDescription'
          type: 'string'
        }
        {
          name: 'ActingProcessFileCompany'
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
          name: 'TargetUserSessionGuid'
          type: 'string'
        }
        {
          name: 'TargetUserSessionId'
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
          name: 'DvcOsVersion'
          type: 'string'
        }
        {
          name: 'TargetScopeId'
          type: 'string'
        }
        {
          name: 'TargetUserId'
          type: 'string'
        }
        {
          name: 'ActorSessionId'
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
          name: 'TargetUserIdType'
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

output tableName string = asimprocesseventlogsTable.name
output tableId string = asimprocesseventlogsTable.id
output provisioningState string = asimprocesseventlogsTable.properties.provisioningState
