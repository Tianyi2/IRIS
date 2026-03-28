// Bicep template for Log Analytics custom table: GCPAuditLogs
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 27, Deployed columns: 26 (Type column filtered)
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

resource gcpauditlogsTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GCPAuditLogs'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GCPAuditLogs'
      description: 'Custom table GCPAuditLogs - imported from JSON schema'
      displayName: 'GCPAuditLogs'
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
          name: 'ServiceData'
          type: 'dynamic'
        }
        {
          name: 'ResourceOriginalState'
          type: 'dynamic'
        }
        {
          name: 'ResourceLocation'
          type: 'dynamic'
        }
        {
          name: 'Subscription'
          type: 'string'
        }
        {
          name: 'GCPResourceType'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'string'
        }
        {
          name: 'ProjectId'
          type: 'string'
        }
        {
          name: 'Timestamp'
          type: 'dateTime'
        }
        {
          name: 'LogName'
          type: 'string'
        }
        {
          name: 'PrincipalEmail'
          type: 'string'
        }
        {
          name: 'InsertId'
          type: 'string'
        }
        {
          name: 'StatusMessage'
          type: 'string'
        }
        {
          name: 'Response'
          type: 'dynamic'
        }
        {
          name: 'Request'
          type: 'dynamic'
        }
        {
          name: 'RequestMetadata'
          type: 'dynamic'
        }
        {
          name: 'AuthorizationInfo'
          type: 'dynamic'
        }
        {
          name: 'AuthenticationInfo'
          type: 'dynamic'
        }
        {
          name: 'Status'
          type: 'dynamic'
        }
        {
          name: 'NumResponseItems'
          type: 'string'
        }
        {
          name: 'GCPResourceName'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'MethodName'
          type: 'string'
        }
        {
          name: 'ServiceName'
          type: 'string'
        }
        {
          name: 'Metadata'
          type: 'dynamic'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = gcpauditlogsTable.name
output tableId string = gcpauditlogsTable.id
output provisioningState string = gcpauditlogsTable.properties.provisioningState
