// Bicep template for Log Analytics custom table: VMware_CWS_Health_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 6, Deployed columns: 6 (Type column filtered)
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

resource vmwarecwshealthclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'VMware_CWS_Health_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'VMware_CWS_Health_CL'
      description: 'Custom table VMware_CWS_Health_CL - imported from JSON schema'
      displayName: 'VMware_CWS_Health_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'cws_component'
          type: 'string'
        }
        {
          name: 'healthtest_observed_unit'
          type: 'string'
        }
        {
          name: 'healthtest_observed_value'
          type: 'int'
        }
        {
          name: 'healthtest_status'
          type: 'string'
        }
        {
          name: 'healthtest_timestamp'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = vmwarecwshealthclTable.name
output tableId string = vmwarecwshealthclTable.id
output provisioningState string = vmwarecwshealthclTable.properties.provisioningState
