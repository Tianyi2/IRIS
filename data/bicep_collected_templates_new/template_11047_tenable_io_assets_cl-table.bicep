// Bicep template for Log Analytics custom table: Tenable_IO_Assets_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 43, Deployed columns: 41 (Type column filtered)
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

resource tenableioassetsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Tenable_IO_Assets_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Tenable_IO_Assets_CL'
      description: 'Custom table Tenable_IO_Assets_CL - imported from JSON schema'
      displayName: 'Tenable_IO_Assets_CL'
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
          type: 'boolean'
        }
        {
          name: 'has_plugin_results_b'
          type: 'boolean'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
        {
          name: 'updated_at_t'
          type: 'dateTime'
        }
        {
          name: 'first_seen_t'
          type: 'dateTime'
        }
        {
          name: 'last_seen_t'
          type: 'dateTime'
        }
        {
          name: 'first_scan_time_t'
          type: 'dateTime'
        }
        {
          name: 'last_scan_time_s'
          type: 'string'
        }
        {
          name: 'last_licensed_scan_date_t'
          type: 'dateTime'
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
}

output tableName string = tenableioassetsclTable.name
output tableId string = tenableioassetsclTable.id
output provisioningState string = tenableioassetsclTable.properties.provisioningState
