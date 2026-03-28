// Bicep template for Log Analytics custom table: CrowdstrikeReplicatorLogs_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 46, Deployed columns: 44 (Type column filtered)
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

resource crowdstrikereplicatorlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CrowdstrikeReplicatorLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CrowdstrikeReplicatorLogs_CL'
      description: 'Custom table CrowdstrikeReplicatorLogs_CL - imported from JSON schema'
      displayName: 'CrowdstrikeReplicatorLogs_CL'
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
          name: 'RawProcessId'
          type: 'string'
        }
        {
          name: 'ConfigStateHash'
          type: 'string'
        }
        {
          name: 'MD5HashData'
          type: 'string'
        }
        {
          name: 'SHA256HashData'
          type: 'string'
        }
        {
          name: 'ProcessSxsFlags'
          type: 'string'
        }
        {
          name: 'AuthenticationId'
          type: 'string'
        }
        {
          name: 'ConfigBuild'
          type: 'string'
        }
        {
          name: 'WindowFlags'
          type: 'real'
        }
        {
          name: 'event_simpleName'
          type: 'string'
        }
        {
          name: 'CommandLine'
          type: 'string'
        }
        {
          name: 'TargetProcessId'
          type: 'string'
        }
        {
          name: 'ImageFileName'
          type: 'string'
        }
        {
          name: 'SourceThreadId'
          type: 'string'
        }
        {
          name: 'Entitlements'
          type: 'string'
        }
        {
          name: 'name'
          type: 'string'
        }
        {
          name: 'ProcessStartTime'
          type: 'string'
        }
        {
          name: 'ProcessParameterFlags'
          type: 'string'
        }
        {
          name: 'aid'
          type: 'string'
        }
        {
          name: 'ParentAuthenticationId'
          type: 'string'
        }
        {
          name: 'SignInfoFlags'
          type: 'string'
        }
        {
          name: 'timestamp'
          type: 'string'
        }
        {
          name: 'SessionId'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ProcessCreateFlags'
          type: 'string'
        }
        {
          name: 'IntegrityLevel'
          type: 'real'
        }
        {
          name: 'ParentProcessId'
          type: 'string'
        }
        {
          name: 'SourceProcessId'
          type: 'string'
        }
        {
          name: 'aip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SHA1HashData'
          type: 'string'
        }
        {
          name: 'Tags'
          type: 'string'
        }
        {
          name: 'UserSid'
          type: 'string'
        }
        {
          name: 'TokenType'
          type: 'real'
        }
        {
          name: 'ProcessEndTime'
          type: 'string'
        }
        {
          name: 'AuthenticodeHashData'
          type: 'string'
        }
        {
          name: 'ParentBaseFileName'
          type: 'string'
        }
        {
          name: 'RpcClientProcessId'
          type: 'string'
        }
        {
          name: 'ImageSubsystem'
          type: 'string'
        }
        {
          name: 'id'
          type: 'string'
        }
        {
          name: 'EffectiveTransmissionClass'
          type: 'real'
        }
        {
          name: 'event_platform'
          type: 'string'
        }
        {
          name: 'cid'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = crowdstrikereplicatorlogsclTable.name
output tableId string = crowdstrikereplicatorlogsclTable.id
output provisioningState string = crowdstrikereplicatorlogsclTable.properties.provisioningState
