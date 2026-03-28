// Bicep template for Log Analytics custom table: NetBackupAlerts_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 18, Deployed columns: 16 (Type column filtered)
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

resource netbackupalertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'NetBackupAlerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'NetBackupAlerts_CL'
      description: 'Custom table NetBackupAlerts_CL - imported from JSON schema'
      displayName: 'NetBackupAlerts_CL'
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
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'tenantId_g'
          type: 'string'
        }
        {
          name: 'auditDateTime_d'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'operation_s'
          type: 'string'
        }
        {
          name: 'Message'
          type: 'string'
        }
        {
          name: 'userName_s'
          type: 'string'
        }
        {
          name: 'auditDateTime_t'
          type: 'dateTime'
        }
        {
          name: 'reason_s'
          type: 'string'
        }
        {
          name: 'auditAttributes_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = netbackupalertsclTable.name
output tableId string = netbackupalertsclTable.id
output provisioningState string = netbackupalertsclTable.properties.provisioningState
