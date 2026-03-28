// Bicep template for Log Analytics custom table: Corelight_v2_suricata_corelight_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 29, Deployed columns: 26 (Type column filtered)
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

resource corelightv2suricatacorelightclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_suricata_corelight_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_suricata_corelight_CL'
      description: 'Custom table Corelight_v2_suricata_corelight_CL - imported from JSON schema'
      displayName: 'Corelight_v2_suricata_corelight_CL'
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
          name: 'payload_s'
          type: 'string'
        }
        {
          name: 'community_id_s'
          type: 'string'
        }
        {
          name: 'alert_metadata_s'
          type: 'string'
        }
        {
          name: 'alert_severity_d'
          type: 'real'
        }
        {
          name: 'alert_category_s'
          type: 'string'
        }
        {
          name: 'alert_signature_s'
          type: 'string'
        }
        {
          name: 'alert_rev_d'
          type: 'real'
        }
        {
          name: 'alert_signature_id_d'
          type: 'real'
        }
        {
          name: 'alert_gid_d'
          type: 'real'
        }
        {
          name: 'alert_action_s'
          type: 'string'
        }
        {
          name: 'packet_s'
          type: 'string'
        }
        {
          name: 'pcap_cnt_d'
          type: 'real'
        }
        {
          name: 'flow_id_d'
          type: 'real'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'suri_id_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'icmp_code_d'
          type: 'real'
        }
        {
          name: 'icmp_type_d'
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
          name: 'tx_id_d'
          type: 'real'
        }
        {
          name: 'metadata_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2suricatacorelightclTable.name
output tableId string = corelightv2suricatacorelightclTable.id
output provisioningState string = corelightv2suricatacorelightclTable.properties.provisioningState
