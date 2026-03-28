// Bicep template for Log Analytics custom table: Corelight_v2_rdp_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 32, Deployed columns: 29 (Type column filtered)
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

resource corelightv2rdpclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_rdp_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_rdp_CL'
      description: 'Custom table Corelight_v2_rdp_CL - imported from JSON schema'
      displayName: 'Corelight_v2_rdp_CL'
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
          name: 'rdpeudp_uid_s'
          type: 'string'
        }
        {
          name: 'inferences_s'
          type: 'string'
        }
        {
          name: 'channels_joined_d'
          type: 'real'
        }
        {
          name: 'auth_success_b'
          type: 'boolean'
        }
        {
          name: 'encryption_method_s'
          type: 'string'
        }
        {
          name: 'encryption_level_s'
          type: 'string'
        }
        {
          name: 'cert_permanent_b'
          type: 'boolean'
        }
        {
          name: 'cert_count_d'
          type: 'real'
        }
        {
          name: 'cert_type_s'
          type: 'string'
        }
        {
          name: 'requested_color_depth_s'
          type: 'string'
        }
        {
          name: 'desktop_height_d'
          type: 'real'
        }
        {
          name: 'desktop_width_d'
          type: 'real'
        }
        {
          name: 'client_dig_product_id_s'
          type: 'string'
        }
        {
          name: 'client_name_s'
          type: 'string'
        }
        {
          name: 'client_build_s'
          type: 'string'
        }
        {
          name: 'keyboard_layout_s'
          type: 'string'
        }
        {
          name: 'client_channels_s'
          type: 'string'
        }
        {
          name: 'security_protocol_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'result_s'
          type: 'string'
        }
        {
          name: 'cookie_s'
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
          name: 'rdfp_string_s'
          type: 'string'
        }
        {
          name: 'rdfp_hash_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2rdpclTable.name
output tableId string = corelightv2rdpclTable.id
output provisioningState string = corelightv2rdpclTable.properties.provisioningState
