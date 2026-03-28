// Bicep template for Log Analytics custom table: ASimRegistryEventLogs_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 60, Deployed columns: 60 (Type column filtered)
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

resource asimregistryeventlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimRegistryEventLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimRegistryEventLogs_CL'
      description: 'Custom table ASimRegistryEventLogs_CL - imported from JSON schema'
      displayName: 'ASimRegistryEventLogs_CL'
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
          name: 'DvcOs'
          type: 'string'
        }
        {
          name: 'DvcOsVersion'
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
          name: 'DvcInterface'
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
          name: 'ActorUserId'
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
          name: 'ActorUsername'
          type: 'string'
        }
        {
          name: 'DvcZone'
          type: 'string'
        }
        {
          name: 'ActorUsernameType'
          type: 'string'
        }
        {
          name: 'ActingProcessName'
          type: 'string'
        }
        {
          name: 'ActingProcessId'
          type: 'string'
        }
        {
          name: 'ActingProcessGuid'
          type: 'string'
        }
        {
          name: 'ParentProcessName'
          type: 'string'
        }
        {
          name: 'ParentProcessId'
          type: 'string'
        }
        {
          name: 'ParentProcessGuid'
          type: 'string'
        }
        {
          name: 'RegistryKey'
          type: 'string'
        }
        {
          name: 'RegistryValue'
          type: 'string'
        }
        {
          name: 'RegistryValueType'
          type: 'string'
        }
        {
          name: 'RegistryValueData'
          type: 'string'
        }
        {
          name: 'RegistryPreviousKey'
          type: 'string'
        }
        {
          name: 'RegistryPreviousValue'
          type: 'string'
        }
        {
          name: 'ActorSessionId'
          type: 'string'
        }
        {
          name: 'RegistryPreviousValueType'
          type: 'string'
        }
        {
          name: 'DvcMacAddr'
          type: 'string'
        }
        {
          name: 'DvcId'
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
          name: 'DvcIdType'
          type: 'string'
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventProductVersion'
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
          name: 'EventOwner'
          type: 'string'
        }
        {
          name: 'EventReportUrl'
          type: 'string'
          dataTypeHint: 0
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
          name: 'DvcDescription'
          type: 'string'
        }
        {
          name: 'EventOriginalSeverity'
          type: 'string'
        }
        {
          name: 'RegistryPreviousValueData'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = asimregistryeventlogsclTable.name
output tableId string = asimregistryeventlogsclTable.id
output provisioningState string = asimregistryeventlogsclTable.properties.provisioningState
