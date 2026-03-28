// Bicep template for Log Analytics custom table: ZeroFox_CTI_credit_cards_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 10, Deployed columns: 10 (Type column filtered)
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

resource zerofoxcticreditcardsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_credit_cards_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_credit_cards_CL'
      description: 'Custom table ZeroFox_CTI_credit_cards_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_credit_cards_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'cc_num_s'
          type: 'string'
        }
        {
          name: 'month_s'
          type: 'string'
        }
        {
          name: 'year_s'
          type: 'string'
        }
        {
          name: 'cvv_s'
          type: 'real'
        }
        {
          name: 'issuer_s'
          type: 'string'
        }
        {
          name: 'source_s'
          type: 'string'
        }
        {
          name: 'cc_bin_s'
          type: 'string'
        }
        {
          name: 'breach_name_s'
          type: 'string'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = zerofoxcticreditcardsclTable.name
output tableId string = zerofoxcticreditcardsclTable.id
output provisioningState string = zerofoxcticreditcardsclTable.properties.provisioningState
