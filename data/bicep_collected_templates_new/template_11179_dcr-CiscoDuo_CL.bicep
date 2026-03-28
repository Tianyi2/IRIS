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
// Data Collection Rule for CiscoDuo_CL
// ============================================================================
// Generated: 2025-09-19 14:19:59
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 82, DCR columns: 82 (Type column always filtered)
// Output stream: Custom-CiscoDuo_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CiscoDuo_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CiscoDuo_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'timestamp_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'triage_event_uri_s'
            type: 'string'
          }
          {
            name: 'surfaced_timestamp_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'access_device_is_firewall_enabled_b'
            type: 'string'
          }
          {
            name: 'access_device_is_encryption_enabled_b'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'low_risk_ip_b'
            type: 'string'
          }
          {
            name: 'from_new_user_b'
            type: 'string'
          }
          {
            name: 'from_common_netblock_b'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-CiscoDuo_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CiscoDuo_CL']
        destinations: ['Sentinel-CiscoDuo_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), access_device_browser_s = tostring(access_device_browser_s), surfaced_auth_isotimestamp_t = tostring(surfaced_auth_isotimestamp_t), surfaced_auth_factor_s = tostring(surfaced_auth_factor_s), surfaced_auth_email_s = tostring(surfaced_auth_email_s), surfaced_auth_application_name_s = tostring(surfaced_auth_application_name_s), surfaced_auth_application_key_s = tostring(surfaced_auth_application_key_s), surfaced_auth_alias_s = tostring(surfaced_auth_alias_s), surfaced_auth_access_device_security_agents_s = tostring(surfaced_auth_access_device_security_agents_s), surfaced_auth_ood_software_s = tostring(surfaced_auth_ood_software_s), surfaced_auth_access_device_os_version_s = tostring(surfaced_auth_access_device_os_version_s), surfaced_auth_access_device_location_state_s = tostring(surfaced_auth_access_device_location_state_s), surfaced_auth_access_device_location_country_s = tostring(surfaced_auth_access_device_location_country_s), surfaced_auth_access_device_location_city_s = tostring(surfaced_auth_access_device_location_city_s), surfaced_auth_access_device_is_password_set_s = tostring(surfaced_auth_access_device_is_password_set_s), surfaced_auth_access_device_is_firewall_enabled_s = tostring(surfaced_auth_access_device_is_firewall_enabled_s), surfaced_auth_access_device_is_encryption_enabled_s = tostring(surfaced_auth_access_device_is_encryption_enabled_s), surfaced_auth_access_device_ip_s = tostring(surfaced_auth_access_device_ip_s), surfaced_auth_access_device_os_s = tostring(surfaced_auth_access_device_os_s), surfaced_auth_reason_s = tostring(surfaced_auth_reason_s), surfaced_auth_result_s = tostring(surfaced_auth_result_s), surfaced_auth_timestamp_d = toreal(surfaced_auth_timestamp_d), type_s = tostring(type_s), timestamp_d = toreal(timestamp_d), phone_s = tostring(phone_s), isotimestamp_t = tostring(isotimestamp_t), credits_d = toreal(credits_d), context_s = tostring(context_s), object_s = tostring(object_s), username_s = tostring(username_s), description_s = tostring(description_s), action_s = tostring(action_s), triaged_as_interesting_b = tobool(triaged_as_interesting_b), triage_event_uri_s = tostring(triage_event_uri_s), surfaced_timestamp_d = toreal(surfaced_timestamp_d), surfaced_auth_user_name_s = tostring(surfaced_auth_user_name_s), surfaced_auth_user_key_s = tostring(surfaced_auth_user_key_s), surfaced_auth_user_groups_s = tostring(surfaced_auth_user_groups_s), surfaced_auth_txid_s = tostring(surfaced_auth_txid_s), surfaced_auth_access_device_browser_version_s = tostring(surfaced_auth_access_device_browser_version_s), eventtype_s = tostring(eventtype_s), surfaced_auth_access_device_browser_s = tostring(surfaced_auth_access_device_browser_s), sekey_s = tostring(sekey_s), application_name_s = tostring(application_name_s), application_key_s = tostring(application_key_s), alias_s = tostring(alias_s), access_device_security_agents_s = tostring(access_device_security_agents_s), access_device_os_version_s = tostring(access_device_os_version_s), access_device_os_s = tostring(access_device_os_s), access_device_location_state_s = tostring(access_device_location_state_s), auth_device_ip_s = tostring(auth_device_ip_s), access_device_location_country_s = tostring(access_device_location_country_s), access_device_java_version_s = tostring(access_device_java_version_s), access_device_is_password_set_b = tobool(access_device_is_password_set_b), access_device_is_firewall_enabled_b = tobool(access_device_is_firewall_enabled_b), access_device_is_encryption_enabled_b = tobool(access_device_is_encryption_enabled_b), access_device_ip_s = tostring(access_device_ip_s), access_device_flash_version_s = tostring(access_device_flash_version_s), access_device_browser_version_s = tostring(access_device_browser_version_s), access_device_location_city_s = tostring(access_device_location_city_s), auth_device_location_city_s = tostring(auth_device_location_city_s), auth_device_location_country_s = tostring(auth_device_location_country_s), auth_device_location_state_s = tostring(auth_device_location_state_s), priority_reasons_s = tostring(priority_reasons_s), priority_event_b = tobool(priority_event_b), low_risk_ip_b = tobool(low_risk_ip_b), from_new_user_b = tobool(from_new_user_b), from_common_netblock_b = tobool(from_common_netblock_b), explanations_s = tostring(explanations_s), user_name_s = tostring(user_name_s), user_key_s = tostring(user_key_s), user_groups_s = tostring(user_groups_s), txid_g = tostring(txid_g), trusted_endpoint_status_s = tostring(trusted_endpoint_status_s), result_s = tostring(result_s), reason_s = tostring(reason_s), factor_s = tostring(factor_s), event_type_s = tostring(event_type_s), email_s = tostring(email_s), auth_device_name_s = tostring(auth_device_name_s), state_s = tostring(state_s), host_s = tostring(host_s)'
        outputStream: 'Custom-CiscoDuo_CL'
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
