// Bicep template for Log Analytics custom table: QualysHostDetection_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 4, Deployed columns: 4 (Type column filtered)
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

resource qualyshostdetectionclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'QualysHostDetection_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'QualysHostDetection_CL'
      description: 'Custom table QualysHostDetection_CL - imported from JSON schema'
      displayName: 'QualysHostDetection_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Detections_s'
          type: 'dynamic'
        }
        {
          name: 'NetBios_s'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = qualyshostdetectionclTable.name
output tableId string = qualyshostdetectionclTable.id
output provisioningState string = qualyshostdetectionclTable.properties.provisioningState
