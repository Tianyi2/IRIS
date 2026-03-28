// Bicep template for Log Analytics custom table: CiscoDuo_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 82, Deployed columns: 82 (Type column filtered)
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

resource ciscoduoclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CiscoDuo_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CiscoDuo_CL'
      description: 'Custom table CiscoDuo_CL - imported from JSON schema'
      displayName: 'CiscoDuo_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'access_device_browser_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_isotimestamp_t'
          type: 'string'
        }
        {
          name: 'surfaced_auth_factor_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_email_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_application_name_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_application_key_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_alias_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_security_agents_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'surfaced_auth_ood_software_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_os_version_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_location_state_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_location_country_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_location_city_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_is_password_set_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_is_firewall_enabled_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_is_encryption_enabled_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_ip_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_os_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_reason_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_result_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_timestamp_d'
          type: 'real'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'timestamp_d'
          type: 'real'
        }
        {
          name: 'phone_s'
          type: 'string'
        }
        {
          name: 'isotimestamp_t'
          type: 'string'
        }
        {
          name: 'credits_d'
          type: 'real'
        }
        {
          name: 'context_s'
          type: 'string'
        }
        {
          name: 'object_s'
          type: 'string'
        }
        {
          name: 'username_s'
          type: 'string'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'triaged_as_interesting_b'
          type: 'boolean'
        }
        {
          name: 'triage_event_uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'surfaced_timestamp_d'
          type: 'real'
        }
        {
          name: 'surfaced_auth_user_name_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_user_key_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_user_groups_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_txid_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_browser_version_s'
          type: 'string'
        }
        {
          name: 'eventtype_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_browser_s'
          type: 'string'
        }
        {
          name: 'sekey_s'
          type: 'string'
        }
        {
          name: 'application_name_s'
          type: 'string'
        }
        {
          name: 'application_key_s'
          type: 'string'
        }
        {
          name: 'alias_s'
          type: 'string'
        }
        {
          name: 'access_device_security_agents_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'access_device_os_version_s'
          type: 'string'
        }
        {
          name: 'access_device_os_s'
          type: 'string'
        }
        {
          name: 'access_device_location_state_s'
          type: 'string'
        }
        {
          name: 'auth_device_ip_s'
          type: 'string'
        }
        {
          name: 'access_device_location_country_s'
          type: 'string'
        }
        {
          name: 'access_device_java_version_s'
          type: 'string'
        }
        {
          name: 'access_device_is_password_set_b'
          type: 'boolean'
        }
        {
          name: 'access_device_is_firewall_enabled_b'
          type: 'boolean'
        }
        {
          name: 'access_device_is_encryption_enabled_b'
          type: 'boolean'
        }
        {
          name: 'access_device_ip_s'
          type: 'string'
        }
        {
          name: 'access_device_flash_version_s'
          type: 'string'
        }
        {
          name: 'access_device_browser_version_s'
          type: 'string'
        }
        {
          name: 'access_device_location_city_s'
          type: 'string'
        }
        {
          name: 'auth_device_location_city_s'
          type: 'string'
        }
        {
          name: 'auth_device_location_country_s'
          type: 'string'
        }
        {
          name: 'auth_device_location_state_s'
          type: 'string'
        }
        {
          name: 'priority_reasons_s'
          type: 'string'
        }
        {
          name: 'priority_event_b'
          type: 'boolean'
        }
        {
          name: 'low_risk_ip_b'
          type: 'boolean'
        }
        {
          name: 'from_new_user_b'
          type: 'boolean'
        }
        {
          name: 'from_common_netblock_b'
          type: 'boolean'
        }
        {
          name: 'explanations_s'
          type: 'string'
        }
        {
          name: 'user_name_s'
          type: 'string'
        }
        {
          name: 'user_key_s'
          type: 'string'
        }
        {
          name: 'user_groups_s'
          type: 'string'
        }
        {
          name: 'txid_g'
          type: 'string'
        }
        {
          name: 'trusted_endpoint_status_s'
          type: 'string'
        }
        {
          name: 'result_s'
          type: 'string'
        }
        {
          name: 'reason_s'
          type: 'string'
        }
        {
          name: 'factor_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'email_s'
          type: 'string'
        }
        {
          name: 'auth_device_name_s'
          type: 'string'
        }
        {
          name: 'state_s'
          type: 'string'
        }
        {
          name: 'host_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ciscoduoclTable.name
output tableId string = ciscoduoclTable.id
output provisioningState string = ciscoduoclTable.properties.provisioningState
