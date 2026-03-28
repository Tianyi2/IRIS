// Bicep template for Log Analytics custom table: SalesforceServiceCloud_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 213, Deployed columns: 211 (Type column filtered)
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

resource salesforceservicecloudclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SalesforceServiceCloud_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SalesforceServiceCloud_CL'
      description: 'Custom table SalesforceServiceCloud_CL - imported from JSON schema'
      displayName: 'SalesforceServiceCloud_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'is_new_s'
          type: 'string'
        }
        {
          name: 'is_mobile_s'
          type: 'string'
        }
        {
          name: 'is_long_running_request_s'
          type: 'string'
        }
        {
          name: 'is_guest_s'
          type: 'string'
        }
        {
          name: 'is_first_request_s'
          type: 'string'
        }
        {
          name: 'is_error_s'
          type: 'string'
        }
        {
          name: 'is_api_s'
          type: 'string'
        }
        {
          name: 'is_ajax_request_s'
          type: 'string'
        }
        {
          name: 'http_method_s'
          type: 'string'
        }
        {
          name: 'http_headers_s'
          type: 'string'
        }
        {
          name: 'is_scheduled_s'
          type: 'string'
        }
        {
          name: 'grandparent_ui_element_s'
          type: 'string'
        }
        {
          name: 'file_preview_type_s'
          type: 'string'
        }
        {
          name: 'exception_type_s'
          type: 'string'
        }
        {
          name: 'exception_message_s'
          type: 'string'
        }
        {
          name: 'ept_s'
          type: 'string'
        }
        {
          name: 'entry_point_s'
          type: 'string'
        }
        {
          name: 'entity_type_s'
          type: 'string'
        }
        {
          name: 'entity_name_s'
          type: 'string'
        }
        {
          name: 'entity_id_s'
          type: 'string'
        }
        {
          name: 'entity_s'
          type: 'string'
        }
        {
          name: 'effective_page_time_s'
          type: 'string'
        }
        {
          name: 'file_type_s'
          type: 'string'
        }
        {
          name: 'duration_s'
          type: 'string'
        }
        {
          name: 'is_secure_s'
          type: 'string'
        }
        {
          name: 'job_id_s'
          type: 'string'
        }
        {
          name: 'operation_type_s'
          type: 'string'
        }
        {
          name: 'num_sessions_s'
          type: 'string'
        }
        {
          name: 'num_results_s'
          type: 'string'
        }
        {
          name: 'num_clicks_s'
          type: 'string'
        }
        {
          name: 'number_soql_queries_s'
          type: 'string'
        }
        {
          name: 'number_fields_s'
          type: 'string'
        }
        {
          name: 'number_failures_s'
          type: 'string'
        }
        {
          name: 'number_exception_filters_s'
          type: 'string'
        }
        {
          name: 'number_columns_s'
          type: 'string'
        }
        {
          name: 'number_buckets_s'
          type: 'string'
        }
        {
          name: 'is_success_s'
          type: 'string'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'method_s'
          type: 'string'
        }
        {
          name: 'media_type_s'
          type: 'string'
        }
        {
          name: 'managed_package_namespace_s'
          type: 'string'
        }
        {
          name: 'login_status_s'
          type: 'string'
        }
        {
          name: 'login_key_s'
          type: 'string'
        }
        {
          name: 'log_group_id_s'
          type: 'string'
        }
        {
          name: 'limit_usage_percent_s'
          type: 'string'
        }
        {
          name: 'license_context_s'
          type: 'string'
        }
        {
          name: 'last_version_s'
          type: 'string'
        }
        {
          name: 'language_s'
          type: 'string'
        }
        {
          name: 'method_name_s'
          type: 'string'
        }
        {
          name: 'document_id_derived_s'
          type: 'string'
        }
        {
          name: 'document_id_s'
          type: 'string'
        }
        {
          name: 'display_type_s'
          type: 'string'
        }
        {
          name: 'callout_time_s'
          type: 'string'
        }
        {
          name: 'browser_version_s'
          type: 'string'
        }
        {
          name: 'browser_name_s'
          type: 'string'
        }
        {
          name: 'batch_id_s'
          type: 'string'
        }
        {
          name: 'average_row_size_s'
          type: 'string'
        }
        {
          name: 'article_version_id_s'
          type: 'string'
        }
        {
          name: 'article_version_s'
          type: 'string'
        }
        {
          name: 'article_status_s'
          type: 'string'
        }
        {
          name: 'article_id_s'
          type: 'string'
        }
        {
          name: 'app_type_s'
          type: 'string'
        }
        {
          name: 'cipher_suite_s'
          type: 'string'
        }
        {
          name: 'app_name_s'
          type: 'string'
        }
        {
          name: 'api_type_s'
          type: 'string'
        }
        {
          name: 'analytics_mode_s'
          type: 'string'
        }
        {
          name: 'starttime'
          type: 'dateTime'
        }
        {
          name: 'endtime'
          type: 'dateTime'
        }
        {
          name: 'targetusername_has'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'Computer'
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
          name: 'Message'
          type: 'string'
        }
        {
          name: 'api_version_s'
          type: 'string'
        }
        {
          name: 'class_name_s'
          type: 'string'
        }
        {
          name: 'clicked_record_id_s'
          type: 'string'
        }
        {
          name: 'client_id_s'
          type: 'string'
        }
        {
          name: 'device_session_id_s'
          type: 'string'
        }
        {
          name: 'device_platform_s'
          type: 'string'
        }
        {
          name: 'delivery_location_s'
          type: 'string'
        }
        {
          name: 'delivery_id_s'
          type: 'string'
        }
        {
          name: 'db_total_time_s'
          type: 'string'
        }
        {
          name: 'db_cpu_time_s'
          type: 'string'
        }
        {
          name: 'db_blocks_s'
          type: 'string'
        }
        {
          name: 'data_s'
          type: 'string'
        }
        {
          name: 'dashboard_type_s'
          type: 'string'
        }
        {
          name: 'dashboard_id_derived_s'
          type: 'string'
        }
        {
          name: 'dashboard_id_s'
          type: 'string'
        }
        {
          name: 'dashboard_component_id_s'
          type: 'string'
        }
        {
          name: 'cpu_time_s'
          type: 'string'
        }
        {
          name: 'controller_type_s'
          type: 'string'
        }
        {
          name: 'context_s'
          type: 'string'
        }
        {
          name: 'console_id_derived_s'
          type: 'string'
        }
        {
          name: 'console_id_s'
          type: 'string'
        }
        {
          name: 'connection_type_s'
          type: 'string'
        }
        {
          name: 'component_name_s'
          type: 'string'
        }
        {
          name: 'component_id_derived_s'
          type: 'string'
        }
        {
          name: 'component_id_s'
          type: 'string'
        }
        {
          name: 'client_version_s'
          type: 'string'
        }
        {
          name: 'client_info_s'
          type: 'string'
        }
        {
          name: 'organization_id_s'
          type: 'string'
        }
        {
          name: 'origin_s'
          type: 'string'
        }
        {
          name: 'page_app_name_s'
          type: 'string'
        }
        {
          name: 'page_context_s'
          type: 'string'
        }
        {
          name: 'client_name_s'
          type: 'string'
        }
        {
          name: 'wave_timestamp_s'
          type: 'string'
        }
        {
          name: 'wave_session_id_g'
          type: 'string'
        }
        {
          name: 'view_state_size_s'
          type: 'string'
        }
        {
          name: 'version_id_derived_s'
          type: 'string'
        }
        {
          name: 'version_id_s'
          type: 'string'
        }
        {
          name: 'user_type_s'
          type: 'string'
        }
        {
          name: 'user_initiated_logout_s'
          type: 'string'
        }
        {
          name: 'user_id_derived_s'
          type: 'string'
        }
        {
          name: 'user_id_s'
          type: 'string'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'user_email_s'
          type: 'string'
        }
        {
          name: 'uri_id_derived_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'ui_event_type_s'
          type: 'string'
        }
        {
          name: 'ui_event_timestamp_s'
          type: 'string'
        }
        {
          name: 'ui_event_source_s'
          type: 'string'
        }
        {
          name: 'ui_event_sequence_num_s'
          type: 'string'
        }
        {
          name: 'ui_event_id_s'
          type: 'string'
        }
        {
          name: 'trigger_type_s'
          type: 'string'
        }
        {
          name: 'trigger_name_s'
          type: 'string'
        }
        {
          name: 'trigger_id_s'
          type: 'string'
        }
        {
          name: 'transaction_type_s'
          type: 'string'
        }
        {
          name: 'user_name_s'
          type: 'string'
        }
        {
          name: 'uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'success_s'
          type: 'string'
        }
        {
          name: 'client_ip_s'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'request_size_s'
          type: 'string'
        }
        {
          name: 'delegated_user_name_s'
          type: 'string'
        }
        {
          name: 'delegated_user_id_s'
          type: 'string'
        }
        {
          name: 'delegated_user_id_derived_s'
          type: 'string'
        }
        {
          name: 'exec_time_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'platform_type_s'
          type: 'string'
        }
        {
          name: 'os_name_s'
          type: 'string'
        }
        {
          name: 'os_version_s'
          type: 'string'
        }
        {
          name: 'number_of_records_s'
          type: 'string'
        }
        {
          name: 'timestamp_s'
          type: 'string'
        }
        {
          name: 'status_code_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'size_bytes_s'
          type: 'string'
        }
        {
          name: 'referrer_uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'user_agent_s'
          type: 'string'
        }
        {
          name: 'browser_type_s'
          type: 'string'
        }
        {
          name: 'time_s'
          type: 'string'
        }
        {
          name: 'response_size_s'
          type: 'string'
        }
        {
          name: 'device_id_s'
          type: 'string'
        }
        {
          name: 'device_model_s'
          type: 'string'
        }
        {
          name: 'source_ip_s'
          type: 'string'
        }
        {
          name: 'total_time_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'tls_protocol_s'
          type: 'string'
        }
        {
          name: 'target_ui_element_s'
          type: 'string'
        }
        {
          name: 'related_list_s'
          type: 'string'
        }
        {
          name: 'related_entity_id_s'
          type: 'string'
        }
        {
          name: 'record_type_s'
          type: 'string'
        }
        {
          name: 'record_id_derived_s'
          type: 'string'
        }
        {
          name: 'record_id_s'
          type: 'string'
        }
        {
          name: 'read_time_s'
          type: 'string'
        }
        {
          name: 'rank_s'
          type: 'string'
        }
        {
          name: 'quiddity_s'
          type: 'string'
        }
        {
          name: 'query_id_s'
          type: 'string'
        }
        {
          name: 'query_s'
          type: 'string'
        }
        {
          name: 'rendering_type_s'
          type: 'string'
        }
        {
          name: 'prevpage_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'prevpage_entity_id_s'
          type: 'string'
        }
        {
          name: 'prevpage_context_s'
          type: 'string'
        }
        {
          name: 'prevpage_app_name_s'
          type: 'string'
        }
        {
          name: 'prefixes_searched_s'
          type: 'string'
        }
        {
          name: 'parent_ui_element_s'
          type: 'string'
        }
        {
          name: 'page_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'page_start_time_s'
          type: 'string'
        }
        {
          name: 'page_name_s'
          type: 'string'
        }
        {
          name: 'page_entity_type_s'
          type: 'string'
        }
        {
          name: 'page_entity_id_s'
          type: 'string'
        }
        {
          name: 'prevpage_entity_type_s'
          type: 'string'
        }
        {
          name: 'reopen_count_s'
          type: 'string'
        }
        {
          name: 'report_description_s'
          type: 'string'
        }
        {
          name: 'report_id_s'
          type: 'string'
        }
        {
          name: 'tab_id_s'
          type: 'string'
        }
        {
          name: 'stack_trace_s'
          type: 'string'
        }
        {
          name: 'sort_s'
          type: 'string'
        }
        {
          name: 'site_id_s'
          type: 'string'
        }
        {
          name: 'sharing_permission_s'
          type: 'string'
        }
        {
          name: 'sharing_operation_s'
          type: 'string'
        }
        {
          name: 'shared_with_entity_id_s'
          type: 'string'
        }
        {
          name: 'session_type_s'
          type: 'string'
        }
        {
          name: 'session_level_s'
          type: 'string'
        }
        {
          name: 'session_key_s'
          type: 'string'
        }
        {
          name: 'session_id_s'
          type: 'string'
        }
        {
          name: 'search_query_s'
          type: 'string'
        }
        {
          name: 'sdk_version_s'
          type: 'string'
        }
        {
          name: 'sdk_app_version_s'
          type: 'string'
        }
        {
          name: 'sdk_app_type_s'
          type: 'string'
        }
        {
          name: 'run_time_s'
          type: 'string'
        }
        {
          name: 'rows_processed_s'
          type: 'string'
        }
        {
          name: 'row_count_s'
          type: 'string'
        }
        {
          name: 'resolution_type_s'
          type: 'string'
        }
        {
          name: 'request_type_s'
          type: 'string'
        }
        {
          name: 'request_status_s'
          type: 'string'
        }
        {
          name: 'request_id_s'
          type: 'string'
        }
        {
          name: 'report_id_derived_s'
          type: 'string'
        }
        {
          name: 'timestamp_derived_t'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
      ]
    }
  }
}

output tableName string = salesforceservicecloudclTable.name
output tableId string = salesforceservicecloudclTable.id
output provisioningState string = salesforceservicecloudclTable.properties.provisioningState
