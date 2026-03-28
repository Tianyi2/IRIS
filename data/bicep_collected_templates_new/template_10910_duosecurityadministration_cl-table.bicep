// Bicep template for Log Analytics custom table: DuoSecurityAdministration_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 8, Deployed columns: 8 (Type column filtered)
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

resource duosecurityadministrationclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DuoSecurityAdministration_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DuoSecurityAdministration_CL'
      description: 'Custom table DuoSecurityAdministration_CL - imported from JSON schema'
      displayName: 'DuoSecurityAdministration_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'isotimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'object_s'
          type: 'string'
        }
        {
          name: 'timestamp_d'
          type: 'real'
        }
        {
          name: 'username_s'
          type: 'string'
        }
        {
          name: 'description_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = duosecurityadministrationclTable.name
output tableId string = duosecurityadministrationclTable.id
output provisioningState string = duosecurityadministrationclTable.properties.provisioningState
