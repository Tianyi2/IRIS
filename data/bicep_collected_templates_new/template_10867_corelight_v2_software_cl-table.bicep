// Bicep template for Log Analytics custom table: Corelight_v2_software_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 12 (Type column filtered)
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

resource corelightv2softwareclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_software_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_software_CL'
      description: 'Custom table Corelight_v2_software_CL - imported from JSON schema'
      displayName: 'Corelight_v2_software_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'host_s'
          type: 'string'
        }
        {
          name: 'host_p_d'
          type: 'real'
        }
        {
          name: 'software_type_s'
          type: 'string'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'version_major_d'
          type: 'real'
        }
        {
          name: 'version_minor_d'
          type: 'real'
        }
        {
          name: 'version_minor2_d'
          type: 'real'
        }
        {
          name: 'version_minor3_d'
          type: 'real'
        }
        {
          name: 'version_addl_s'
          type: 'string'
        }
        {
          name: 'unparsed_version_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2softwareclTable.name
output tableId string = corelightv2softwareclTable.id
output provisioningState string = corelightv2softwareclTable.properties.provisioningState
