// Bicep template for Log Analytics custom table: Sevco_Devices_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 61, Deployed columns: 59 (Type column filtered)
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

resource sevcodevicesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Sevco_Devices_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Sevco_Devices_CL'
      description: 'Custom table Sevco_Devices_CL - imported from JSON schema'
      displayName: 'Sevco_Devices_CL'
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
          name: 'asset_attributes_controls_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_asset_classification_category_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_hostname_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_os_platform_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_os_release_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_internal_ips_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_external_ips_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_mac_manufacturers_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_associated_usernames_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_geo_ip_associated_ip_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_geo_ip_city_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_geo_ip_country_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_geo_ip_region_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_geo_ip_latitude_d'
          type: 'real'
        }
        {
          name: 'asset_attributes_geo_ip_longitude_d'
          type: 'real'
        }
        {
          name: 'asset_sources_s'
          type: 'string'
        }
        {
          name: 'asset_source_ids_s'
          type: 'string'
        }
        {
          name: 'asset_tags_s'
          type: 'string'
        }
        {
          name: 'event_event_type_s'
          type: 'string'
        }
        {
          name: 'event_correlation_timestamp_s'
          type: 'string'
        }
        {
          name: 'event_asset_version_s'
          type: 'string'
        }
        {
          name: 'event_asset_type_s'
          type: 'string'
        }
        {
          name: 'event_asset_id_s'
          type: 'string'
        }
        {
          name: 'event_source_id_s'
          type: 'string'
        }
        {
          name: 'event_config_id_g'
          type: 'string'
        }
        {
          name: 'asset_attributes_serial_number_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_active_directory_domain_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_additional_attributes_model_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_additional_attributes_manufacturer_s'
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
          name: 'asset_version_t'
          type: 'dateTime'
        }
        {
          name: 'event_asset_id_g'
          type: 'string'
        }
        {
          name: 'asset_attributes_geo_ip_locality_s'
          type: 'string'
        }
        {
          name: 'asset_config_ids_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_network_location_s'
          type: 'string'
        }
        {
          name: 'asset_first_observed_timestamp_s'
          type: 'string'
        }
        {
          name: 'asset_last_observed_timestamp_s'
          type: 'string'
        }
        {
          name: 'event_deleted_b'
          type: 'boolean'
        }
        {
          name: 'asset_attributes_imei_s'
          type: 'string'
        }
        {
          name: 'asset_org_id_g'
          type: 'string'
        }
        {
          name: 'asset_version_s'
          type: 'string'
        }
        {
          name: 'asset_first_observed_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'asset_last_observed_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'asset_last_activity_timestamp_s'
          type: 'string'
        }
        {
          name: 'asset_asset_type_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_hostnames_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_fqdn_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_os_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_ips_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_mac_addresses_s'
          type: 'string'
        }
        {
          name: 'asset_attributes_distinguished_name_s'
          type: 'string'
        }
        {
          name: 'asset_id_g'
          type: 'string'
        }
        {
          name: 'event_updates_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = sevcodevicesclTable.name
output tableId string = sevcodevicesclTable.id
output provisioningState string = sevcodevicesclTable.properties.provisioningState
