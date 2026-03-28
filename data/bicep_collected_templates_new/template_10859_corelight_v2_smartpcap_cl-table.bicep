// Bicep template for Log Analytics custom table: Corelight_v2_smartpcap_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 5, Deployed columns: 2 (Type column filtered)
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

resource corelightv2smartpcapclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_smartpcap_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_smartpcap_CL'
      description: 'Custom table Corelight_v2_smartpcap_CL - imported from JSON schema'
      displayName: 'Corelight_v2_smartpcap_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'logstr_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2smartpcapclTable.name
output tableId string = corelightv2smartpcapclTable.id
output provisioningState string = corelightv2smartpcapclTable.properties.provisioningState
