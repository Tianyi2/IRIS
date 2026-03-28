// Bicep template for Log Analytics custom table: Corelight_v2_known_names_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 14, Deployed columns: 11 (Type column filtered)
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

resource corelightv2knownnamesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_known_names_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_known_names_CL'
      description: 'Custom table Corelight_v2_known_names_CL - imported from JSON schema'
      displayName: 'Corelight_v2_known_names_CL'
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
          name: 'duration_d'
          type: 'real'
        }
        {
          name: 'kuid_s'
          type: 'string'
        }
        {
          name: 'host_ip_s'
          type: 'string'
        }
        {
          name: 'hostname_s'
          type: 'string'
        }
        {
          name: 'protocols_s'
          type: 'string'
        }
        {
          name: 'num_conns_d'
          type: 'real'
        }
        {
          name: 'annotations_s'
          type: 'string'
        }
        {
          name: 'last_active_session_s'
          type: 'string'
        }
        {
          name: 'last_active_interval_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2knownnamesclTable.name
output tableId string = corelightv2knownnamesclTable.id
output provisioningState string = corelightv2knownnamesclTable.properties.provisioningState
