@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for Health_Data_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 79, DCR columns: 77 (Type column always filtered)
// Output stream: Custom-Health_Data_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Health_Data_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Health_Data_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_vmachine_info_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_uagent_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_total_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_static_ip_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_src_port_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_split_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_sentinelone_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_rdns_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_proxy_ip_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_netbios_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_mdns_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_kerberos_user_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_kerberos_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_invalid_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_idle_start_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_windows_defender_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_idle_end_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_zpa_user_d'
            type: 'string'
          }
          {
            name: 'hostid_ip_sometimes_percent_d'
            type: 'string'
          }
          {
            name: 'cpu_updated_at_s'
            type: 'string'
          }
          {
            name: 'cpu_idle_percent_d'
            type: 'string'
          }
          {
            name: 'cpu_system_percent_d'
            type: 'string'
          }
          {
            name: 'cpu_nice_percent_d'
            type: 'string'
          }
          {
            name: 'cpu_user_percent_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'memory_used_bytes_d'
            type: 'string'
          }
          {
            name: 'memory_free_bytes_d'
            type: 'string'
          }
          {
            name: 'memory_usage_percent_d'
            type: 'string'
          }
          {
            name: 'hostid_updated_at_s'
            type: 'string'
          }
          {
            name: 'hostid_ip_never_percent_d'
            type: 'string'
          }
          {
            name: 'hostid_ip_always_percent_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_generic_edr_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_fireeye_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_end_time_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'disk_disk_utilization_used_bytes_d'
            type: 'string'
          }
          {
            name: 'disk_disk_utilization_free_bytes_d'
            type: 'string'
          }
          {
            name: 'disk_disk_utilization_total_bytes_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_dhcp_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_cybereason_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_crowdstrike_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_cookie_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_clear_state_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_cb_cloud_d'
            type: 'string'
          }
          {
            name: 'connectivity_sensors_s'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_carbon_black_d'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_TestEDR_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'system_version_cloud_bridge_s'
            type: 'string'
          }
          {
            name: 'hostid_artifact_counts_arsenic_d'
            type: 'string'
          }
          {
            name: 'connectivity_updated_at_s'
            type: 'string'
          }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-Health_Data_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Health_Data_CL']
        destinations: ['Sentinel-Health_Data_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), hostid_artifact_counts_vmachine_info_d = toreal(hostid_artifact_counts_vmachine_info_d), hostid_artifact_counts_uagent_d = toreal(hostid_artifact_counts_uagent_d), hostid_artifact_counts_total_d = toreal(hostid_artifact_counts_total_d), hostid_artifact_counts_static_ip_d = toreal(hostid_artifact_counts_static_ip_d), hostid_artifact_counts_src_port_d = toreal(hostid_artifact_counts_src_port_d), hostid_artifact_counts_split_d = toreal(hostid_artifact_counts_split_d), hostid_artifact_counts_sentinelone_d = toreal(hostid_artifact_counts_sentinelone_d), hostid_artifact_counts_rdns_d = toreal(hostid_artifact_counts_rdns_d), hostid_artifact_counts_proxy_ip_d = toreal(hostid_artifact_counts_proxy_ip_d), hostid_artifact_counts_netbios_d = toreal(hostid_artifact_counts_netbios_d), hostid_artifact_counts_mdns_d = toreal(hostid_artifact_counts_mdns_d), hostid_artifact_counts_kerberos_user_d = toreal(hostid_artifact_counts_kerberos_user_d), hostid_artifact_counts_kerberos_d = toreal(hostid_artifact_counts_kerberos_d), hostid_artifact_counts_invalid_d = toreal(hostid_artifact_counts_invalid_d), hostid_artifact_counts_idle_start_d = toreal(hostid_artifact_counts_idle_start_d), hostid_artifact_counts_windows_defender_d = toreal(hostid_artifact_counts_windows_defender_d), hostid_artifact_counts_idle_end_d = toreal(hostid_artifact_counts_idle_end_d), hostid_artifact_counts_zpa_user_d = toreal(hostid_artifact_counts_zpa_user_d), hostid_ip_sometimes_percent_d = toreal(hostid_ip_sometimes_percent_d), cpu_updated_at_s = tostring(cpu_updated_at_s), cpu_idle_percent_d = toreal(cpu_idle_percent_d), cpu_system_percent_d = toreal(cpu_system_percent_d), cpu_nice_percent_d = toreal(cpu_nice_percent_d), cpu_user_percent_d = toreal(cpu_user_percent_d), power_updated_at_s = tostring(power_updated_at_s), power_error_s = tostring(power_error_s), power_status_s = tostring(power_status_s), memory_updated_at_s = tostring(memory_updated_at_s), memory_total_bytes_d = toreal(memory_total_bytes_d), memory_used_bytes_d = toreal(memory_used_bytes_d), memory_free_bytes_d = toreal(memory_free_bytes_d), memory_usage_percent_d = toreal(memory_usage_percent_d), hostid_updated_at_s = tostring(hostid_updated_at_s), hostid_ip_never_percent_d = toreal(hostid_ip_never_percent_d), hostid_ip_always_percent_d = toreal(hostid_ip_always_percent_d), hostid_artifact_counts_generic_edr_d = toreal(hostid_artifact_counts_generic_edr_d), hostid_artifact_counts_fireeye_d = toreal(hostid_artifact_counts_fireeye_d), hostid_artifact_counts_end_time_d = toreal(hostid_artifact_counts_end_time_d), system_uptime_s = tostring(system_uptime_s), sensors_s = tostring(sensors_s), trafficdrop_updated_at_s = tostring(trafficdrop_updated_at_s), trafficdrop_sensors_s = tostring(trafficdrop_sensors_s), disk_updated_at_s = tostring(disk_updated_at_s), disk_disk_utilization_usage_percent_d = toreal(disk_disk_utilization_usage_percent_d), disk_disk_utilization_used_bytes_d = toreal(disk_disk_utilization_used_bytes_d), disk_disk_utilization_free_bytes_d = toreal(disk_disk_utilization_free_bytes_d), disk_disk_utilization_total_bytes_d = toreal(disk_disk_utilization_total_bytes_d), network_s = tostring(network_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), system_serial_number_s = tostring(system_serial_number_s), system_version_last_update_s = tostring(system_version_last_update_s), system_version_model_s = tostring(system_version_model_s), system_version_mode_s = tostring(system_version_mode_s), hostid_artifact_counts_dns_d = toreal(hostid_artifact_counts_dns_d), hostid_artifact_counts_dhcp_d = toreal(hostid_artifact_counts_dhcp_d), hostid_artifact_counts_cybereason_d = toreal(hostid_artifact_counts_cybereason_d), hostid_artifact_counts_crowdstrike_d = toreal(hostid_artifact_counts_crowdstrike_d), hostid_artifact_counts_cookie_d = toreal(hostid_artifact_counts_cookie_d), hostid_artifact_counts_clear_state_d = toreal(hostid_artifact_counts_clear_state_d), hostid_artifact_counts_cb_cloud_d = toreal(hostid_artifact_counts_cb_cloud_d), connectivity_sensors_s = tostring(connectivity_sensors_s), hostid_artifact_counts_carbon_black_d = toreal(hostid_artifact_counts_carbon_black_d), hostid_artifact_counts_TestEDR_d = toreal(hostid_artifact_counts_TestEDR_d), system_updated_at_s = tostring(system_updated_at_s), system_version_vectra_version_s = tostring(system_version_vectra_version_s), system_version_vectra_instance_type_s = tostring(system_version_vectra_instance_type_s), system_version_vm_type_s = tostring(system_version_vm_type_s), system_version_gmt_t = todatetime(system_version_gmt_t), system_version_cloud_bridge_s = tostring(system_version_cloud_bridge_s), hostid_artifact_counts_arsenic_d = toreal(hostid_artifact_counts_arsenic_d), connectivity_updated_at_s = tostring(connectivity_updated_at_s)'
        outputStream: 'Custom-Health_Data_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
