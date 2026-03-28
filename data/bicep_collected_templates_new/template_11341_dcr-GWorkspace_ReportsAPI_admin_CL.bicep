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
// Data Collection Rule for GWorkspace_ReportsAPI_admin_CL
// ============================================================================
// Generated: 2025-09-19 14:20:20
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 26, DCR columns: 26 (Type column always filtered)
// Output stream: Custom-GWorkspace_ReportsAPI_admin_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-GWorkspace_ReportsAPI_admin_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-GWorkspace_ReportsAPI_admin_CL': {
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
            name: 'actor_email_s'
            type: 'string'
          }
          {
            name: 'NEW_VALUE_s'
            type: 'string'
          }
          {
            name: 'PRODUCT_NAME_s'
            type: 'string'
          }
          {
            name: 'USER_EMAIL_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'event_name_s'
            type: 'string'
          }
          {
            name: 'events_s'
            type: 'string'
          }
          {
            name: 'actor_key_s'
            type: 'string'
          }
          {
            name: 'actor_callerType_s'
            type: 'string'
          }
          {
            name: 'etag_s'
            type: 'string'
          }
          {
            name: 'actor_profileId_s'
            type: 'string'
          }
          {
            name: 'id_customerId_s'
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
            name: 'OLD_VALUE_s'
            type: 'string'
          }
          {
            name: 'ROLE_NAME_s'
            type: 'string'
          }
          {
            name: 'APPLICATION_EDITION_s'
            type: 'string'
          }
          {
            name: 'SETTING_NAME_s'
            type: 'string'
          }
          {
            name: 'ORG_UNIT_NAME_s'
            type: 'string'
          }
          {
            name: 'APPLICATION_NAME_s'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'id_applicationName_s'
            type: 'string'
          }
          {
            name: 'IPAddress'
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
          name: 'Sentinel-GWorkspace_ReportsAPI_admin_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-GWorkspace_ReportsAPI_admin_CL']
        destinations: ['Sentinel-GWorkspace_ReportsAPI_admin_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), actor_email_s = tostring(actor_email_s), NEW_VALUE_s = tostring(NEW_VALUE_s), PRODUCT_NAME_s = tostring(PRODUCT_NAME_s), USER_EMAIL_s = tostring(USER_EMAIL_s), event_type_s = tostring(event_type_s), event_name_s = tostring(event_name_s), events_s = tostring(events_s), actor_key_s = tostring(actor_key_s), actor_callerType_s = tostring(actor_callerType_s), etag_s = tostring(etag_s), actor_profileId_s = tostring(actor_profileId_s), id_customerId_s = tostring(id_customerId_s), id_uniqueQualifier_s = tostring(id_uniqueQualifier_s), id_time_t = todatetime(id_time_t), kind_s = tostring(kind_s), OLD_VALUE_s = tostring(OLD_VALUE_s), ROLE_NAME_s = tostring(ROLE_NAME_s), APPLICATION_EDITION_s = tostring(APPLICATION_EDITION_s), SETTING_NAME_s = tostring(SETTING_NAME_s), ORG_UNIT_NAME_s = tostring(ORG_UNIT_NAME_s), APPLICATION_NAME_s = tostring(APPLICATION_NAME_s), EventProduct = tostring(EventProduct), id_applicationName_s = tostring(id_applicationName_s), IPAddress = tostring(IPAddress)'
        outputStream: 'Custom-GWorkspace_ReportsAPI_admin_CL'
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
