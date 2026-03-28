// Bicep template for Log Analytics custom table: Corelight_v2_ipsec_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 34, Deployed columns: 31 (Type column filtered)
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

resource corelightv2ipsecclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_ipsec_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_ipsec_CL'
      description: 'Custom table Corelight_v2_ipsec_CL - imported from JSON schema'
      displayName: 'Corelight_v2_ipsec_CL'
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
          name: 'length_d'
          type: 'real'
        }
        {
          name: 'transform_attributes_s'
          type: 'string'
        }
        {
          name: 'certificates_s'
          type: 'string'
        }
        {
          name: 'protocol_id_d'
          type: 'real'
        }
        {
          name: 'proposals_s'
          type: 'string'
        }
        {
          name: 'ke_dh_groups_s'
          type: 'string'
        }
        {
          name: 'transforms_s'
          type: 'string'
        }
        {
          name: 'notify_messages_s'
          type: 'string'
        }
        {
          name: 'vendor_ids_s'
          type: 'string'
        }
        {
          name: 'message_id_d'
          type: 'real'
        }
        {
          name: 'flag_r_b'
          type: 'boolean'
        }
        {
          name: 'flag_v_b'
          type: 'boolean'
        }
        {
          name: 'flag_i_b'
          type: 'boolean'
        }
        {
          name: 'flag_a_b'
          type: 'boolean'
        }
        {
          name: 'flag_c_b'
          type: 'boolean'
        }
        {
          name: 'flag_e_b'
          type: 'boolean'
        }
        {
          name: 'exchange_type_d'
          type: 'real'
        }
        {
          name: 'min_ver_d'
          type: 'real'
        }
        {
          name: 'maj_ver_d'
          type: 'real'
        }
        {
          name: 'responder_spi_s'
          type: 'string'
        }
        {
          name: 'initiator_spi_s'
          type: 'string'
        }
        {
          name: 'is_orig_b'
          type: 'boolean'
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
          name: 'doi_d'
          type: 'real'
        }
        {
          name: 'situation_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2ipsecclTable.name
output tableId string = corelightv2ipsecclTable.id
output provisioningState string = corelightv2ipsecclTable.properties.provisioningState
