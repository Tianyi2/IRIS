// Bicep template for Log Analytics custom table: CitrixAnalytics_indicatorSummary_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 54, Deployed columns: 54 (Type column filtered)
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

resource citrixanalyticsindicatorsummaryclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CitrixAnalytics_indicatorSummary_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CitrixAnalytics_indicatorSummary_CL'
      description: 'Custom table CitrixAnalytics_indicatorSummary_CL - imported from JSON schema'
      displayName: 'CitrixAnalytics_indicatorSummary_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'entity_id_s'
          type: 'string'
        }
        {
          name: 'occurrence_details_historical_observation_period_in_days_d'
          type: 'real'
        }
        {
          name: 'occurrence_details_lifetime_download_count_d'
          type: 'real'
        }
        {
          name: 'occurrence_details_lifetime_download_volume_in_bytes_d'
          type: 'real'
        }
        {
          name: 'occurrence_details_lifetime_users_downloaded_d'
          type: 'real'
        }
        {
          name: 'occurrence_details_link_first_downloaded_t'
          type: 'dateTime'
        }
        {
          name: 'occurrence_details_new_entities_s'
          type: 'string'
        }
        {
          name: 'occurrence_details_observation_start_time_t'
          type: 'dateTime'
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
          type: 'real'
        }
        {
          name: 'occurrence_details_risky_domain_category_list_s'
          type: 'string'
        }
        {
          name: 'occurrence_details_suspicious_network_risk_d'
          type: 'real'
        }
        {
          name: 'occurrence_details_time_quantity_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'occurrence_details_user_location_risk_d'
          type: 'real'
        }
        {
          name: 'occurrence_details_user_network_risk_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'occurrence_details_exfiltrated_data_volume_in_bytes_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'data_source_id_d'
          type: 'real'
        }
        {
          name: 'data_source_s'
          type: 'string'
        }
        {
          name: 'indicator_category_id_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'occurrence_details_device_id_s'
          type: 'string'
        }
        {
          name: 'occurrence_details_event_count_d'
          type: 'real'
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
          dataTypeHint: 0
        }
      ]
    }
  }
}

output tableName string = citrixanalyticsindicatorsummaryclTable.name
output tableId string = citrixanalyticsindicatorsummaryclTable.id
output provisioningState string = citrixanalyticsindicatorsummaryclTable.properties.provisioningState
