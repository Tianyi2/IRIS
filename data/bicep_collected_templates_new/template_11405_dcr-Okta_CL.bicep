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
// Data Collection Rule for Okta_CL
// ============================================================================
// Generated: 2025-09-19 14:20:27
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 74, DCR columns: 71 (Type column always filtered)
// Output stream: Custom-Okta_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Okta_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Okta_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_deviceFingerprint_g'
            type: 'string'
          }
          {
            name: 'authenticationContext_authenticationProvider_s'
            type: 'string'
          }
          {
            name: 'authenticationContext_credentialProvider_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_factor_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_countryCallingCode_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_smsProvider_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_transactionId_g'
            type: 'string'
          }
          {
            name: 'authenticationContext_credentialType_s'
            type: 'string'
          }
          {
            name: 'actor_id_s'
            type: 'string'
          }
          {
            name: 'actor_type_s'
            type: 'string'
          }
          {
            name: 'actor_alternateId_s'
            type: 'string'
          }
          {
            name: 'actor_displayName_s'
            type: 'string'
          }
          {
            name: 'authenticationContext_authenticationStep_d'
            type: 'string'
          }
          {
            name: 'authenticationContext_externalSessionId_s'
            type: 'string'
          }
          {
            name: 'displayMessage_s'
            type: 'string'
          }
          {
            name: 'eventType_s'
            type: 'string'
          }
          {
            name: 'outcome_result_s'
            type: 'string'
          }
          {
            name: 'request_ipChain_s'
            type: 'string'
          }
          {
            name: 'version_s'
            type: 'string'
          }
          {
            name: 'uuid_g'
            type: 'string'
          }
          {
            name: 'transaction_id_s'
            type: 'string'
          }
          {
            name: 'transaction_type_s'
            type: 'string'
          }
          {
            name: 'legacyEventType_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_url_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_threatSuspected_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_importLastToken_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_appname_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_importType_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_jobId_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'published_t'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_importTrigger_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_requestUri_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_requestId_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_loginResult_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_authnRequestId_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_groupAppAssignmentId_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_attributesDeleted_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_attributesAdded_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_attributesModified_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_signOnMode_s'
            type: 'string'
          }
          {
            name: 'client_userAgent_rawUserAgent_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_threatDetections_s'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_initiationType_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_logOnlySecurityData_s'
            type: 'string'
          }
          {
            name: 'target_s'
            type: 'string'
          }
          {
            name: 'client_userAgent_os_s'
            type: 'string'
          }
          {
            name: 'client_zone_s'
            type: 'string'
          }
          {
            name: 'securityContext_isProxy_b'
            type: 'string'
          }
          {
            name: 'securityContext_domain_s'
            type: 'string'
          }
          {
            name: 'securityContext_isp_s'
            type: 'string'
          }
          {
            name: 'securityContext_asOrg_s'
            type: 'string'
          }
          {
            name: 'securityContext_asNumber_d'
            type: 'string'
          }
          {
            name: 'outcome_reason_s'
            type: 'string'
          }
          {
            name: 'client_userAgent_browser_s'
            type: 'string'
          }
          {
            name: 'client_geographicalContext_geolocation_lon_d'
            type: 'string'
          }
          {
            name: 'client_geographicalContext_postalCode_s'
            type: 'string'
          }
          {
            name: 'client_geographicalContext_country_s'
            type: 'string'
          }
          {
            name: 'client_geographicalContext_state_s'
            type: 'string'
          }
          {
            name: 'client_geographicalContext_city_s'
            type: 'string'
          }
          {
            name: 'client_ipAddress_s'
            type: 'string'
          }
          {
            name: 'client_device_s'
            type: 'string'
          }
          {
            name: 'client_geographicalContext_geolocation_lat_d'
            type: 'string'
          }
          {
            name: 'debugContext_debugData_detailedmessage_s'
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
          name: 'Sentinel-Okta_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Okta_CL']
        destinations: ['Sentinel-Okta_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), debugContext_debugData_deviceFingerprint_g = tostring(debugContext_debugData_deviceFingerprint_g), authenticationContext_authenticationProvider_s = tostring(authenticationContext_authenticationProvider_s), authenticationContext_credentialProvider_s = tostring(authenticationContext_credentialProvider_s), debugContext_debugData_factor_s = tostring(debugContext_debugData_factor_s), debugContext_debugData_countryCallingCode_s = tostring(debugContext_debugData_countryCallingCode_s), debugContext_debugData_smsProvider_s = tostring(debugContext_debugData_smsProvider_s), debugContext_debugData_transactionId_g = tostring(debugContext_debugData_transactionId_g), authenticationContext_credentialType_s = tostring(authenticationContext_credentialType_s), actor_id_s = tostring(actor_id_s), actor_type_s = tostring(actor_type_s), actor_alternateId_s = tostring(actor_alternateId_s), actor_displayName_s = tostring(actor_displayName_s), authenticationContext_authenticationStep_d = toreal(authenticationContext_authenticationStep_d), authenticationContext_externalSessionId_s = tostring(authenticationContext_externalSessionId_s), displayMessage_s = tostring(displayMessage_s), eventType_s = tostring(eventType_s), outcome_result_s = tostring(outcome_result_s), request_ipChain_s = tostring(request_ipChain_s), version_s = tostring(version_s), uuid_g = tostring(uuid_g), transaction_id_s = tostring(transaction_id_s), transaction_type_s = tostring(transaction_type_s), legacyEventType_s = tostring(legacyEventType_s), debugContext_debugData_url_s = tostring(debugContext_debugData_url_s), debugContext_debugData_threatSuspected_s = tostring(debugContext_debugData_threatSuspected_s), debugContext_debugData_importLastToken_s = tostring(debugContext_debugData_importLastToken_s), debugContext_debugData_appname_s = tostring(debugContext_debugData_appname_s), debugContext_debugData_importType_s = tostring(debugContext_debugData_importType_s), debugContext_debugData_jobId_s = tostring(debugContext_debugData_jobId_s), severity_s = tostring(severity_s), published_t = todatetime(published_t), debugContext_debugData_importTrigger_s = tostring(debugContext_debugData_importTrigger_s), debugContext_debugData_requestUri_s = tostring(debugContext_debugData_requestUri_s), debugContext_debugData_requestId_s = tostring(debugContext_debugData_requestId_s), debugContext_debugData_loginResult_s = tostring(debugContext_debugData_loginResult_s), debugContext_debugData_authnRequestId_s = tostring(debugContext_debugData_authnRequestId_s), debugContext_debugData_groupAppAssignmentId_s = tostring(debugContext_debugData_groupAppAssignmentId_s), debugContext_debugData_attributesDeleted_s = tostring(debugContext_debugData_attributesDeleted_s), debugContext_debugData_attributesAdded_s = tostring(debugContext_debugData_attributesAdded_s), debugContext_debugData_attributesModified_s = tostring(debugContext_debugData_attributesModified_s), debugContext_debugData_signOnMode_s = tostring(debugContext_debugData_signOnMode_s), client_userAgent_rawUserAgent_s = tostring(client_userAgent_rawUserAgent_s), debugContext_debugData_threatDetections_s = tostring(debugContext_debugData_threatDetections_s), debugContext_debugData_initiationType_s = tostring(debugContext_debugData_initiationType_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), debugContext_debugData_logOnlySecurityData_s = tostring(debugContext_debugData_logOnlySecurityData_s), target_s = tostring(target_s), client_userAgent_os_s = tostring(client_userAgent_os_s), client_zone_s = tostring(client_zone_s), securityContext_isProxy_b = tobool(securityContext_isProxy_b), securityContext_domain_s = tostring(securityContext_domain_s), securityContext_isp_s = tostring(securityContext_isp_s), securityContext_asOrg_s = tostring(securityContext_asOrg_s), securityContext_asNumber_d = toreal(securityContext_asNumber_d), outcome_reason_s = tostring(outcome_reason_s), client_userAgent_browser_s = tostring(client_userAgent_browser_s), client_geographicalContext_geolocation_lon_d = toreal(client_geographicalContext_geolocation_lon_d), client_geographicalContext_postalCode_s = tostring(client_geographicalContext_postalCode_s), client_geographicalContext_country_s = tostring(client_geographicalContext_country_s), client_geographicalContext_state_s = tostring(client_geographicalContext_state_s), client_geographicalContext_city_s = tostring(client_geographicalContext_city_s), client_ipAddress_s = tostring(client_ipAddress_s), client_device_s = tostring(client_device_s), client_geographicalContext_geolocation_lat_d = toreal(client_geographicalContext_geolocation_lat_d), debugContext_debugData_detailedmessage_s = tostring(debugContext_debugData_detailedmessage_s)'
        outputStream: 'Custom-Okta_CL'
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
