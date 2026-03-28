// Bicep template for Log Analytics custom table: Okta_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 74, Deployed columns: 71 (Type column filtered)
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

resource oktaclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Okta_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Okta_CL'
      description: 'Custom table Okta_CL - imported from JSON schema'
      displayName: 'Okta_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
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
          type: 'real'
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
          dataTypeHint: 0
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
          type: 'dateTime'
        }
        {
          name: 'debugContext_debugData_importTrigger_s'
          type: 'string'
        }
        {
          name: 'debugContext_debugData_requestUri_s'
          type: 'string'
          dataTypeHint: 0
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
          dataTypeHint: 0
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
          type: 'boolean'
        }
        {
          name: 'securityContext_domain_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'securityContext_isp_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'securityContext_asOrg_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'securityContext_asNumber_d'
          type: 'real'
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
          type: 'real'
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
          dataTypeHint: 3
        }
        {
          name: 'client_device_s'
          type: 'string'
        }
        {
          name: 'client_geographicalContext_geolocation_lat_d'
          type: 'real'
        }
        {
          name: 'debugContext_debugData_detailedmessage_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = oktaclTable.name
output tableId string = oktaclTable.id
output provisioningState string = oktaclTable.properties.provisioningState
