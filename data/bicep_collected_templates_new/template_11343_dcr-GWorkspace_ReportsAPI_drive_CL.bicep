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
// Data Collection Rule for GWorkspace_ReportsAPI_drive_CL
// ============================================================================
// Generated: 2025-09-19 14:20:20
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 33, DCR columns: 33 (Type column always filtered)
// Output stream: Custom-GWorkspace_ReportsAPI_drive_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-GWorkspace_ReportsAPI_drive_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-GWorkspace_ReportsAPI_drive_CL': {
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
            name: 'IPAddress'
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
            name: 'target_domain_s'
            type: 'string'
          }
          {
            name: 'old_visibility_s'
            type: 'string'
          }
          {
            name: 'target_user_s'
            type: 'string'
          }
          {
            name: 'visibility_change_s'
            type: 'string'
          }
          {
            name: 'owner_s'
            type: 'string'
          }
          {
            name: 'originating_app_id_s'
            type: 'string'
          }
          {
            name: 'visibility_s'
            type: 'string'
          }
          {
            name: 'doc_title_s'
            type: 'string'
          }
          {
            name: 'doc_type_s'
            type: 'string'
          }
          {
            name: 'doc_id_s'
            type: 'string'
          }
          {
            name: 'event_name_s'
            type: 'string'
          }
          {
            name: 'source_folder_id_s'
            type: 'string'
          }
          {
            name: 'source_folder_title_s'
            type: 'string'
          }
          {
            name: 'destination_folder_id_s'
            type: 'string'
          }
          {
            name: 'destination_folder_title_s'
            type: 'string'
          }
          {
            name: 'new_value_s'
            type: 'string'
          }
          {
            name: 'old_value_s'
            type: 'string'
          }
          {
            name: 'team_drive_id_s'
            type: 'string'
          }
          {
            name: 'ishared_drive_id_s'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'events_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
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
          name: 'Sentinel-GWorkspace_ReportsAPI_drive_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-GWorkspace_ReportsAPI_drive_CL']
        destinations: ['Sentinel-GWorkspace_ReportsAPI_drive_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), IPAddress = tostring(IPAddress), actor_profileId_s = tostring(actor_profileId_s), actor_email_s = tostring(actor_email_s), etag_s = tostring(etag_s), id_customerId_s = tostring(id_customerId_s), id_applicationName_s = tostring(id_applicationName_s), id_uniqueQualifier_s = tostring(id_uniqueQualifier_s), id_time_t = todatetime(id_time_t), kind_s = tostring(kind_s), target_domain_s = tostring(target_domain_s), old_visibility_s = tostring(old_visibility_s), target_user_s = tostring(target_user_s), visibility_change_s = tostring(visibility_change_s), owner_s = tostring(owner_s), originating_app_id_s = tostring(originating_app_id_s), visibility_s = tostring(visibility_s), doc_title_s = tostring(doc_title_s), doc_type_s = tostring(doc_type_s), doc_id_s = tostring(doc_id_s), event_name_s = tostring(event_name_s), source_folder_id_s = tostring(source_folder_id_s), source_folder_title_s = tostring(source_folder_title_s), destination_folder_id_s = tostring(destination_folder_id_s), destination_folder_title_s = tostring(destination_folder_title_s), new_value_s = tostring(new_value_s), old_value_s = tostring(old_value_s), team_drive_id_s = tostring(team_drive_id_s), ishared_drive_id_s = tostring(ishared_drive_id_s), EventProduct = tostring(EventProduct), events_s = tostring(events_s), event_type_s = tostring(event_type_s)'
        outputStream: 'Custom-GWorkspace_ReportsAPI_drive_CL'
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
