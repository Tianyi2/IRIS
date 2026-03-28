// Bicep template for Log Analytics custom table: CyberArk_AuditEvents_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 17 (Type column filtered)
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

resource cyberarkauditeventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CyberArk_AuditEvents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CyberArk_AuditEvents_CL'
      description: 'Custom table CyberArk_AuditEvents_CL - imported from JSON schema'
      displayName: 'CyberArk_AuditEvents_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'CyberArkTenantId'
          type: 'string'
        }
        {
          name: 'timestamp'
          type: 'int'
        }
        {
          name: 'username'
          type: 'string'
        }
        {
          name: 'applicationCode'
          type: 'string'
        }
        {
          name: 'auditCode'
          type: 'string'
        }
        {
          name: 'action'
          type: 'string'
        }
        {
          name: 'auditType'
          type: 'string'
        }
        {
          name: 'userId'
          type: 'string'
          dataTypeHint: 1
        }
        {
          name: 'source'
          type: 'string'
        }
        {
          name: 'actionType'
          type: 'string'
        }
        {
          name: 'component'
          type: 'string'
        }
        {
          name: 'serviceName'
          type: 'string'
        }
        {
          name: 'target'
          type: 'string'
        }
        {
          name: 'command'
          type: 'string'
        }
        {
          name: 'sessionId'
          type: 'string'
        }
        {
          name: 'message'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = cyberarkauditeventsclTable.name
output tableId string = cyberarkauditeventsclTable.id
output provisioningState string = cyberarkauditeventsclTable.properties.provisioningState
