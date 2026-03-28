// Bicep template for Log Analytics custom table: Corelight_v2_etc_viz_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 22, Deployed columns: 19 (Type column filtered)
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

resource corelightv2etcvizclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_etc_viz_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_etc_viz_CL'
      description: 'Custom table Corelight_v2_etc_viz_CL - imported from JSON schema'
      displayName: 'Corelight_v2_etc_viz_CL'
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
          name: 's2c_viz_pdu1_enc_b'
          type: 'boolean'
        }
        {
          name: 's2c_viz_enc_frac_d'
          type: 'real'
        }
        {
          name: 's2c_viz_enc_dev_d'
          type: 'real'
        }
        {
          name: 's2c_viz_size_d'
          type: 'real'
        }
        {
          name: 'c2s_viz_clr_ex_s'
          type: 'string'
        }
        {
          name: 'c2s_viz_clr_frac_d'
          type: 'real'
        }
        {
          name: 'c2s_viz_pdu1_enc_b'
          type: 'boolean'
        }
        {
          name: 'c2s_viz_enc_frac_d'
          type: 'real'
        }
        {
          name: 'c2s_viz_enc_dev_d'
          type: 'real'
        }
        {
          name: 'c2s_viz_size_d'
          type: 'real'
        }
        {
          name: 'viz_stat_s'
          type: 'string'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'server_p_d'
          type: 'real'
        }
        {
          name: 'server_a_s'
          type: 'string'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 's2c_viz_clr_frac_d'
          type: 'real'
        }
        {
          name: 's2c_viz_clr_ex_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2etcvizclTable.name
output tableId string = corelightv2etcvizclTable.id
output provisioningState string = corelightv2etcvizclTable.properties.provisioningState
