// Bicep template for Log Analytics custom table: Corelight_v2_notice_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 31, Deployed columns: 28 (Type column filtered)
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

resource corelightv2noticeclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_notice_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_notice_CL'
      description: 'Custom table Corelight_v2_notice_CL - imported from JSON schema'
      displayName: 'Corelight_v2_notice_CL'
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
          name: 'remote_location_longitude_d'
          type: 'real'
        }
        {
          name: 'remote_location_latitude_d'
          type: 'real'
        }
        {
          name: 'remote_location_city_s'
          type: 'string'
        }
        {
          name: 'remote_location_region_s'
          type: 'string'
        }
        {
          name: 'remote_location_country_code_s'
          type: 'string'
        }
        {
          name: 'suppress_for_d'
          type: 'real'
        }
        {
          name: 'actions_s'
          type: 'string'
        }
        {
          name: 'peer_descr_s'
          type: 'string'
        }
        {
          name: 'n_d'
          type: 'real'
        }
        {
          name: 'p_d'
          type: 'real'
        }
        {
          name: 'dst_s'
          type: 'string'
        }
        {
          name: 'severity_level_d'
          type: 'real'
        }
        {
          name: 'src_s'
          type: 'string'
        }
        {
          name: 'msg_s'
          type: 'string'
        }
        {
          name: 'note_s'
          type: 'string'
        }
        {
          name: 'proto_s'
          type: 'string'
        }
        {
          name: 'file_desc_s'
          type: 'string'
        }
        {
          name: 'file_mime_type_s'
          type: 'string'
        }
        {
          name: 'fuid_s'
          type: 'string'
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
          name: 'sub_s'
          type: 'string'
        }
        {
          name: 'severity_name_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2noticeclTable.name
output tableId string = corelightv2noticeclTable.id
output provisioningState string = corelightv2noticeclTable.properties.provisioningState
