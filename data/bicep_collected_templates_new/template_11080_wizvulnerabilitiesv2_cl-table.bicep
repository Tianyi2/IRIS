// Bicep template for Log Analytics custom table: WizVulnerabilitiesV2_CL
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

resource wizvulnerabilitiesv2clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'WizVulnerabilitiesV2_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'WizVulnerabilitiesV2_CL'
      description: 'Custom table WizVulnerabilitiesV2_CL - imported from JSON schema'
      displayName: 'WizVulnerabilitiesV2_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'id_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'portalUrl_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'CVEDescription_s'
          type: 'string'
        }
        {
          name: 'CVSSSeverity_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = wizvulnerabilitiesv2clTable.name
output tableId string = wizvulnerabilitiesv2clTable.id
output provisioningState string = wizvulnerabilitiesv2clTable.properties.provisioningState
