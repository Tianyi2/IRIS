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
// Data Collection Rule for DuoSecurityAuthentication_CL
// ============================================================================
// Generated: 2025-09-19 14:20:17
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 27, DCR columns: 27 (Type column always filtered)
// Output stream: Custom-DuoSecurityAuthentication_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DuoSecurityAuthentication_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DuoSecurityAuthentication_CL': {
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
            name: 'timestamp_d'
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
            name: 'isotimestamp_t'
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
            name: 'access_device_location_country_s'
            type: 'string'
          }
          {
            name: 'access_device_location_city_s'
            type: 'string'
          }
          {
            name: 'access_device_is_password_set_s'
            type: 'string'
          }
          {
            name: 'access_device_is_firewall_enabled_s'
            type: 'string'
          }
          {
            name: 'access_device_is_encryption_enabled_s'
            type: 'string'
          }
          {
            name: 'access_device_ip_s'
            type: 'string'
          }
          {
            name: 'access_device_browser_version_s'
            type: 'string'
          }
          {
            name: 'auth_device_name_s'
            type: 'string'
          }
          {
            name: 'factor_s'
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
          name: 'Sentinel-DuoSecurityAuthentication_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DuoSecurityAuthentication_CL']
        destinations: ['Sentinel-DuoSecurityAuthentication_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), access_device_browser_s = tostring(access_device_browser_s), user_name_s = tostring(user_name_s), user_key_s = tostring(user_key_s), user_groups_s = tostring(user_groups_s), txid_g = tostring(txid_g), timestamp_d = toreal(timestamp_d), result_s = tostring(result_s), reason_s = tostring(reason_s), isotimestamp_t = todatetime(isotimestamp_t), event_type_s = tostring(event_type_s), email_s = tostring(email_s), application_name_s = tostring(application_name_s), application_key_s = tostring(application_key_s), alias_s = tostring(alias_s), access_device_os_version_s = tostring(access_device_os_version_s), access_device_os_s = tostring(access_device_os_s), access_device_location_state_s = tostring(access_device_location_state_s), access_device_location_country_s = tostring(access_device_location_country_s), access_device_location_city_s = tostring(access_device_location_city_s), access_device_is_password_set_s = tostring(access_device_is_password_set_s), access_device_is_firewall_enabled_s = tostring(access_device_is_firewall_enabled_s), access_device_is_encryption_enabled_s = tostring(access_device_is_encryption_enabled_s), access_device_ip_s = tostring(access_device_ip_s), access_device_browser_version_s = tostring(access_device_browser_version_s), auth_device_name_s = tostring(auth_device_name_s), factor_s = tostring(factor_s)'
        outputStream: 'Custom-DuoSecurityAuthentication_CL'
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
