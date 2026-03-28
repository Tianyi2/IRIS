// Bicep template for Log Analytics custom table: Corelight_v2_ntp_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 20 (Type column filtered)
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

resource corelightv2ntpclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_ntp_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_ntp_CL'
      description: 'Custom table Corelight_v2_ntp_CL - imported from JSON schema'
      displayName: 'Corelight_v2_ntp_CL'
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
          name: 'rec_time_t'
          type: 'dateTime'
        }
        {
          name: 'org_time_t'
          type: 'dateTime'
        }
        {
          name: 'ref_time_t'
          type: 'dateTime'
        }
        {
          name: 'ref_id_s'
          type: 'string'
        }
        {
          name: 'root_disp_d'
          type: 'real'
        }
        {
          name: 'root_delay_d'
          type: 'real'
        }
        {
          name: 'precision_d'
          type: 'real'
        }
        {
          name: 'xmt_time_t'
          type: 'dateTime'
        }
        {
          name: 'poll_d'
          type: 'real'
        }
        {
          name: 'mode_d'
          type: 'real'
        }
        {
          name: 'version_d'
          type: 'real'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'stratum_d'
          type: 'real'
        }
        {
          name: 'num_exts_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2ntpclTable.name
output tableId string = corelightv2ntpclTable.id
output provisioningState string = corelightv2ntpclTable.properties.provisioningState
