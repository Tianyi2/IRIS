// Bicep template for Log Analytics custom table: Corelight_v2_known_devices_CL
// Generated on 2025-09-19 14:13:52 UTC
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

resource corelightv2knowndevicesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_known_devices_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_known_devices_CL'
      description: 'Custom table Corelight_v2_known_devices_CL - imported from JSON schema'
      displayName: 'Corelight_v2_known_devices_CL'
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
          name: 'mac_s'
          type: 'string'
        }
        {
          name: 'vendor_mac_s'
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

output tableName string = corelightv2knowndevicesclTable.name
output tableId string = corelightv2knowndevicesclTable.id
output provisioningState string = corelightv2knowndevicesclTable.properties.provisioningState
