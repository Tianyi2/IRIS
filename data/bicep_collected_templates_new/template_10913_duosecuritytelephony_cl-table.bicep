// Bicep template for Log Analytics custom table: DuoSecurityTelephony_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 7, Deployed columns: 7 (Type column filtered)
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

resource duosecuritytelephonyclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DuoSecurityTelephony_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DuoSecurityTelephony_CL'
      description: 'Custom table DuoSecurityTelephony_CL - imported from JSON schema'
      displayName: 'DuoSecurityTelephony_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'context_s'
          type: 'string'
        }
        {
          name: 'credits_d'
          type: 'real'
        }
        {
          name: 'isotimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'phone_s'
          type: 'string'
        }
        {
          name: 'timestamp_d'
          type: 'real'
        }
        {
          name: 'type_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = duosecuritytelephonyclTable.name
output tableId string = duosecuritytelephonyclTable.id
output provisioningState string = duosecuritytelephonyclTable.properties.provisioningState
