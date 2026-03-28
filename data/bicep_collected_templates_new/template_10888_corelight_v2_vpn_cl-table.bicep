// Bicep template for Log Analytics custom table: Corelight_v2_vpn_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 27, Deployed columns: 24 (Type column filtered)
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

resource corelightv2vpnclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_vpn_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_vpn_CL'
      description: 'Custom table Corelight_v2_vpn_CL - imported from JSON schema'
      displayName: 'Corelight_v2_vpn_CL'
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
          name: 'resp_city_s'
          type: 'string'
        }
        {
          name: 'resp_region_s'
          type: 'string'
        }
        {
          name: 'resp_cc_s'
          type: 'string'
        }
        {
          name: 'orig_city_s'
          type: 'string'
        }
        {
          name: 'orig_region_s'
          type: 'string'
        }
        {
          name: 'orig_cc_s'
          type: 'string'
        }
        {
          name: 'resp_bytes_d'
          type: 'real'
        }
        {
          name: 'orig_bytes_d'
          type: 'real'
        }
        {
          name: 'duration_d'
          type: 'real'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'client_info_s'
          type: 'string'
        }
        {
          name: 'inferences_s'
          type: 'string'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'vpn_type_s'
          type: 'string'
        }
        {
          name: 'proto_s'
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
          name: 'server_name_s'
          type: 'string'
        }
        {
          name: 'issuer_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2vpnclTable.name
output tableId string = corelightv2vpnclTable.id
output provisioningState string = corelightv2vpnclTable.properties.provisioningState
