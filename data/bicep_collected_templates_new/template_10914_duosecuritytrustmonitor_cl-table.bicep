// Bicep template for Log Analytics custom table: DuoSecurityTrustMonitor_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 44, Deployed columns: 44 (Type column filtered)
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

resource duosecuritytrustmonitorclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DuoSecurityTrustMonitor_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DuoSecurityTrustMonitor_CL'
      description: 'Custom table DuoSecurityTrustMonitor_CL - imported from JSON schema'
      displayName: 'DuoSecurityTrustMonitor_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'explanations_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_email_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_factor_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_isotimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'surfaced_auth_ood_software_s'
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
          name: 'surfaced_auth_txid_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_application_name_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_user_groups_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_user_name_s'
          type: 'string'
        }
        {
          name: 'surfaced_timestamp_d'
          type: 'real'
        }
        {
          name: 'triage_event_uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'triaged_as_interesting_b'
          type: 'boolean'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'bypass_status_enabled_d'
          type: 'real'
        }
        {
          name: 'enabled_by_key_s'
          type: 'string'
        }
        {
          name: 'enabled_by_name_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_user_key_s'
          type: 'string'
        }
        {
          name: 'enabled_for_key_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_application_key_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_security_agents_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'from_common_netblock_b'
          type: 'boolean'
        }
        {
          name: 'from_new_user_b'
          type: 'boolean'
        }
        {
          name: 'low_risk_ip_b'
          type: 'boolean'
        }
        {
          name: 'priority_event_b'
          type: 'boolean'
        }
        {
          name: 'priority_reasons_s'
          type: 'string'
        }
        {
          name: 'sekey_s'
          type: 'string'
        }
        {
          name: 'state_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_browser_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_alias_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_browser_version_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_is_encryption_enabled_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_is_firewall_enabled_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_is_password_set_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_location_city_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_location_country_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_location_state_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_os_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_os_version_s'
          type: 'string'
        }
        {
          name: 'surfaced_auth_access_device_ip_s'
          type: 'string'
        }
        {
          name: 'enabled_for_name_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = duosecuritytrustmonitorclTable.name
output tableId string = duosecuritytrustmonitorclTable.id
output provisioningState string = duosecuritytrustmonitorclTable.properties.provisioningState
