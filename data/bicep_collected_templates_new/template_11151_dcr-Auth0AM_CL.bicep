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
// Data Collection Rule for Auth0AM_CL
// ============================================================================
// Generated: 2025-09-19 14:19:54
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 193, DCR columns: 189 (Type column always filtered)
// Output stream: Custom-Auth0AM_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Auth0AM_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Auth0AM_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'audience_s'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_disable_clickjack_protection_headers_b'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_disable_impersonation_b'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_enable_sso_b'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_enforce_client_authentication_on_passwordless_start_b'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_revoke_refresh_token_grant_b'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_universal_login_b'
            type: 'string'
          }
          {
            name: 'details_response_body_friendly_name_s'
            type: 'string'
          }
          {
            name: 'details_response_body_from_s'
            type: 'string'
          }
          {
            name: 'details_response_body_grant_types_s'
            type: 'string'
          }
          {
            name: 'details_response_body_guardian_mfa_page_s'
            type: 'string'
          }
          {
            name: 'details_response_body_identifier_s'
            type: 'string'
          }
          {
            name: 'details_response_body_identities_s'
            type: 'string'
          }
          {
            name: 'details_response_body_id_s'
            type: 'string'
          }
          {
            name: 'details_response_body_is_first_party_b'
            type: 'string'
          }
          {
            name: 'details_response_body_is_token_endpoint_ip_header_trusted_b'
            type: 'string'
          }
          {
            name: 'details_response_body_jwt_configuration_alg_s'
            type: 'string'
          }
          {
            name: 'details_response_body_jwt_configuration_lifetime_in_seconds_d'
            type: 'string'
          }
          {
            name: 'details_response_body_jwt_configuration_secret_encoded_b'
            type: 'string'
          }
          {
            name: 'details_response_body_name_s'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_cannot_change_enforce_client_authentication_on_passwordless_start_b'
            type: 'string'
          }
          {
            name: 'details_response_body_flags_allow_changing_enable_sso_b'
            type: 'string'
          }
          {
            name: 'details_response_body_error_page_url_s'
            type: 'string'
          }
          {
            name: 'details_response_body_enabled_locales_s'
            type: 'string'
          }
          {
            name: 'details_response_body_app_type_s'
            type: 'string'
          }
          {
            name: 'details_response_body_audience_s'
            type: 'string'
          }
          {
            name: 'details_response_body_BeforeLoginPromptMonitoring_b'
            type: 'string'
          }
          {
            name: 'details_response_body_BeforeLoginPrompt_b'
            type: 'string'
          }
          {
            name: 'details_response_body_bindings_s'
            type: 'string'
          }
          {
            name: 'details_response_body_blocked_b'
            type: 'string'
          }
          {
            name: 'details_response_body_change_password_enabled_b'
            type: 'string'
          }
          {
            name: 'details_response_body_change_password_html_s'
            type: 'string'
          }
          {
            name: 'details_response_body_client_id_s'
            type: 'string'
          }
          {
            name: 'details_response_body_nickname_s'
            type: 'string'
          }
          {
            name: 'details_response_body_client_secret_s'
            type: 'string'
          }
          {
            name: 'details_response_body_cross_origin_auth_b'
            type: 'string'
          }
          {
            name: 'details_response_body_custom_login_page_on_b'
            type: 'string'
          }
          {
            name: 'details_response_body_default_from_address_s'
            type: 'string'
          }
          {
            name: 'details_response_body_default_redirection_uri_s'
            type: 'string'
          }
          {
            name: 'details_response_body_description_s'
            type: 'string'
          }
          {
            name: 'details_response_body_email_s'
            type: 'string'
          }
          {
            name: 'details_response_body_email_verified_b'
            type: 'string'
          }
          {
            name: 'details_response_body_enabled_b'
            type: 'string'
          }
          {
            name: 'details_response_body_enabled_clients_s'
            type: 'string'
          }
          {
            name: 'details_response_body_created_at_t'
            type: 'string'
          }
          {
            name: 'details_response_body_allow_offline_access_b'
            type: 'string'
          }
          {
            name: 'details_response_body_oidc_conformant_b'
            type: 'string'
          }
          {
            name: 'details_response_body_picture_url_s'
            type: 'string'
          }
          {
            name: 'details_response_body_template_s'
            type: 'string'
          }
          {
            name: 'details_response_body_token_endpoint_auth_method_s'
            type: 'string'
          }
          {
            name: 'details_response_body_token_lifetime_d'
            type: 'string'
          }
          {
            name: 'details_response_body_token_lifetime_for_web_d'
            type: 'string'
          }
          {
            name: 'details_response_body_updated_at_t'
            type: 'string'
          }
          {
            name: 'details_response_body_user_id_s'
            type: 'string'
          }
          {
            name: 'details_response_statusCode_d'
            type: 'string'
          }
          {
            name: 'details_title_s'
            type: 'string'
          }
          {
            name: 'hostname_s'
            type: 'string'
          }
          {
            name: 'ip_s'
            type: 'string'
          }
          {
            name: 'isMobile_b'
            type: 'string'
          }
          {
            name: 'log_id_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'scope_s'
            type: 'string'
          }
          {
            name: 'strategy_s'
            type: 'string'
          }
          {
            name: 'strategy_type_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'user_agent_s'
            type: 'string'
          }
          {
            name: 'user_id_s'
            type: 'string'
          }
          {
            name: 'details_response_body_syntax_s'
            type: 'string'
          }
          {
            name: 'details_response_body_support_url_s'
            type: 'string'
          }
          {
            name: 'details_response_body_support_email_s'
            type: 'string'
          }
          {
            name: 'details_response_body_supported_triggers_s'
            type: 'string'
          }
          {
            name: 'details_response_body_policy_s'
            type: 'string'
          }
          {
            name: 'details_response_body_providers_auth0_s'
            type: 'string'
          }
          {
            name: 'details_response_body_providers_recaptcha_enterprise_s'
            type: 'string'
          }
          {
            name: 'details_response_body_providers_recaptcha_v2_s'
            type: 'string'
          }
          {
            name: 'details_response_body_realms_s'
            type: 'string'
          }
          {
            name: 'details_response_body_refresh_token_expiration_type_s'
            type: 'string'
          }
          {
            name: 'details_response_body_refresh_token_idle_token_lifetime_d'
            type: 'string'
          }
          {
            name: 'details_response_body_refresh_token_infinite_idle_token_lifetime_b'
            type: 'string'
          }
          {
            name: 'details_response_body_refresh_token_infinite_token_lifetime_b'
            type: 'string'
          }
          {
            name: 'details_response_body_picture_s'
            type: 'string'
          }
          {
            name: 'details_response_body_refresh_token_leeway_d'
            type: 'string'
          }
          {
            name: 'details_response_body_refresh_token_token_lifetime_d'
            type: 'string'
          }
          {
            name: 'details_response_body_s'
            type: 'string'
          }
          {
            name: 'details_response_body_sandbox_version_s'
            type: 'string'
          }
          {
            name: 'details_response_body_scope_s'
            type: 'string'
          }
          {
            name: 'details_response_body_selected_s'
            type: 'string'
          }
          {
            name: 'details_response_body_signing_alg_s'
            type: 'string'
          }
          {
            name: 'details_response_body_sso_disabled_b'
            type: 'string'
          }
          {
            name: 'details_response_body_strategy_s'
            type: 'string'
          }
          {
            name: 'details_response_body_subject_s'
            type: 'string'
          }
          {
            name: 'details_response_body_refresh_token_rotation_type_s'
            type: 'string'
          }
          {
            name: 'details_response_body_allowed_logout_urls_s'
            type: 'string'
          }
          {
            name: 'details_request_userAgent_s'
            type: 'string'
          }
          {
            name: 'details_request_query_page_d'
            type: 'string'
          }
          {
            name: 'details_query_tenant_s'
            type: 'string'
          }
          {
            name: 'details_query_user_id_s'
            type: 'string'
          }
          {
            name: 'details_request_auth_credentials_jti_g'
            type: 'string'
          }
          {
            name: 'details_request_auth_credentials_scopes_s'
            type: 'string'
          }
          {
            name: 'details_request_auth_scopes_s'
            type: 'string'
          }
          {
            name: 'details_request_auth_strategy_s'
            type: 'string'
          }
          {
            name: 'details_request_auth_subject_s'
            type: 'string'
          }
          {
            name: 'details_request_auth_user_email_s'
            type: 'string'
          }
          {
            name: 'details_request_auth_user_name_s'
            type: 'string'
          }
          {
            name: 'details_request_auth_user_user_id_s'
            type: 'string'
          }
          {
            name: 'details_request_body_allowed_logout_urls_s'
            type: 'string'
          }
          {
            name: 'details_request_body_allow_offline_access_b'
            type: 'string'
          }
          {
            name: 'details_request_body_app_type_s'
            type: 'string'
          }
          {
            name: 'details_request_body_audience_s'
            type: 'string'
          }
          {
            name: 'details_request_body_BeforeLoginPromptMonitoring_b'
            type: 'string'
          }
          {
            name: 'details_request_body_bindings_s'
            type: 'string'
          }
          {
            name: 'details_request_body_blocked_b'
            type: 'string'
          }
          {
            name: 'details_request_body_change_password_enabled_b'
            type: 'string'
          }
          {
            name: 'details_request_body_change_password_html_s'
            type: 'string'
          }
          {
            name: 'details_query_includeEmailInRedirect_b'
            type: 'string'
          }
          {
            name: 'details_query_email_s'
            type: 'string'
          }
          {
            name: 'details_query_connection_s'
            type: 'string'
          }
          {
            name: 'details_query_client_id_s'
            type: 'string'
          }
          {
            name: 'client_id_s'
            type: 'string'
          }
          {
            name: 'client_name_s'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'connection_id_s'
            type: 'string'
          }
          {
            name: 'connection_s'
            type: 'string'
          }
          {
            name: 'date_t'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'details_accessedSecrets_s'
            type: 'string'
          }
          {
            name: 'details_body_client_id_s'
            type: 'string'
          }
          {
            name: 'details_request_body_client_ids_s'
            type: 'string'
          }
          {
            name: 'details_body_connection_s'
            type: 'string'
          }
          {
            name: 'details_body_newPassword_s'
            type: 'string'
          }
          {
            name: 'details_body_password_s'
            type: 'string'
          }
          {
            name: 'details_body_tenant_s'
            type: 'string'
          }
          {
            name: 'details_body_ticket_s'
            type: 'string'
          }
          {
            name: 'details_body_user_id_s'
            type: 'string'
          }
          {
            name: 'details_body_verify_b'
            type: 'string'
          }
          {
            name: 'details_description_rules_s'
            type: 'string'
          }
          {
            name: 'details_description_verified_b'
            type: 'string'
          }
          {
            name: 'details_email_s'
            type: 'string'
          }
          {
            name: 'details_body_email_s'
            type: 'string'
          }
          {
            name: 'details_request_body_client_id_s'
            type: 'string'
          }
          {
            name: 'details_request_body_connection_s'
            type: 'string'
          }
          {
            name: 'details_request_body_default_from_address_s'
            type: 'string'
          }
          {
            name: 'details_request_body_state_s'
            type: 'string'
          }
          {
            name: 'details_request_body_subject_s'
            type: 'string'
          }
          {
            name: 'details_request_body_supported_triggers_s'
            type: 'string'
          }
          {
            name: 'details_request_body_support_email_s'
            type: 'string'
          }
          {
            name: 'details_request_body_support_url_s'
            type: 'string'
          }
          {
            name: 'details_request_body_syntax_s'
            type: 'string'
          }
          {
            name: 'details_request_body_template_s'
            type: 'string'
          }
          {
            name: 'details_request_body_token_endpoint_auth_method_s'
            type: 'string'
          }
          {
            name: 'details_request_body_token_lifetime_d'
            type: 'string'
          }
          {
            name: 'details_request_body_signing_alg_s'
            type: 'string'
          }
          {
            name: 'details_request_body_token_lifetime_for_web_d'
            type: 'string'
          }
          {
            name: 'details_request_body_user_email_s'
            type: 'string'
          }
          {
            name: 'details_request_body_user_id_s'
            type: 'string'
          }
          {
            name: 'details_request_body_verify_password_b'
            type: 'string'
          }
          {
            name: 'details_request_channel_s'
            type: 'string'
          }
          {
            name: 'details_request_ip_s'
            type: 'string'
          }
          {
            name: 'details_request_method_s'
            type: 'string'
          }
          {
            name: 'details_request_path_s'
            type: 'string'
          }
          {
            name: 'details_request_query_is_global_b'
            type: 'string'
          }
          {
            name: 'details_request_query_is_global_s'
            type: 'string'
          }
          {
            name: 'details_request_body_users_s'
            type: 'string'
          }
          {
            name: 'user_name_s'
            type: 'string'
          }
          {
            name: 'details_request_body_selected_s'
            type: 'string'
          }
          {
            name: 'details_request_body_roles_s'
            type: 'string'
          }
          {
            name: 'details_request_body_default_redirection_uri_s'
            type: 'string'
          }
          {
            name: 'details_request_body_description_s'
            type: 'string'
          }
          {
            name: 'details_request_body_email_s'
            type: 'string'
          }
          {
            name: 'details_request_body_enabled_b'
            type: 'string'
          }
          {
            name: 'details_request_body_enabled_clients_s'
            type: 'string'
          }
          {
            name: 'details_request_body_error_page_url_s'
            type: 'string'
          }
          {
            name: 'details_request_body_friendly_name_s'
            type: 'string'
          }
          {
            name: 'details_request_body_from_s'
            type: 'string'
          }
          {
            name: 'details_request_body_grant_types_s'
            type: 'string'
          }
          {
            name: 'details_request_body_scope_s'
            type: 'string'
          }
          {
            name: 'details_request_body_identifier_s'
            type: 'string'
          }
          {
            name: 'details_request_body_jwt_configuration_alg_s'
            type: 'string'
          }
          {
            name: 'details_request_body_jwt_configuration_lifetime_in_seconds_d'
            type: 'string'
          }
          {
            name: 'details_request_body_name_s'
            type: 'string'
          }
          {
            name: 'details_request_body_oidc_conformant_b'
            type: 'string'
          }
          {
            name: 'details_request_body_owners_s'
            type: 'string'
          }
          {
            name: 'details_request_body_password_s'
            type: 'string'
          }
          {
            name: 'details_request_body_picture_url_s'
            type: 'string'
          }
          {
            name: 'details_request_body_policy_s'
            type: 'string'
          }
          {
            name: 'details_request_body_providers_auth0_s'
            type: 'string'
          }
          {
            name: 'details_request_body_is_first_party_b'
            type: 'string'
          }
          {
            name: 'geo_info_from_ip_address'
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
          name: 'Sentinel-Auth0AM_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Auth0AM_CL']
        destinations: ['Sentinel-Auth0AM_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), audience_s = tostring(audience_s), details_response_body_flags_disable_clickjack_protection_headers_b = tobool(details_response_body_flags_disable_clickjack_protection_headers_b), details_response_body_flags_disable_impersonation_b = tobool(details_response_body_flags_disable_impersonation_b), details_response_body_flags_enable_sso_b = tobool(details_response_body_flags_enable_sso_b), details_response_body_flags_enforce_client_authentication_on_passwordless_start_b = tobool(details_response_body_flags_enforce_client_authentication_on_passwordless_start_b), details_response_body_flags_revoke_refresh_token_grant_b = tobool(details_response_body_flags_revoke_refresh_token_grant_b), details_response_body_flags_universal_login_b = tobool(details_response_body_flags_universal_login_b), details_response_body_friendly_name_s = tostring(details_response_body_friendly_name_s), details_response_body_from_s = tostring(details_response_body_from_s), details_response_body_grant_types_s = tostring(details_response_body_grant_types_s), details_response_body_guardian_mfa_page_s = tostring(details_response_body_guardian_mfa_page_s), details_response_body_identifier_s = tostring(details_response_body_identifier_s), details_response_body_identities_s = tostring(details_response_body_identities_s), details_response_body_id_s = tostring(details_response_body_id_s), details_response_body_is_first_party_b = tobool(details_response_body_is_first_party_b), details_response_body_is_token_endpoint_ip_header_trusted_b = tobool(details_response_body_is_token_endpoint_ip_header_trusted_b), details_response_body_jwt_configuration_alg_s = tostring(details_response_body_jwt_configuration_alg_s), details_response_body_jwt_configuration_lifetime_in_seconds_d = toreal(details_response_body_jwt_configuration_lifetime_in_seconds_d), details_response_body_jwt_configuration_secret_encoded_b = tobool(details_response_body_jwt_configuration_secret_encoded_b), details_response_body_name_s = tostring(details_response_body_name_s), details_response_body_flags_cannot_change_enforce_client_authentication_on_passwordless_start_b = tobool(details_response_body_flags_cannot_change_enforce_client_authentication_on_passwordless_start_b), details_response_body_flags_allow_changing_enable_sso_b = tobool(details_response_body_flags_allow_changing_enable_sso_b), details_response_body_error_page_url_s = tostring(details_response_body_error_page_url_s), details_response_body_enabled_locales_s = tostring(details_response_body_enabled_locales_s), details_response_body_app_type_s = tostring(details_response_body_app_type_s), details_response_body_audience_s = tostring(details_response_body_audience_s), details_response_body_BeforeLoginPromptMonitoring_b = tobool(details_response_body_BeforeLoginPromptMonitoring_b), details_response_body_BeforeLoginPrompt_b = tobool(details_response_body_BeforeLoginPrompt_b), details_response_body_bindings_s = tostring(details_response_body_bindings_s), details_response_body_blocked_b = tobool(details_response_body_blocked_b), details_response_body_change_password_enabled_b = tobool(details_response_body_change_password_enabled_b), details_response_body_change_password_html_s = tostring(details_response_body_change_password_html_s), details_response_body_client_id_s = tostring(details_response_body_client_id_s), details_response_body_nickname_s = tostring(details_response_body_nickname_s), details_response_body_client_secret_s = tostring(details_response_body_client_secret_s), details_response_body_cross_origin_auth_b = tobool(details_response_body_cross_origin_auth_b), details_response_body_custom_login_page_on_b = tobool(details_response_body_custom_login_page_on_b), details_response_body_default_from_address_s = tostring(details_response_body_default_from_address_s), details_response_body_default_redirection_uri_s = tostring(details_response_body_default_redirection_uri_s), details_response_body_description_s = tostring(details_response_body_description_s), details_response_body_email_s = tostring(details_response_body_email_s), details_response_body_email_verified_b = tobool(details_response_body_email_verified_b), details_response_body_enabled_b = tobool(details_response_body_enabled_b), details_response_body_enabled_clients_s = tostring(details_response_body_enabled_clients_s), details_response_body_created_at_t = todatetime(details_response_body_created_at_t), details_response_body_allow_offline_access_b = tobool(details_response_body_allow_offline_access_b), details_response_body_oidc_conformant_b = tobool(details_response_body_oidc_conformant_b), details_response_body_picture_url_s = tostring(details_response_body_picture_url_s), details_response_body_template_s = tostring(details_response_body_template_s), details_response_body_token_endpoint_auth_method_s = tostring(details_response_body_token_endpoint_auth_method_s), details_response_body_token_lifetime_d = toreal(details_response_body_token_lifetime_d), details_response_body_token_lifetime_for_web_d = toreal(details_response_body_token_lifetime_for_web_d), details_response_body_updated_at_t = todatetime(details_response_body_updated_at_t), details_response_body_user_id_s = tostring(details_response_body_user_id_s), details_response_statusCode_d = toreal(details_response_statusCode_d), details_title_s = tostring(details_title_s), hostname_s = tostring(hostname_s), ip_s = tostring(ip_s), isMobile_b = tobool(isMobile_b), log_id_s = tostring(log_id_s), RawData = tostring(RawData), scope_s = tostring(scope_s), strategy_s = tostring(strategy_s), strategy_type_s = tostring(strategy_type_s), type_s = tostring(type_s), user_agent_s = tostring(user_agent_s), user_id_s = tostring(user_id_s), details_response_body_syntax_s = tostring(details_response_body_syntax_s), details_response_body_support_url_s = tostring(details_response_body_support_url_s), details_response_body_support_email_s = tostring(details_response_body_support_email_s), details_response_body_supported_triggers_s = tostring(details_response_body_supported_triggers_s), details_response_body_policy_s = tostring(details_response_body_policy_s), details_response_body_providers_auth0_s = tostring(details_response_body_providers_auth0_s), details_response_body_providers_recaptcha_enterprise_s = tostring(details_response_body_providers_recaptcha_enterprise_s), details_response_body_providers_recaptcha_v2_s = tostring(details_response_body_providers_recaptcha_v2_s), details_response_body_realms_s = tostring(details_response_body_realms_s), details_response_body_refresh_token_expiration_type_s = tostring(details_response_body_refresh_token_expiration_type_s), details_response_body_refresh_token_idle_token_lifetime_d = toreal(details_response_body_refresh_token_idle_token_lifetime_d), details_response_body_refresh_token_infinite_idle_token_lifetime_b = tobool(details_response_body_refresh_token_infinite_idle_token_lifetime_b), details_response_body_refresh_token_infinite_token_lifetime_b = tobool(details_response_body_refresh_token_infinite_token_lifetime_b), details_response_body_picture_s = tostring(details_response_body_picture_s), details_response_body_refresh_token_leeway_d = toreal(details_response_body_refresh_token_leeway_d), details_response_body_refresh_token_token_lifetime_d = toreal(details_response_body_refresh_token_token_lifetime_d), details_response_body_s = tostring(details_response_body_s), details_response_body_sandbox_version_s = tostring(details_response_body_sandbox_version_s), details_response_body_scope_s = tostring(details_response_body_scope_s), details_response_body_selected_s = tostring(details_response_body_selected_s), details_response_body_signing_alg_s = tostring(details_response_body_signing_alg_s), details_response_body_sso_disabled_b = tobool(details_response_body_sso_disabled_b), details_response_body_strategy_s = tostring(details_response_body_strategy_s), details_response_body_subject_s = tostring(details_response_body_subject_s), details_response_body_refresh_token_rotation_type_s = tostring(details_response_body_refresh_token_rotation_type_s), details_response_body_allowed_logout_urls_s = tostring(details_response_body_allowed_logout_urls_s), details_request_userAgent_s = tostring(details_request_userAgent_s), details_request_query_page_d = toreal(details_request_query_page_d), details_query_tenant_s = tostring(details_query_tenant_s), details_query_user_id_s = tostring(details_query_user_id_s), details_request_auth_credentials_jti_g = tostring(details_request_auth_credentials_jti_g), details_request_auth_credentials_scopes_s = tostring(details_request_auth_credentials_scopes_s), details_request_auth_scopes_s = tostring(details_request_auth_scopes_s), details_request_auth_strategy_s = tostring(details_request_auth_strategy_s), details_request_auth_subject_s = tostring(details_request_auth_subject_s), details_request_auth_user_email_s = tostring(details_request_auth_user_email_s), details_request_auth_user_name_s = tostring(details_request_auth_user_name_s), details_request_auth_user_user_id_s = tostring(details_request_auth_user_user_id_s), details_request_body_allowed_logout_urls_s = tostring(details_request_body_allowed_logout_urls_s), details_request_body_allow_offline_access_b = tobool(details_request_body_allow_offline_access_b), details_request_body_app_type_s = tostring(details_request_body_app_type_s), details_request_body_audience_s = tostring(details_request_body_audience_s), details_request_body_BeforeLoginPromptMonitoring_b = tobool(details_request_body_BeforeLoginPromptMonitoring_b), details_request_body_bindings_s = tostring(details_request_body_bindings_s), details_request_body_blocked_b = tobool(details_request_body_blocked_b), details_request_body_change_password_enabled_b = tobool(details_request_body_change_password_enabled_b), details_request_body_change_password_html_s = tostring(details_request_body_change_password_html_s), details_query_includeEmailInRedirect_b = tobool(details_query_includeEmailInRedirect_b), details_query_email_s = tostring(details_query_email_s), details_query_connection_s = tostring(details_query_connection_s), details_query_client_id_s = tostring(details_query_client_id_s), client_id_s = tostring(client_id_s), client_name_s = tostring(client_name_s), Computer = tostring(Computer), connection_id_s = tostring(connection_id_s), connection_s = tostring(connection_s), date_t = todatetime(date_t), description_s = tostring(description_s), details_accessedSecrets_s = tostring(details_accessedSecrets_s), details_body_client_id_s = tostring(details_body_client_id_s), details_request_body_client_ids_s = tostring(details_request_body_client_ids_s), details_body_connection_s = tostring(details_body_connection_s), details_body_newPassword_s = tostring(details_body_newPassword_s), details_body_password_s = tostring(details_body_password_s), details_body_tenant_s = tostring(details_body_tenant_s), details_body_ticket_s = tostring(details_body_ticket_s), details_body_user_id_s = tostring(details_body_user_id_s), details_body_verify_b = tobool(details_body_verify_b), details_description_rules_s = tostring(details_description_rules_s), details_description_verified_b = tobool(details_description_verified_b), details_email_s = tostring(details_email_s), details_body_email_s = tostring(details_body_email_s), details_request_body_client_id_s = tostring(details_request_body_client_id_s), details_request_body_connection_s = tostring(details_request_body_connection_s), details_request_body_default_from_address_s = tostring(details_request_body_default_from_address_s), details_request_body_state_s = tostring(details_request_body_state_s), details_request_body_subject_s = tostring(details_request_body_subject_s), details_request_body_supported_triggers_s = tostring(details_request_body_supported_triggers_s), details_request_body_support_email_s = tostring(details_request_body_support_email_s), details_request_body_support_url_s = tostring(details_request_body_support_url_s), details_request_body_syntax_s = tostring(details_request_body_syntax_s), details_request_body_template_s = tostring(details_request_body_template_s), details_request_body_token_endpoint_auth_method_s = tostring(details_request_body_token_endpoint_auth_method_s), details_request_body_token_lifetime_d = toreal(details_request_body_token_lifetime_d), details_request_body_signing_alg_s = tostring(details_request_body_signing_alg_s), details_request_body_token_lifetime_for_web_d = toreal(details_request_body_token_lifetime_for_web_d), details_request_body_user_email_s = tostring(details_request_body_user_email_s), details_request_body_user_id_s = tostring(details_request_body_user_id_s), details_request_body_verify_password_b = tobool(details_request_body_verify_password_b), details_request_channel_s = tostring(details_request_channel_s), details_request_ip_s = tostring(details_request_ip_s), details_request_method_s = tostring(details_request_method_s), details_request_path_s = tostring(details_request_path_s), details_request_query_is_global_b = tobool(details_request_query_is_global_b), details_request_query_is_global_s = tostring(details_request_query_is_global_s), details_request_body_users_s = tostring(details_request_body_users_s), user_name_s = tostring(user_name_s), details_request_body_selected_s = tostring(details_request_body_selected_s), details_request_body_roles_s = tostring(details_request_body_roles_s), details_request_body_default_redirection_uri_s = tostring(details_request_body_default_redirection_uri_s), details_request_body_description_s = tostring(details_request_body_description_s), details_request_body_email_s = tostring(details_request_body_email_s), details_request_body_enabled_b = tobool(details_request_body_enabled_b), details_request_body_enabled_clients_s = tostring(details_request_body_enabled_clients_s), details_request_body_error_page_url_s = tostring(details_request_body_error_page_url_s), details_request_body_friendly_name_s = tostring(details_request_body_friendly_name_s), details_request_body_from_s = tostring(details_request_body_from_s), details_request_body_grant_types_s = tostring(details_request_body_grant_types_s), details_request_body_scope_s = tostring(details_request_body_scope_s), details_request_body_identifier_s = tostring(details_request_body_identifier_s), details_request_body_jwt_configuration_alg_s = tostring(details_request_body_jwt_configuration_alg_s), details_request_body_jwt_configuration_lifetime_in_seconds_d = toreal(details_request_body_jwt_configuration_lifetime_in_seconds_d), details_request_body_name_s = tostring(details_request_body_name_s), details_request_body_oidc_conformant_b = tobool(details_request_body_oidc_conformant_b), details_request_body_owners_s = tostring(details_request_body_owners_s), details_request_body_password_s = tostring(details_request_body_password_s), details_request_body_picture_url_s = tostring(details_request_body_picture_url_s), details_request_body_policy_s = tostring(details_request_body_policy_s), details_request_body_providers_auth0_s = tostring(details_request_body_providers_auth0_s), details_request_body_is_first_party_b = tobool(details_request_body_is_first_party_b), geo_info_from_ip_address = tostring(geo_info_from_ip_address)'
        outputStream: 'Custom-Auth0AM_CL'
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
