// Bicep template for Log Analytics custom table: CarbonBlackAuditLogs_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 27, Deployed columns: 24 (Type column filtered)
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

resource carbonblackauditlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CarbonBlackAuditLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CarbonBlackAuditLogs_CL'
      description: 'Custom table CarbonBlackAuditLogs_CL - imported from JSON schema'
      displayName: 'CarbonBlackAuditLogs_CL'
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
          name: 'eventTime_d'
          type: 'real'
        }
        {
          name: 'eventId_g'
          type: 'string'
        }
        {
          name: 'requestUrl_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'verbose_b'
          type: 'boolean'
        }
        {
          name: 'flagged_b'
          type: 'boolean'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'requestUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'description'
          type: 'string'
        }
        {
          name: 'orgName_s'
          type: 'string'
        }
        {
          name: 'clientIp'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'orgName'
          type: 'string'
        }
        {
          name: 'loginName_s'
          type: 'string'
        }
        {
          name: 'eventId'
          type: 'string'
        }
        {
          name: 'eventTime'
          type: 'real'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'flagged'
          type: 'boolean'
        }
        {
          name: 'clientIp_s'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = carbonblackauditlogsclTable.name
output tableId string = carbonblackauditlogsclTable.id
output provisioningState string = carbonblackauditlogsclTable.properties.provisioningState
