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
// Data Collection Rule for SalesforceServiceCloud_CL
// ============================================================================
// Generated: 2025-09-19 14:20:30
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 213, DCR columns: 211 (Type column always filtered)
// Output stream: Custom-SalesforceServiceCloud_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SalesforceServiceCloud_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SalesforceServiceCloud_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'endtime'
            type: 'string'
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
          }
          {
            name: 'user_email_s'
            type: 'string'
          }
          {
            name: 'uri_id_derived_s'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'TenantId'
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
          name: 'Sentinel-SalesforceServiceCloud_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SalesforceServiceCloud_CL']
        destinations: ['Sentinel-SalesforceServiceCloud_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), is_new_s = tostring(is_new_s), is_mobile_s = tostring(is_mobile_s), is_long_running_request_s = tostring(is_long_running_request_s), is_guest_s = tostring(is_guest_s), is_first_request_s = tostring(is_first_request_s), is_error_s = tostring(is_error_s), is_api_s = tostring(is_api_s), is_ajax_request_s = tostring(is_ajax_request_s), http_method_s = tostring(http_method_s), http_headers_s = tostring(http_headers_s), is_scheduled_s = tostring(is_scheduled_s), grandparent_ui_element_s = tostring(grandparent_ui_element_s), file_preview_type_s = tostring(file_preview_type_s), exception_type_s = tostring(exception_type_s), exception_message_s = tostring(exception_message_s), ept_s = tostring(ept_s), entry_point_s = tostring(entry_point_s), entity_type_s = tostring(entity_type_s), entity_name_s = tostring(entity_name_s), entity_id_s = tostring(entity_id_s), entity_s = tostring(entity_s), effective_page_time_s = tostring(effective_page_time_s), file_type_s = tostring(file_type_s), duration_s = tostring(duration_s), is_secure_s = tostring(is_secure_s), job_id_s = tostring(job_id_s), operation_type_s = tostring(operation_type_s), num_sessions_s = tostring(num_sessions_s), num_results_s = tostring(num_results_s), num_clicks_s = tostring(num_clicks_s), number_soql_queries_s = tostring(number_soql_queries_s), number_fields_s = tostring(number_fields_s), number_failures_s = tostring(number_failures_s), number_exception_filters_s = tostring(number_exception_filters_s), number_columns_s = tostring(number_columns_s), number_buckets_s = tostring(number_buckets_s), is_success_s = tostring(is_success_s), name_s = tostring(name_s), method_s = tostring(method_s), media_type_s = tostring(media_type_s), managed_package_namespace_s = tostring(managed_package_namespace_s), login_status_s = tostring(login_status_s), login_key_s = tostring(login_key_s), log_group_id_s = tostring(log_group_id_s), limit_usage_percent_s = tostring(limit_usage_percent_s), license_context_s = tostring(license_context_s), last_version_s = tostring(last_version_s), language_s = tostring(language_s), method_name_s = tostring(method_name_s), document_id_derived_s = tostring(document_id_derived_s), document_id_s = tostring(document_id_s), display_type_s = tostring(display_type_s), callout_time_s = tostring(callout_time_s), browser_version_s = tostring(browser_version_s), browser_name_s = tostring(browser_name_s), batch_id_s = tostring(batch_id_s), average_row_size_s = tostring(average_row_size_s), article_version_id_s = tostring(article_version_id_s), article_version_s = tostring(article_version_s), article_status_s = tostring(article_status_s), article_id_s = tostring(article_id_s), app_type_s = tostring(app_type_s), cipher_suite_s = tostring(cipher_suite_s), app_name_s = tostring(app_name_s), api_type_s = tostring(api_type_s), analytics_mode_s = tostring(analytics_mode_s), starttime = todatetime(starttime), endtime = todatetime(endtime), targetusername_has = tostring(targetusername_has), SourceSystem = tostring(SourceSystem), Computer = tostring(Computer), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Message = tostring(Message), api_version_s = tostring(api_version_s), class_name_s = tostring(class_name_s), clicked_record_id_s = tostring(clicked_record_id_s), client_id_s = tostring(client_id_s), device_session_id_s = tostring(device_session_id_s), device_platform_s = tostring(device_platform_s), delivery_location_s = tostring(delivery_location_s), delivery_id_s = tostring(delivery_id_s), db_total_time_s = tostring(db_total_time_s), db_cpu_time_s = tostring(db_cpu_time_s), db_blocks_s = tostring(db_blocks_s), data_s = tostring(data_s), dashboard_type_s = tostring(dashboard_type_s), dashboard_id_derived_s = tostring(dashboard_id_derived_s), dashboard_id_s = tostring(dashboard_id_s), dashboard_component_id_s = tostring(dashboard_component_id_s), cpu_time_s = tostring(cpu_time_s), controller_type_s = tostring(controller_type_s), context_s = tostring(context_s), console_id_derived_s = tostring(console_id_derived_s), console_id_s = tostring(console_id_s), connection_type_s = tostring(connection_type_s), component_name_s = tostring(component_name_s), component_id_derived_s = tostring(component_id_derived_s), component_id_s = tostring(component_id_s), client_version_s = tostring(client_version_s), client_info_s = tostring(client_info_s), organization_id_s = tostring(organization_id_s), origin_s = tostring(origin_s), page_app_name_s = tostring(page_app_name_s), page_context_s = tostring(page_context_s), client_name_s = tostring(client_name_s), wave_timestamp_s = tostring(wave_timestamp_s), wave_session_id_g = tostring(wave_session_id_g), view_state_size_s = tostring(view_state_size_s), version_id_derived_s = tostring(version_id_derived_s), version_id_s = tostring(version_id_s), user_type_s = tostring(user_type_s), user_initiated_logout_s = tostring(user_initiated_logout_s), user_id_derived_s = tostring(user_id_derived_s), user_id_s = tostring(user_id_s), url_s = tostring(url_s), user_email_s = tostring(user_email_s), uri_id_derived_s = tostring(uri_id_derived_s), ui_event_type_s = tostring(ui_event_type_s), ui_event_timestamp_s = tostring(ui_event_timestamp_s), ui_event_source_s = tostring(ui_event_source_s), ui_event_sequence_num_s = tostring(ui_event_sequence_num_s), ui_event_id_s = tostring(ui_event_id_s), trigger_type_s = tostring(trigger_type_s), trigger_name_s = tostring(trigger_name_s), trigger_id_s = tostring(trigger_id_s), transaction_type_s = tostring(transaction_type_s), user_name_s = tostring(user_name_s), uri_s = tostring(uri_s), success_s = tostring(success_s), client_ip_s = tostring(client_ip_s), EventProduct = tostring(EventProduct), request_size_s = tostring(request_size_s), delegated_user_name_s = tostring(delegated_user_name_s), delegated_user_id_s = tostring(delegated_user_id_s), delegated_user_id_derived_s = tostring(delegated_user_id_derived_s), exec_time_s = tostring(exec_time_s), action_s = tostring(action_s), platform_type_s = tostring(platform_type_s), os_name_s = tostring(os_name_s), os_version_s = tostring(os_version_s), number_of_records_s = tostring(number_of_records_s), timestamp_s = tostring(timestamp_s), status_code_s = tostring(status_code_s), event_type_s = tostring(event_type_s), size_bytes_s = tostring(size_bytes_s), referrer_uri_s = tostring(referrer_uri_s), user_agent_s = tostring(user_agent_s), browser_type_s = tostring(browser_type_s), time_s = tostring(time_s), response_size_s = tostring(response_size_s), device_id_s = tostring(device_id_s), device_model_s = tostring(device_model_s), source_ip_s = tostring(source_ip_s), total_time_s = tostring(total_time_s), RawData = tostring(RawData), tls_protocol_s = tostring(tls_protocol_s), target_ui_element_s = tostring(target_ui_element_s), related_list_s = tostring(related_list_s), related_entity_id_s = tostring(related_entity_id_s), record_type_s = tostring(record_type_s), record_id_derived_s = tostring(record_id_derived_s), record_id_s = tostring(record_id_s), read_time_s = tostring(read_time_s), rank_s = tostring(rank_s), quiddity_s = tostring(quiddity_s), query_id_s = tostring(query_id_s), query_s = tostring(query_s), rendering_type_s = tostring(rendering_type_s), prevpage_url_s = tostring(prevpage_url_s), prevpage_entity_id_s = tostring(prevpage_entity_id_s), prevpage_context_s = tostring(prevpage_context_s), prevpage_app_name_s = tostring(prevpage_app_name_s), prefixes_searched_s = tostring(prefixes_searched_s), parent_ui_element_s = tostring(parent_ui_element_s), page_url_s = tostring(page_url_s), page_start_time_s = tostring(page_start_time_s), page_name_s = tostring(page_name_s), page_entity_type_s = tostring(page_entity_type_s), page_entity_id_s = tostring(page_entity_id_s), prevpage_entity_type_s = tostring(prevpage_entity_type_s), reopen_count_s = tostring(reopen_count_s), report_description_s = tostring(report_description_s), report_id_s = tostring(report_id_s), tab_id_s = tostring(tab_id_s), stack_trace_s = tostring(stack_trace_s), sort_s = tostring(sort_s), site_id_s = tostring(site_id_s), sharing_permission_s = tostring(sharing_permission_s), sharing_operation_s = tostring(sharing_operation_s), shared_with_entity_id_s = tostring(shared_with_entity_id_s), session_type_s = tostring(session_type_s), session_level_s = tostring(session_level_s), session_key_s = tostring(session_key_s), session_id_s = tostring(session_id_s), search_query_s = tostring(search_query_s), sdk_version_s = tostring(sdk_version_s), sdk_app_version_s = tostring(sdk_app_version_s), sdk_app_type_s = tostring(sdk_app_type_s), run_time_s = tostring(run_time_s), rows_processed_s = tostring(rows_processed_s), row_count_s = tostring(row_count_s), resolution_type_s = tostring(resolution_type_s), request_type_s = tostring(request_type_s), request_status_s = tostring(request_status_s), request_id_s = tostring(request_id_s), report_id_derived_s = tostring(report_id_derived_s), timestamp_derived_t = todatetime(timestamp_derived_t), TenantId = toguid(TenantId)'
        outputStream: 'Custom-SalesforceServiceCloud_CL'
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
