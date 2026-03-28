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
// Data Collection Rule for BitglassLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 75, DCR columns: 75 (Type column always filtered)
// Output stream: Custom-BitglassLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitglassLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitglassLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'docextension_s'
            type: 'string'
          }
          {
            name: 'arguments_s'
            type: 'string'
          }
          {
            name: 'setransactionid_g'
            type: 'string'
          }
          {
            name: 'requestdomain_s'
            type: 'string'
          }
          {
            name: 'long_s'
            type: 'string'
          }
          {
            name: 'webreputation_s'
            type: 'string'
          }
          {
            name: 'IPAddress'
            type: 'string'
          }
          {
            name: 'indexedtime_s'
            type: 'string'
          }
          {
            name: 'destinationip_s'
            type: 'string'
          }
          {
            name: 'city_s'
            type: 'string'
          }
          {
            name: 'size_s'
            type: 'string'
          }
          {
            name: 'bgcategories_s'
            type: 'string'
          }
          {
            name: 'usergroup_s'
            type: 'string'
          }
          {
            name: 'requestmethod_s'
            type: 'string'
          }
          {
            name: 'customlocation_s'
            type: 'string'
          }
          {
            name: 'deviceguid_g'
            type: 'string'
          }
          {
            name: 'email_s'
            type: 'string'
          }
          {
            name: 'bgcloudscore_s'
            type: 'string'
          }
          {
            name: 'firstname_s'
            type: 'string'
          }
          {
            name: 'useragent_s'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'time_s'
            type: 'string'
          }
          {
            name: 'customcategories_s'
            type: 'string'
          }
          {
            name: 'uri_s'
            type: 'string'
          }
          {
            name: 'region_s'
            type: 'string'
          }
          {
            name: 'country_s'
            type: 'string'
          }
          {
            name: 'referrer_s'
            type: 'string'
          }
          {
            name: 'countrycode_s'
            type: 'string'
          }
          {
            name: 'webcategories_s'
            type: 'string'
          }
          {
            name: 'uploadedbytes_s'
            type: 'string'
          }
          {
            name: 'lat_s'
            type: 'string'
          }
          {
            name: 'regioncode_s'
            type: 'string'
          }
          {
            name: 'devicehostname_s'
            type: 'string'
          }
          {
            name: 'lastname_s'
            type: 'string'
          }
          {
            name: 'protocol_s'
            type: 'string'
          }
          {
            name: 'syslogheader_s'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'patterns_s'
            type: 'string'
          }
          {
            name: 'fileid_g'
            type: 'string'
          }
          {
            name: 'folder_s'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'owner_s'
            type: 'string'
          }
          {
            name: 'deviceguid_s'
            type: 'string'
          }
          {
            name: 'responsecode_s'
            type: 'string'
          }
          {
            name: 'responsecode_d'
            type: 'string'
          }
          {
            name: 'keyword_s'
            type: 'string'
          }
          {
            name: 'docmd5_s'
            type: 'string'
          }
          {
            name: 'threatindicator_s'
            type: 'string'
          }
          {
            name: 'policyid_s'
            type: 'string'
          }
          {
            name: 'docsha1_s'
            type: 'string'
          }
          {
            name: 'docsha256_s'
            type: 'string'
          }
          {
            name: 'doctype_s'
            type: 'string'
          }
          {
            name: 'filelink_s'
            type: 'string'
          }
          {
            name: 'webcategoryclass_s'
            type: 'string'
          }
          {
            name: 'sharedwith_s'
            type: 'string'
          }
          {
            name: 'user_s'
            type: 'string'
          }
          {
            name: 'pagetitle_s'
            type: 'string'
          }
          {
            name: 'dlppattern_s'
            type: 'string'
          }
          {
            name: 'filename_s'
            type: 'string'
          }
          {
            name: 'emailsenttime_s'
            type: 'string'
          }
          {
            name: 'emailbcc_s'
            type: 'string'
          }
          {
            name: 'emailcc_s'
            type: 'string'
          }
          {
            name: 'emailsubject_s'
            type: 'string'
          }
          {
            name: 'emailto_s'
            type: 'string'
          }
          {
            name: 'emailfrom_s'
            type: 'string'
          }
          {
            name: 'transactionid_s'
            type: 'string'
          }
          {
            name: 'request_s'
            type: 'string'
          }
          {
            name: 'activity_s'
            type: 'string'
          }
          {
            name: 'location_s'
            type: 'string'
          }
          {
            name: 'application_s'
            type: 'string'
          }
          {
            name: 'device_s'
            type: 'string'
          }
          {
            name: 'fileid_s'
            type: 'string'
          }
          {
            name: 'log_type_s'
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
          name: 'Sentinel-BitglassLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitglassLogs_CL']
        destinations: ['Sentinel-BitglassLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), docextension_s = tostring(docextension_s), arguments_s = tostring(arguments_s), setransactionid_g = tostring(setransactionid_g), requestdomain_s = tostring(requestdomain_s), long_s = tostring(long_s), webreputation_s = tostring(webreputation_s), IPAddress = tostring(IPAddress), indexedtime_s = tostring(indexedtime_s), destinationip_s = tostring(destinationip_s), city_s = tostring(city_s), size_s = tostring(size_s), bgcategories_s = tostring(bgcategories_s), usergroup_s = tostring(usergroup_s), requestmethod_s = tostring(requestmethod_s), customlocation_s = tostring(customlocation_s), deviceguid_g = tostring(deviceguid_g), email_s = tostring(email_s), bgcloudscore_s = tostring(bgcloudscore_s), firstname_s = tostring(firstname_s), useragent_s = tostring(useragent_s), action_s = tostring(action_s), time_s = tostring(time_s), customcategories_s = tostring(customcategories_s), uri_s = tostring(uri_s), region_s = tostring(region_s), country_s = tostring(country_s), referrer_s = tostring(referrer_s), countrycode_s = tostring(countrycode_s), webcategories_s = tostring(webcategories_s), uploadedbytes_s = tostring(uploadedbytes_s), lat_s = tostring(lat_s), regioncode_s = tostring(regioncode_s), devicehostname_s = tostring(devicehostname_s), lastname_s = tostring(lastname_s), protocol_s = tostring(protocol_s), syslogheader_s = tostring(syslogheader_s), details_s = tostring(details_s), url_s = tostring(url_s), patterns_s = tostring(patterns_s), fileid_g = tostring(fileid_g), folder_s = tostring(folder_s), status_s = tostring(status_s), owner_s = tostring(owner_s), deviceguid_s = tostring(deviceguid_s), responsecode_s = tostring(responsecode_s), responsecode_d = toreal(responsecode_d), keyword_s = tostring(keyword_s), docmd5_s = tostring(docmd5_s), threatindicator_s = tostring(threatindicator_s), policyid_s = tostring(policyid_s), docsha1_s = tostring(docsha1_s), docsha256_s = tostring(docsha256_s), doctype_s = tostring(doctype_s), filelink_s = tostring(filelink_s), webcategoryclass_s = tostring(webcategoryclass_s), sharedwith_s = tostring(sharedwith_s), user_s = tostring(user_s), pagetitle_s = tostring(pagetitle_s), dlppattern_s = tostring(dlppattern_s), filename_s = tostring(filename_s), emailsenttime_s = tostring(emailsenttime_s), emailbcc_s = tostring(emailbcc_s), emailcc_s = tostring(emailcc_s), emailsubject_s = tostring(emailsubject_s), emailto_s = tostring(emailto_s), emailfrom_s = tostring(emailfrom_s), transactionid_s = tostring(transactionid_s), request_s = tostring(request_s), activity_s = tostring(activity_s), location_s = tostring(location_s), application_s = tostring(application_s), device_s = tostring(device_s), fileid_s = tostring(fileid_s), log_type_s = tostring(log_type_s)'
        outputStream: 'Custom-BitglassLogs_CL'
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
