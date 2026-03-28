// Bicep template for Log Analytics custom table: Corelight_v2_stun_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 14 (Type column filtered)
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

resource corelightv2stunclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_stun_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_stun_CL'
      description: 'Custom table Corelight_v2_stun_CL - imported from JSON schema'
      displayName: 'Corelight_v2_stun_CL'
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
          name: 'trans_id_s'
          type: 'string'
        }
        {
          name: 'method_s'
          type: 'string'
        }
        {
          name: 'class_s'
          type: 'string'
        }
        {
          name: 'attr_types_s'
          type: 'string'
        }
        {
          name: 'attr_vals_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2stunclTable.name
output tableId string = corelightv2stunclTable.id
output provisioningState string = corelightv2stunclTable.properties.provisioningState
