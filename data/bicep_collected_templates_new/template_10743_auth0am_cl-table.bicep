// Bicep template for Log Analytics custom table: Auth0AM_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 193, Deployed columns: 189 (Type column filtered)
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

resource auth0amclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Auth0AM_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Auth0AM_CL'
      description: 'Custom table Auth0AM_CL - imported from JSON schema'
      displayName: 'Auth0AM_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'audience_s'
          type: 'string'
        }
        {
          name: 'details_response_body_flags_disable_clickjack_protection_headers_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_flags_disable_impersonation_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_flags_enable_sso_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_flags_enforce_client_authentication_on_passwordless_start_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_flags_revoke_refresh_token_grant_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_flags_universal_login_b'
          type: 'boolean'
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
          type: 'boolean'
        }
        {
          name: 'details_response_body_is_token_endpoint_ip_header_trusted_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_jwt_configuration_alg_s'
          type: 'string'
        }
        {
          name: 'details_response_body_jwt_configuration_lifetime_in_seconds_d'
          type: 'real'
        }
        {
          name: 'details_response_body_jwt_configuration_secret_encoded_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_name_s'
          type: 'string'
        }
        {
          name: 'details_response_body_flags_cannot_change_enforce_client_authentication_on_passwordless_start_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_flags_allow_changing_enable_sso_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_error_page_url_s'
          type: 'string'
          dataTypeHint: 0
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
          type: 'boolean'
        }
        {
          name: 'details_response_body_BeforeLoginPrompt_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_bindings_s'
          type: 'string'
        }
        {
          name: 'details_response_body_blocked_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_change_password_enabled_b'
          type: 'boolean'
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
          type: 'boolean'
        }
        {
          name: 'details_response_body_custom_login_page_on_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_default_from_address_s'
          type: 'string'
        }
        {
          name: 'details_response_body_default_redirection_uri_s'
          type: 'string'
          dataTypeHint: 0
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
          type: 'boolean'
        }
        {
          name: 'details_response_body_enabled_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_enabled_clients_s'
          type: 'string'
        }
        {
          name: 'details_response_body_created_at_t'
          type: 'dateTime'
        }
        {
          name: 'details_response_body_allow_offline_access_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_oidc_conformant_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_picture_url_s'
          type: 'string'
          dataTypeHint: 0
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
          type: 'real'
        }
        {
          name: 'details_response_body_token_lifetime_for_web_d'
          type: 'real'
        }
        {
          name: 'details_response_body_updated_at_t'
          type: 'dateTime'
        }
        {
          name: 'details_response_body_user_id_s'
          type: 'string'
        }
        {
          name: 'details_response_statusCode_d'
          type: 'real'
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
          type: 'boolean'
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
          dataTypeHint: 0
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
          type: 'real'
        }
        {
          name: 'details_response_body_refresh_token_infinite_idle_token_lifetime_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_refresh_token_infinite_token_lifetime_b'
          type: 'boolean'
        }
        {
          name: 'details_response_body_picture_s'
          type: 'string'
        }
        {
          name: 'details_response_body_refresh_token_leeway_d'
          type: 'real'
        }
        {
          name: 'details_response_body_refresh_token_token_lifetime_d'
          type: 'real'
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
          type: 'boolean'
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
          dataTypeHint: 0
        }
        {
          name: 'details_request_userAgent_s'
          type: 'string'
        }
        {
          name: 'details_request_query_page_d'
          type: 'real'
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
          dataTypeHint: 0
        }
        {
          name: 'details_request_body_allow_offline_access_b'
          type: 'boolean'
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
          type: 'boolean'
        }
        {
          name: 'details_request_body_bindings_s'
          type: 'string'
        }
        {
          name: 'details_request_body_blocked_b'
          type: 'boolean'
        }
        {
          name: 'details_request_body_change_password_enabled_b'
          type: 'boolean'
        }
        {
          name: 'details_request_body_change_password_html_s'
          type: 'string'
        }
        {
          name: 'details_query_includeEmailInRedirect_b'
          type: 'boolean'
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
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'details_description_rules_s'
          type: 'string'
        }
        {
          name: 'details_description_verified_b'
          type: 'boolean'
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
          dataTypeHint: 0
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
          type: 'real'
        }
        {
          name: 'details_request_body_signing_alg_s'
          type: 'string'
        }
        {
          name: 'details_request_body_token_lifetime_for_web_d'
          type: 'real'
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
          type: 'boolean'
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
          type: 'boolean'
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
          dataTypeHint: 0
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
          type: 'boolean'
        }
        {
          name: 'details_request_body_enabled_clients_s'
          type: 'string'
        }
        {
          name: 'details_request_body_error_page_url_s'
          type: 'string'
          dataTypeHint: 0
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
          type: 'real'
        }
        {
          name: 'details_request_body_name_s'
          type: 'string'
        }
        {
          name: 'details_request_body_oidc_conformant_b'
          type: 'boolean'
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
          dataTypeHint: 0
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
          type: 'boolean'
        }
        {
          name: 'geo_info_from_ip_address'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = auth0amclTable.name
output tableId string = auth0amclTable.id
output provisioningState string = auth0amclTable.properties.provisioningState
