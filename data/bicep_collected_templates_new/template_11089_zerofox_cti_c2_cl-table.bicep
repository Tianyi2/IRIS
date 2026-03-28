// Bicep template for Log Analytics custom table: ZeroFox_CTI_C2_CL
// Generated on 2025-09-19 14:14:00 UTC
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

resource zerofoxctic2clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_C2_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_C2_CL'
      description: 'Custom table ZeroFox_CTI_C2_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_C2_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'domain_s'
          type: 'string'
        }
        {
          name: 'port_d'
          type: 'real'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
        {
          name: 'ip_addresses_s'
          type: 'string'
        }
        {
          name: 'updated_at_t'
          type: 'dateTime'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = zerofoxctic2clTable.name
output tableId string = zerofoxctic2clTable.id
output provisioningState string = zerofoxctic2clTable.properties.provisioningState
