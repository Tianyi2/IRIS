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
// Data Collection Rule for Sevco_Devices_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 61, DCR columns: 59 (Type column always filtered)
// Output stream: Custom-Sevco_Devices_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Sevco_Devices_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Sevco_Devices_CL': {
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
            type: 'string'
          }
          {
            name: 'asset_attributes_geo_ip_longitude_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'asset_last_observed_timestamp_t'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-Sevco_Devices_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Sevco_Devices_CL']
        destinations: ['Sentinel-Sevco_Devices_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), asset_attributes_controls_s = tostring(asset_attributes_controls_s), asset_attributes_asset_classification_category_s = tostring(asset_attributes_asset_classification_category_s), asset_attributes_hostname_s = tostring(asset_attributes_hostname_s), asset_attributes_os_platform_s = tostring(asset_attributes_os_platform_s), asset_attributes_os_release_s = tostring(asset_attributes_os_release_s), asset_attributes_internal_ips_s = tostring(asset_attributes_internal_ips_s), asset_attributes_external_ips_s = tostring(asset_attributes_external_ips_s), asset_attributes_mac_manufacturers_s = tostring(asset_attributes_mac_manufacturers_s), asset_attributes_associated_usernames_s = tostring(asset_attributes_associated_usernames_s), asset_attributes_geo_ip_associated_ip_s = tostring(asset_attributes_geo_ip_associated_ip_s), asset_attributes_geo_ip_city_s = tostring(asset_attributes_geo_ip_city_s), asset_attributes_geo_ip_country_s = tostring(asset_attributes_geo_ip_country_s), asset_attributes_geo_ip_region_s = tostring(asset_attributes_geo_ip_region_s), asset_attributes_geo_ip_latitude_d = toreal(asset_attributes_geo_ip_latitude_d), asset_attributes_geo_ip_longitude_d = toreal(asset_attributes_geo_ip_longitude_d), asset_sources_s = tostring(asset_sources_s), asset_source_ids_s = tostring(asset_source_ids_s), asset_tags_s = tostring(asset_tags_s), event_event_type_s = tostring(event_event_type_s), event_correlation_timestamp_s = tostring(event_correlation_timestamp_s), event_asset_version_s = tostring(event_asset_version_s), event_asset_type_s = tostring(event_asset_type_s), event_asset_id_s = tostring(event_asset_id_s), event_source_id_s = tostring(event_source_id_s), event_config_id_g = tostring(event_config_id_g), asset_attributes_serial_number_s = tostring(asset_attributes_serial_number_s), asset_attributes_active_directory_domain_s = tostring(asset_attributes_active_directory_domain_s), asset_attributes_additional_attributes_model_s = tostring(asset_attributes_additional_attributes_model_s), asset_attributes_additional_attributes_manufacturer_s = tostring(asset_attributes_additional_attributes_manufacturer_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), asset_version_t = todatetime(asset_version_t), event_asset_id_g = tostring(event_asset_id_g), asset_attributes_geo_ip_locality_s = tostring(asset_attributes_geo_ip_locality_s), asset_config_ids_s = tostring(asset_config_ids_s), asset_attributes_network_location_s = tostring(asset_attributes_network_location_s), asset_first_observed_timestamp_s = tostring(asset_first_observed_timestamp_s), asset_last_observed_timestamp_s = tostring(asset_last_observed_timestamp_s), event_deleted_b = tobool(event_deleted_b), asset_attributes_imei_s = tostring(asset_attributes_imei_s), asset_org_id_g = tostring(asset_org_id_g), asset_version_s = tostring(asset_version_s), asset_first_observed_timestamp_t = todatetime(asset_first_observed_timestamp_t), asset_last_observed_timestamp_t = todatetime(asset_last_observed_timestamp_t), asset_last_activity_timestamp_s = tostring(asset_last_activity_timestamp_s), asset_asset_type_s = tostring(asset_asset_type_s), asset_attributes_hostnames_s = tostring(asset_attributes_hostnames_s), asset_attributes_fqdn_s = tostring(asset_attributes_fqdn_s), asset_attributes_os_s = tostring(asset_attributes_os_s), asset_attributes_ips_s = tostring(asset_attributes_ips_s), asset_attributes_mac_addresses_s = tostring(asset_attributes_mac_addresses_s), asset_attributes_distinguished_name_s = tostring(asset_attributes_distinguished_name_s), asset_id_g = tostring(asset_id_g), event_updates_s = tostring(event_updates_s)'
        outputStream: 'Custom-Sevco_Devices_CL'
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
