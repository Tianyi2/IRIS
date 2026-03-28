// Bicep template for Log Analytics custom table: Corelight_v2_stun_nat_CL
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

resource corelightv2stunnatclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_stun_nat_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_stun_nat_CL'
      description: 'Custom table Corelight_v2_stun_nat_CL - imported from JSON schema'
      displayName: 'Corelight_v2_stun_nat_CL'
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
          name: 'uid_s'
          type: 'string'
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
          name: 'proto_s'
          type: 'string'
        }
        {
          name: 'is_orig_b'
          type: 'boolean'
        }
        {
          name: 'wan_addrs_s'
          type: 'string'
        }
        {
          name: 'wan_ports_s'
          type: 'string'
        }
        {
          name: 'lan_addrs_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2stunnatclTable.name
output tableId string = corelightv2stunnatclTable.id
output provisioningState string = corelightv2stunnatclTable.properties.provisioningState
