// Bicep template for Log Analytics custom table: Health_Data_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 79, Deployed columns: 77 (Type column filtered)
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

resource healthdataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Health_Data_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Health_Data_CL'
      description: 'Custom table Health_Data_CL - imported from JSON schema'
      displayName: 'Health_Data_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'hostid_artifact_counts_vmachine_info_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_uagent_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_total_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_static_ip_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_src_port_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_split_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_sentinelone_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_rdns_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_proxy_ip_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_netbios_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_mdns_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_kerberos_user_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_kerberos_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_invalid_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_idle_start_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_windows_defender_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_idle_end_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_zpa_user_d'
          type: 'real'
        }
        {
          name: 'hostid_ip_sometimes_percent_d'
          type: 'real'
        }
        {
          name: 'cpu_updated_at_s'
          type: 'string'
        }
        {
          name: 'cpu_idle_percent_d'
          type: 'real'
        }
        {
          name: 'cpu_system_percent_d'
          type: 'real'
        }
        {
          name: 'cpu_nice_percent_d'
          type: 'real'
        }
        {
          name: 'cpu_user_percent_d'
          type: 'real'
        }
        {
          name: 'power_updated_at_s'
          type: 'string'
        }
        {
          name: 'power_error_s'
          type: 'string'
        }
        {
          name: 'power_status_s'
          type: 'string'
        }
        {
          name: 'memory_updated_at_s'
          type: 'string'
        }
        {
          name: 'memory_total_bytes_d'
          type: 'real'
        }
        {
          name: 'memory_used_bytes_d'
          type: 'real'
        }
        {
          name: 'memory_free_bytes_d'
          type: 'real'
        }
        {
          name: 'memory_usage_percent_d'
          type: 'real'
        }
        {
          name: 'hostid_updated_at_s'
          type: 'string'
        }
        {
          name: 'hostid_ip_never_percent_d'
          type: 'real'
        }
        {
          name: 'hostid_ip_always_percent_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_generic_edr_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_fireeye_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_end_time_d'
          type: 'real'
        }
        {
          name: 'system_uptime_s'
          type: 'string'
        }
        {
          name: 'sensors_s'
          type: 'string'
        }
        {
          name: 'trafficdrop_updated_at_s'
          type: 'string'
        }
        {
          name: 'trafficdrop_sensors_s'
          type: 'string'
        }
        {
          name: 'disk_updated_at_s'
          type: 'string'
        }
        {
          name: 'disk_disk_utilization_usage_percent_d'
          type: 'real'
        }
        {
          name: 'disk_disk_utilization_used_bytes_d'
          type: 'real'
        }
        {
          name: 'disk_disk_utilization_free_bytes_d'
          type: 'real'
        }
        {
          name: 'disk_disk_utilization_total_bytes_d'
          type: 'real'
        }
        {
          name: 'network_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'system_serial_number_s'
          type: 'string'
        }
        {
          name: 'system_version_last_update_s'
          type: 'string'
        }
        {
          name: 'system_version_model_s'
          type: 'string'
        }
        {
          name: 'system_version_mode_s'
          type: 'string'
        }
        {
          name: 'hostid_artifact_counts_dns_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_dhcp_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_cybereason_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_crowdstrike_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_cookie_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_clear_state_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_cb_cloud_d'
          type: 'real'
        }
        {
          name: 'connectivity_sensors_s'
          type: 'string'
        }
        {
          name: 'hostid_artifact_counts_carbon_black_d'
          type: 'real'
        }
        {
          name: 'hostid_artifact_counts_TestEDR_d'
          type: 'real'
        }
        {
          name: 'system_updated_at_s'
          type: 'string'
        }
        {
          name: 'system_version_vectra_version_s'
          type: 'string'
        }
        {
          name: 'system_version_vectra_instance_type_s'
          type: 'string'
        }
        {
          name: 'system_version_vm_type_s'
          type: 'string'
        }
        {
          name: 'system_version_gmt_t'
          type: 'dateTime'
        }
        {
          name: 'system_version_cloud_bridge_s'
          type: 'string'
        }
        {
          name: 'hostid_artifact_counts_arsenic_d'
          type: 'real'
        }
        {
          name: 'connectivity_updated_at_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = healthdataclTable.name
output tableId string = healthdataclTable.id
output provisioningState string = healthdataclTable.properties.provisioningState
