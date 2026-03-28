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
// Data Collection Rule for DuoSecurityTrustMonitor_CL
// ============================================================================
// Generated: 2025-09-19 14:20:17
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 44, DCR columns: 44 (Type column always filtered)
// Output stream: Custom-DuoSecurityTrustMonitor_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DuoSecurityTrustMonitor_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DuoSecurityTrustMonitor_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'triage_event_uri_s'
            type: 'string'
          }
          {
            name: 'triaged_as_interesting_b'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'bypass_status_enabled_d'
            type: 'string'
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
          }
          {
            name: 'from_common_netblock_b'
            type: 'string'
          }
          {
            name: 'from_new_user_b'
            type: 'string'
          }
          {
            name: 'low_risk_ip_b'
            type: 'string'
          }
          {
            name: 'priority_event_b'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-DuoSecurityTrustMonitor_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DuoSecurityTrustMonitor_CL']
        destinations: ['Sentinel-DuoSecurityTrustMonitor_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), explanations_s = tostring(explanations_s), surfaced_auth_email_s = tostring(surfaced_auth_email_s), surfaced_auth_factor_s = tostring(surfaced_auth_factor_s), surfaced_auth_isotimestamp_t = todatetime(surfaced_auth_isotimestamp_t), surfaced_auth_ood_software_s = tostring(surfaced_auth_ood_software_s), surfaced_auth_reason_s = tostring(surfaced_auth_reason_s), surfaced_auth_result_s = tostring(surfaced_auth_result_s), surfaced_auth_timestamp_d = toreal(surfaced_auth_timestamp_d), surfaced_auth_txid_s = tostring(surfaced_auth_txid_s), surfaced_auth_application_name_s = tostring(surfaced_auth_application_name_s), surfaced_auth_user_groups_s = tostring(surfaced_auth_user_groups_s), surfaced_auth_user_name_s = tostring(surfaced_auth_user_name_s), surfaced_timestamp_d = toreal(surfaced_timestamp_d), triage_event_uri_s = tostring(triage_event_uri_s), triaged_as_interesting_b = tobool(triaged_as_interesting_b), type_s = tostring(type_s), bypass_status_enabled_d = toreal(bypass_status_enabled_d), enabled_by_key_s = tostring(enabled_by_key_s), enabled_by_name_s = tostring(enabled_by_name_s), surfaced_auth_user_key_s = tostring(surfaced_auth_user_key_s), enabled_for_key_s = tostring(enabled_for_key_s), surfaced_auth_application_key_s = tostring(surfaced_auth_application_key_s), surfaced_auth_access_device_security_agents_s = tostring(surfaced_auth_access_device_security_agents_s), from_common_netblock_b = tobool(from_common_netblock_b), from_new_user_b = tobool(from_new_user_b), low_risk_ip_b = tobool(low_risk_ip_b), priority_event_b = tobool(priority_event_b), priority_reasons_s = tostring(priority_reasons_s), sekey_s = tostring(sekey_s), state_s = tostring(state_s), surfaced_auth_access_device_browser_s = tostring(surfaced_auth_access_device_browser_s), surfaced_auth_alias_s = tostring(surfaced_auth_alias_s), surfaced_auth_access_device_browser_version_s = tostring(surfaced_auth_access_device_browser_version_s), surfaced_auth_access_device_is_encryption_enabled_s = tostring(surfaced_auth_access_device_is_encryption_enabled_s), surfaced_auth_access_device_is_firewall_enabled_s = tostring(surfaced_auth_access_device_is_firewall_enabled_s), surfaced_auth_access_device_is_password_set_s = tostring(surfaced_auth_access_device_is_password_set_s), surfaced_auth_access_device_location_city_s = tostring(surfaced_auth_access_device_location_city_s), surfaced_auth_access_device_location_country_s = tostring(surfaced_auth_access_device_location_country_s), surfaced_auth_access_device_location_state_s = tostring(surfaced_auth_access_device_location_state_s), surfaced_auth_access_device_os_s = tostring(surfaced_auth_access_device_os_s), surfaced_auth_access_device_os_version_s = tostring(surfaced_auth_access_device_os_version_s), surfaced_auth_access_device_ip_s = tostring(surfaced_auth_access_device_ip_s), enabled_for_name_s = tostring(enabled_for_name_s)'
        outputStream: 'Custom-DuoSecurityTrustMonitor_CL'
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
