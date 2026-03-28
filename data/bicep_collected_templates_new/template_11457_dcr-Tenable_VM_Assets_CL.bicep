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
// Data Collection Rule for Tenable_VM_Assets_CL
// ============================================================================
// Generated: 2025-09-19 14:20:34
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 43, DCR columns: 41 (Type column always filtered)
// Output stream: Custom-Tenable_VM_Assets_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Tenable_VM_Assets_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Tenable_VM_Assets_CL': {
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
            name: 'fqdns_s'
            type: 'string'
          }
          {
            name: 'mac_addresses_s'
            type: 'string'
          }
          {
            name: 'netbios_names_s'
            type: 'string'
          }
          {
            name: 'operating_systems_s'
            type: 'string'
          }
          {
            name: 'system_types_s'
            type: 'string'
          }
          {
            name: 'hostnames_s'
            type: 'string'
          }
          {
            name: 'ssh_fingerprints_s'
            type: 'string'
          }
          {
            name: 'ipv6s_s'
            type: 'string'
          }
          {
            name: 'qualys_asset_ids_s'
            type: 'string'
          }
          {
            name: 'manufacturer_tpm_ids_s'
            type: 'string'
          }
          {
            name: 'symantec_ep_hardware_keys_s'
            type: 'string'
          }
          {
            name: 'sources_s'
            type: 'string'
          }
          {
            name: 'tags_s'
            type: 'string'
          }
          {
            name: 'network_interfaces_s'
            type: 'string'
          }
          {
            name: 'acr_score_s'
            type: 'string'
          }
          {
            name: 'exposure_score_s'
            type: 'string'
          }
          {
            name: 'qualys_host_ids_s'
            type: 'string'
          }
          {
            name: 'ipv4s_s'
            type: 'string'
          }
          {
            name: 'installed_software_s'
            type: 'string'
          }
          {
            name: 'agent_names_s'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'has_agent_b'
            type: 'string'
          }
          {
            name: 'has_plugin_results_b'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'updated_at_t'
            type: 'string'
          }
          {
            name: 'first_seen_t'
            type: 'string'
          }
          {
            name: 'last_seen_t'
            type: 'string'
          }
          {
            name: 'first_scan_time_t'
            type: 'string'
          }
          {
            name: 'last_scan_time_s'
            type: 'string'
          }
          {
            name: 'last_licensed_scan_date_t'
            type: 'string'
          }
          {
            name: 'last_scan_id_s'
            type: 'string'
          }
          {
            name: 'last_schedule_id_s'
            type: 'string'
          }
          {
            name: 'azure_resource_id_s'
            type: 'string'
          }
          {
            name: 'azure_vm_id_g'
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
          name: 'Sentinel-Tenable_VM_Assets_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Tenable_VM_Assets_CL']
        destinations: ['Sentinel-Tenable_VM_Assets_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), fqdns_s = tostring(fqdns_s), mac_addresses_s = tostring(mac_addresses_s), netbios_names_s = tostring(netbios_names_s), operating_systems_s = tostring(operating_systems_s), system_types_s = tostring(system_types_s), hostnames_s = tostring(hostnames_s), ssh_fingerprints_s = tostring(ssh_fingerprints_s), ipv6s_s = tostring(ipv6s_s), qualys_asset_ids_s = tostring(qualys_asset_ids_s), manufacturer_tpm_ids_s = tostring(manufacturer_tpm_ids_s), symantec_ep_hardware_keys_s = tostring(symantec_ep_hardware_keys_s), sources_s = tostring(sources_s), tags_s = tostring(tags_s), network_interfaces_s = tostring(network_interfaces_s), acr_score_s = tostring(acr_score_s), exposure_score_s = tostring(exposure_score_s), qualys_host_ids_s = tostring(qualys_host_ids_s), ipv4s_s = tostring(ipv4s_s), installed_software_s = tostring(installed_software_s), agent_names_s = tostring(agent_names_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), id_g = tostring(id_g), has_agent_b = tobool(has_agent_b), has_plugin_results_b = tobool(has_plugin_results_b), created_at_t = todatetime(created_at_t), updated_at_t = todatetime(updated_at_t), first_seen_t = todatetime(first_seen_t), last_seen_t = todatetime(last_seen_t), first_scan_time_t = todatetime(first_scan_time_t), last_scan_time_s = tostring(last_scan_time_s), last_licensed_scan_date_t = todatetime(last_licensed_scan_date_t), last_scan_id_s = tostring(last_scan_id_s), last_schedule_id_s = tostring(last_schedule_id_s), azure_resource_id_s = tostring(azure_resource_id_s), azure_vm_id_g = tostring(azure_vm_id_g)'
        outputStream: 'Custom-Tenable_VM_Assets_CL'
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
