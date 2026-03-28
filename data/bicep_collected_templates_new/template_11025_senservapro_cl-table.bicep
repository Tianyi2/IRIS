// Bicep template for Log Analytics custom table: SenservaPro_CL
// Generated on 2025-09-19 14:13:58 UTC
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

resource senservaproclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SenservaPro_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SenservaPro_CL'
      description: 'Custom table SenservaPro_CL - imported from JSON schema'
      displayName: 'SenservaPro_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ControlName_s'
          type: 'string'
        }
        {
          name: 'TenantDisplayName_s'
          type: 'string'
        }
        {
          name: 'LogAnalyticsWorkspaceDisplayName_s'
          type: 'string'
        }
        {
          name: 'ObjectId_g'
          type: 'string'
        }
        {
          name: 'TenantId_s'
          type: 'string'
        }
        {
          name: 'ScanId_s'
          type: 'string'
        }
        {
          name: 'ScanTime_t'
          type: 'dateTime'
        }
        {
          name: 'CEFLoggingLevel_d'
          type: 'real'
        }
        {
          name: 'ControlId_d'
          type: 'real'
        }
        {
          name: 'MitreControls_s'
          type: 'string'
        }
        {
          name: 'NistControls_s'
          type: 'string'
        }
        {
          name: 'Description_s'
          type: 'string'
        }
        {
          name: 'Value_s'
          type: 'string'
        }
        {
          name: 'Reference_s'
          type: 'string'
        }
        {
          name: 'Group_s'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = senservaproclTable.name
output tableId string = senservaproclTable.id
output provisioningState string = senservaproclTable.properties.provisioningState
