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
// Data Collection Rule for GWorkspace_ReportsAPI_calendar_CL
// ============================================================================
// Generated: 2025-09-19 14:20:20
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 33, DCR columns: 33 (Type column always filtered)
// Output stream: Custom-GWorkspace_ReportsAPI_calendar_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-GWorkspace_ReportsAPI_calendar_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-GWorkspace_ReportsAPI_calendar_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'events_s'
            type: 'string'
          }
          {
            name: 'ownerDomain_s'
            type: 'string'
          }
          {
            name: 'actor_profileId_s'
            type: 'string'
          }
          {
            name: 'actor_email_s'
            type: 'string'
          }
          {
            name: 'etag_s'
            type: 'string'
          }
          {
            name: 'id_customerId_s'
            type: 'string'
          }
          {
            name: 'id_applicationName_s'
            type: 'string'
          }
          {
            name: 'id_uniqueQualifier_s'
            type: 'string'
          }
          {
            name: 'id_time_t'
            type: 'string'
          }
          {
            name: 'kind_s'
            type: 'string'
          }
          {
            name: 'api_kind_s'
            type: 'string'
          }
          {
            name: 'event_response_status_s'
            type: 'string'
          }
          {
            name: 'event_guest_s'
            type: 'string'
          }
          {
            name: 'event_title_s'
            type: 'string'
          }
          {
            name: 'organizer_calendar_id_s'
            type: 'string'
          }
          {
            name: 'user_agent_s'
            type: 'string'
          }
          {
            name: 'event_id_s'
            type: 'string'
          }
          {
            name: 'notification_message_id_s'
            type: 'string'
          }
          {
            name: 'target_calendar_id_s'
            type: 'string'
          }
          {
            name: 'calendar_id_s'
            type: 'string'
          }
          {
            name: 'recipient_email_s'
            type: 'string'
          }
          {
            name: 'notification_method_s'
            type: 'string'
          }
          {
            name: 'notification_type_s'
            type: 'string'
          }
          {
            name: 'event_name_s'
            type: 'string'
          }
          {
            name: 'end_time_s'
            type: 'string'
          }
          {
            name: 'start_time_s'
            type: 'string'
          }
          {
            name: 'old_event_title_s'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'IPAddress'
            type: 'string'
          }
          {
            name: 'actor_callerType_s'
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
          name: 'Sentinel-GWorkspace_ReportsAPI_calendar_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-GWorkspace_ReportsAPI_calendar_CL']
        destinations: ['Sentinel-GWorkspace_ReportsAPI_calendar_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), event_type_s = tostring(event_type_s), events_s = tostring(events_s), ownerDomain_s = tostring(ownerDomain_s), actor_profileId_s = tostring(actor_profileId_s), actor_email_s = tostring(actor_email_s), etag_s = tostring(etag_s), id_customerId_s = tostring(id_customerId_s), id_applicationName_s = tostring(id_applicationName_s), id_uniqueQualifier_s = tostring(id_uniqueQualifier_s), id_time_t = todatetime(id_time_t), kind_s = tostring(kind_s), api_kind_s = tostring(api_kind_s), event_response_status_s = tostring(event_response_status_s), event_guest_s = tostring(event_guest_s), event_title_s = tostring(event_title_s), organizer_calendar_id_s = tostring(organizer_calendar_id_s), user_agent_s = tostring(user_agent_s), event_id_s = tostring(event_id_s), notification_message_id_s = tostring(notification_message_id_s), target_calendar_id_s = tostring(target_calendar_id_s), calendar_id_s = tostring(calendar_id_s), recipient_email_s = tostring(recipient_email_s), notification_method_s = tostring(notification_method_s), notification_type_s = tostring(notification_type_s), event_name_s = tostring(event_name_s), end_time_s = tostring(end_time_s), start_time_s = tostring(start_time_s), old_event_title_s = tostring(old_event_title_s), EventProduct = tostring(EventProduct), IPAddress = tostring(IPAddress), actor_callerType_s = tostring(actor_callerType_s)'
        outputStream: 'Custom-GWorkspace_ReportsAPI_calendar_CL'
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
