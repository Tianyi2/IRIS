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
// Data Collection Rule for Talon_CL
// ============================================================================
// Generated: 2025-09-19 14:20:33
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 44, DCR columns: 42 (Type column always filtered)
// Output stream: Custom-Talon_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Talon_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Talon_CL': {
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
            name: 'eventCategory_s'
            type: 'string'
          }
          {
            name: 'eventType_s'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'userEmail_s'
            type: 'string'
          }
          {
            name: 'deviceHostname_s'
            type: 'string'
          }
          {
            name: 'IPAddress'
            type: 'string'
          }
          {
            name: 'browserVersion_s'
            type: 'string'
          }
          {
            name: 'userAgent_s'
            type: 'string'
          }
          {
            name: 'osPlatform_s'
            type: 'string'
          }
          {
            name: 'osVersion_s'
            type: 'string'
          }
          {
            name: 'mitreTechniques_s'
            type: 'string'
          }
          {
            name: 'policyRule_s'
            type: 'string'
          }
          {
            name: 'eventDetails_protocol_s'
            type: 'string'
          }
          {
            name: 'eventDetails_method_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'time_s'
            type: 'string'
          }
          {
            name: 'eventDetails_type_s'
            type: 'string'
          }
          {
            name: 'eventDetails_path_s'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'eventDetails_loginUsername_s'
            type: 'string'
          }
          {
            name: 'eventDetails_matchedURL_s'
            type: 'string'
          }
          {
            name: 'eventDetails_categories_s'
            type: 'string'
          }
          {
            name: 'eventDetails_reasons_s'
            type: 'string'
          }
          {
            name: 'eventDetails_failedAttempts_d'
            type: 'string'
          }
          {
            name: 'eventDetails_engine_s'
            type: 'string'
          }
          {
            name: 'eventDetails_activity_s'
            type: 'string'
          }
          {
            name: 'eventDetails_printerName_s'
            type: 'string'
          }
          {
            name: 'eventDetails_fromURL_s'
            type: 'string'
          }
          {
            name: 'eventDetails_installSource_s'
            type: 'string'
          }
          {
            name: 'eventDetails_id_s'
            type: 'string'
          }
          {
            name: 'eventDetails_version_s'
            type: 'string'
          }
          {
            name: 'eventDetails_name_s'
            type: 'string'
          }
          {
            name: 'description_s'
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
          name: 'Sentinel-Talon_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Talon_CL']
        destinations: ['Sentinel-Talon_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), eventCategory_s = tostring(eventCategory_s), eventType_s = tostring(eventType_s), url_s = tostring(url_s), severity_s = tostring(severity_s), action_s = tostring(action_s), userEmail_s = tostring(userEmail_s), deviceHostname_s = tostring(deviceHostname_s), IPAddress = tostring(IPAddress), browserVersion_s = tostring(browserVersion_s), userAgent_s = tostring(userAgent_s), osPlatform_s = tostring(osPlatform_s), osVersion_s = tostring(osVersion_s), mitreTechniques_s = tostring(mitreTechniques_s), policyRule_s = tostring(policyRule_s), eventDetails_protocol_s = tostring(eventDetails_protocol_s), eventDetails_method_s = tostring(eventDetails_method_s), type_s = tostring(type_s), id_s = tostring(id_s), time_s = tostring(time_s), eventDetails_type_s = tostring(eventDetails_type_s), eventDetails_path_s = tostring(eventDetails_path_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), eventDetails_loginUsername_s = tostring(eventDetails_loginUsername_s), eventDetails_matchedURL_s = tostring(eventDetails_matchedURL_s), eventDetails_categories_s = tostring(eventDetails_categories_s), eventDetails_reasons_s = tostring(eventDetails_reasons_s), eventDetails_failedAttempts_d = toreal(eventDetails_failedAttempts_d), eventDetails_engine_s = tostring(eventDetails_engine_s), eventDetails_activity_s = tostring(eventDetails_activity_s), eventDetails_printerName_s = tostring(eventDetails_printerName_s), eventDetails_fromURL_s = tostring(eventDetails_fromURL_s), eventDetails_installSource_s = tostring(eventDetails_installSource_s), eventDetails_id_s = tostring(eventDetails_id_s), eventDetails_version_s = tostring(eventDetails_version_s), eventDetails_name_s = tostring(eventDetails_name_s), description_s = tostring(description_s)'
        outputStream: 'Custom-Talon_CL'
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
