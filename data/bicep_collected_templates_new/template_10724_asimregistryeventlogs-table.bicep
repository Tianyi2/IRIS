// Bicep template for Log Analytics custom table: ASimRegistryEventLogs
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 83, Deployed columns: 82 (Type column filtered)
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

resource asimregistryeventlogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimRegistryEventLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimRegistryEventLogs'
      description: 'Custom table ASimRegistryEventLogs - imported from JSON schema'
      displayName: 'ASimRegistryEventLogs'
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
          name: 'ActingProcessGuid'
          type: 'string'
        }
        {
          name: 'ActingProcessCommandLine'
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
          name: 'ParentProcessName'
          type: 'string'
        }
        {
          name: 'ActorUsernameType'
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
          name: 'ActorUserSid'
          type: 'string'
        }
        {
          name: 'ActorUserAadId'
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
          name: 'ActorUsername'
          type: 'string'
        }
        {
          name: 'ParentProcessId'
          type: 'string'
        }
        {
          name: 'ParentProcessCommandLine'
          type: 'string'
        }
        {
          name: 'ParentProcessGuid'
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
          name: 'DvcOriginalAction'
          type: 'string'
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
          name: 'DvcZone'
          type: 'string'
        }
        {
          name: 'EventResultDetails'
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
          name: 'RegistryPreviousValueData'
          type: 'string'
        }
        {
          name: 'RegistryPreviousValueType'
          type: 'string'
        }
        {
          name: 'RegistryPreviousValue'
          type: 'string'
        }
        {
          name: 'RegistryPreviousKey'
          type: 'string'
        }
        {
          name: 'DvcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'RegistryValueData'
          type: 'string'
        }
        {
          name: 'RegistryValue'
          type: 'string'
        }
        {
          name: 'RegistryKey'
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
          name: 'RegistryValueType'
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
          name: 'DvcMacAddr'
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
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'EventSubType'
          type: 'string'
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
          name: 'DvcDescription'
          type: 'string'
        }
        {
          name: 'DvcFQDN'
          type: 'string'
        }
        {
          name: 'DvcOs'
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

output tableName string = asimregistryeventlogsTable.name
output tableId string = asimregistryeventlogsTable.id
output provisioningState string = asimregistryeventlogsTable.properties.provisioningState
