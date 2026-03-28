// Bicep template for Log Analytics custom table: Corelight_v2_icmp_specific_tunnels_CL
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

resource corelightv2icmpspecifictunnelsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_icmp_specific_tunnels_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_icmp_specific_tunnels_CL'
      description: 'Custom table Corelight_v2_icmp_specific_tunnels_CL - imported from JSON schema'
      displayName: 'Corelight_v2_icmp_specific_tunnels_CL'
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
          name: 'start_time_t'
          type: 'dateTime'
        }
        {
          name: 'duration_d'
          type: 'real'
        }
        {
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'tunnel_s'
          type: 'string'
        }
        {
          name: 'seq_d'
          type: 'real'
        }
        {
          name: 'icmp_id_d'
          type: 'real'
        }
        {
          name: 'payload_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2icmpspecifictunnelsclTable.name
output tableId string = corelightv2icmpspecifictunnelsclTable.id
output provisioningState string = corelightv2icmpspecifictunnelsclTable.properties.provisioningState
