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
// Data Collection Rule for CitrixAnalytics_indicatorSummary_CL
// ============================================================================
// Generated: 2025-09-19 14:20:00
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 54, DCR columns: 54 (Type column always filtered)
// Output stream: Custom-CitrixAnalytics_indicatorSummary_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CitrixAnalytics_indicatorSummary_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CitrixAnalytics_indicatorSummary_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'entity_id_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_historical_observation_period_in_days_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_lifetime_download_count_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_lifetime_download_volume_in_bytes_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_lifetime_users_downloaded_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_link_first_downloaded_t'
            type: 'string'
          }
          {
            name: 'occurrence_details_new_entities_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_observation_start_time_t'
            type: 'string'
          }
          {
            name: 'occurrence_details_region_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_relevant_event_type_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_repeat_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_risky_domain_category_list_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_suspicious_network_risk_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_time_quantity_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_time_unit_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_tool_name_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_type_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_user_device_risk_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_user_location_risk_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_user_network_risk_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_virus_name_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_webroot_threat_categories_s'
            type: 'string'
          }
          {
            name: 'pre_configured_s'
            type: 'string'
          }
          {
            name: 'risk_probability_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_historical_logon_locations_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_happen_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_exfiltrated_data_volume_in_bytes_d'
            type: 'string'
          }
          {
            name: 'entity_type_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'tenant_id_s'
            type: 'string'
          }
          {
            name: 'version_d'
            type: 'string'
          }
          {
            name: 'data_source_id_d'
            type: 'string'
          }
          {
            name: 'data_source_s'
            type: 'string'
          }
          {
            name: 'indicator_category_id_d'
            type: 'string'
          }
          {
            name: 'indicator_category_s'
            type: 'string'
          }
          {
            name: 'indicator_id_s'
            type: 'string'
          }
          {
            name: 'indicator_name_s'
            type: 'string'
          }
          {
            name: 'indicator_type_s'
            type: 'string'
          }
          {
            name: 'indicator_uuid_g'
            type: 'string'
          }
          {
            name: 'indicator_vector_id_d'
            type: 'string'
          }
          {
            name: 'indicator_vector_name_s'
            type: 'string'
          }
          {
            name: 'indicator_vector_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_city_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_client_ip_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_condition_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_country_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_cumulative_event_count_day_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_device_id_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_event_count_d'
            type: 'string'
          }
          {
            name: 'occurrence_details_event_description_s'
            type: 'string'
          }
          {
            name: 'occurrence_details_file_hash_g'
            type: 'string'
          }
          {
            name: 'ui_link_s'
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
          name: 'Sentinel-CitrixAnalytics_indicatorSummary_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CitrixAnalytics_indicatorSummary_CL']
        destinations: ['Sentinel-CitrixAnalytics_indicatorSummary_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), entity_id_s = tostring(entity_id_s), occurrence_details_historical_observation_period_in_days_d = toreal(occurrence_details_historical_observation_period_in_days_d), occurrence_details_lifetime_download_count_d = toreal(occurrence_details_lifetime_download_count_d), occurrence_details_lifetime_download_volume_in_bytes_d = toreal(occurrence_details_lifetime_download_volume_in_bytes_d), occurrence_details_lifetime_users_downloaded_d = toreal(occurrence_details_lifetime_users_downloaded_d), occurrence_details_link_first_downloaded_t = todatetime(occurrence_details_link_first_downloaded_t), occurrence_details_new_entities_s = tostring(occurrence_details_new_entities_s), occurrence_details_observation_start_time_t = todatetime(occurrence_details_observation_start_time_t), occurrence_details_region_s = tostring(occurrence_details_region_s), occurrence_details_relevant_event_type_s = tostring(occurrence_details_relevant_event_type_s), occurrence_details_repeat_d = toreal(occurrence_details_repeat_d), occurrence_details_risky_domain_category_list_s = tostring(occurrence_details_risky_domain_category_list_s), occurrence_details_suspicious_network_risk_d = toreal(occurrence_details_suspicious_network_risk_d), occurrence_details_time_quantity_d = toreal(occurrence_details_time_quantity_d), occurrence_details_time_unit_s = tostring(occurrence_details_time_unit_s), occurrence_details_tool_name_s = tostring(occurrence_details_tool_name_s), occurrence_details_type_s = tostring(occurrence_details_type_s), occurrence_details_user_device_risk_d = toreal(occurrence_details_user_device_risk_d), occurrence_details_user_location_risk_d = toreal(occurrence_details_user_location_risk_d), occurrence_details_user_network_risk_d = toreal(occurrence_details_user_network_risk_d), occurrence_details_virus_name_s = tostring(occurrence_details_virus_name_s), occurrence_details_webroot_threat_categories_s = tostring(occurrence_details_webroot_threat_categories_s), pre_configured_s = tostring(pre_configured_s), risk_probability_d = toreal(risk_probability_d), occurrence_details_historical_logon_locations_s = tostring(occurrence_details_historical_logon_locations_s), severity_s = tostring(severity_s), occurrence_details_happen_d = toreal(occurrence_details_happen_d), occurrence_details_exfiltrated_data_volume_in_bytes_d = toreal(occurrence_details_exfiltrated_data_volume_in_bytes_d), entity_type_s = tostring(entity_type_s), event_type_s = tostring(event_type_s), tenant_id_s = tostring(tenant_id_s), version_d = toreal(version_d), data_source_id_d = toreal(data_source_id_d), data_source_s = tostring(data_source_s), indicator_category_id_d = toreal(indicator_category_id_d), indicator_category_s = tostring(indicator_category_s), indicator_id_s = tostring(indicator_id_s), indicator_name_s = tostring(indicator_name_s), indicator_type_s = tostring(indicator_type_s), indicator_uuid_g = tostring(indicator_uuid_g), indicator_vector_id_d = toreal(indicator_vector_id_d), indicator_vector_name_s = tostring(indicator_vector_name_s), indicator_vector_s = tostring(indicator_vector_s), occurrence_details_city_s = tostring(occurrence_details_city_s), occurrence_details_client_ip_s = tostring(occurrence_details_client_ip_s), occurrence_details_condition_s = tostring(occurrence_details_condition_s), occurrence_details_country_s = tostring(occurrence_details_country_s), occurrence_details_cumulative_event_count_day_d = toreal(occurrence_details_cumulative_event_count_day_d), occurrence_details_device_id_s = tostring(occurrence_details_device_id_s), occurrence_details_event_count_d = toreal(occurrence_details_event_count_d), occurrence_details_event_description_s = tostring(occurrence_details_event_description_s), occurrence_details_file_hash_g = tostring(occurrence_details_file_hash_g), ui_link_s = tostring(ui_link_s)'
        outputStream: 'Custom-CitrixAnalytics_indicatorSummary_CL'
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
