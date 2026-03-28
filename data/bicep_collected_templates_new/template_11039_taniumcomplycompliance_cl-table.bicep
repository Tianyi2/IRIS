// Bicep template for Log Analytics custom table: TaniumComplyCompliance_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 12, Deployed columns: 11 (Type column filtered)
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

resource taniumcomplycomplianceclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TaniumComplyCompliance_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TaniumComplyCompliance_CL'
      description: 'Custom table TaniumComplyCompliance_CL - imported from JSON schema'
      displayName: 'TaniumComplyCompliance_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'Computer_Name_s'
          type: 'string'
        }
        {
          name: 'Operating_System_Generation_s'
          type: 'string'
        }
        {
          name: 'Profile_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Rule_ID_s'
          type: 'string'
        }
        {
          name: 'Rule_s'
          type: 'string'
        }
        {
          name: 'Standard_s'
          type: 'string'
        }
        {
          name: 'Status_Category_s'
          type: 'string'
        }
        {
          name: 'Version_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = taniumcomplycomplianceclTable.name
output tableId string = taniumcomplycomplianceclTable.id
output provisioningState string = taniumcomplycomplianceclTable.properties.provisioningState
