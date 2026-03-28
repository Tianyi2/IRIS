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
// Data Collection Rule for GWorkspace_ReportsAPI_mobile_CL
// ============================================================================
// Generated: 2025-09-19 14:20:20
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 31, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-GWorkspace_ReportsAPI_mobile_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-GWorkspace_ReportsAPI_mobile_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-GWorkspace_ReportsAPI_mobile_CL': {
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
            name: 'actor_profileId_s'
            type: 'string'
          }
          {
            name: 'actor_email_s'
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
            name: 'IOS_VENDOR_ID_g'
            type: 'string'
          }
          {
            name: 'OS_VERSION_s'
            type: 'string'
          }
          {
            name: 'IOS_VENDOR_ID_s'
            type: 'string'
          }
          {
            name: 'RESOURCE_ID_s'
            type: 'string'
          }
          {
            name: 'DEVICE_MODEL_s'
            type: 'string'
          }
          {
            name: 'DEVICE_TYPE_s'
            type: 'string'
          }
          {
            name: 'SERIAL_NUMBER_s'
            type: 'string'
          }
          {
            name: 'DEVICE_ID_g'
            type: 'string'
          }
          {
            name: 'USER_EMAIL_s'
            type: 'string'
          }
          {
            name: 'event_name_s'
            type: 'string'
          }
          {
            name: 'REGISTER_PRIVILEGE_s'
            type: 'string'
          }
          {
            name: 'ACCOUNT_STATE_s'
            type: 'string'
          }
          {
            name: 'LAST_SYNC_AUDIT_DATE_s'
            type: 'string'
          }
          {
            name: 'OS_PROPERTY_s'
            type: 'string'
          }
          {
            name: 'NEW_VALUE_s'
            type: 'string'
          }
          {
            name: 'OLD_VALUE_s'
            type: 'string'
          }
          {
            name: 'DEVICE_ID_s'
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
          name: 'Sentinel-GWorkspace_ReportsAPI_mobile_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-GWorkspace_ReportsAPI_mobile_CL']
        destinations: ['Sentinel-GWorkspace_ReportsAPI_mobile_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), actor_profileId_s = tostring(actor_profileId_s), actor_email_s = tostring(actor_email_s), actor_callerType_s = tostring(actor_callerType_s), etag_s = tostring(etag_s), id_customerId_s = tostring(id_customerId_s), id_applicationName_s = tostring(id_applicationName_s), id_uniqueQualifier_s = tostring(id_uniqueQualifier_s), id_time_t = todatetime(id_time_t), kind_s = tostring(kind_s), IOS_VENDOR_ID_g = tostring(IOS_VENDOR_ID_g), OS_VERSION_s = tostring(OS_VERSION_s), IOS_VENDOR_ID_s = tostring(IOS_VENDOR_ID_s), RESOURCE_ID_s = tostring(RESOURCE_ID_s), DEVICE_MODEL_s = tostring(DEVICE_MODEL_s), DEVICE_TYPE_s = tostring(DEVICE_TYPE_s), SERIAL_NUMBER_s = tostring(SERIAL_NUMBER_s), DEVICE_ID_g = tostring(DEVICE_ID_g), USER_EMAIL_s = tostring(USER_EMAIL_s), event_name_s = tostring(event_name_s), REGISTER_PRIVILEGE_s = tostring(REGISTER_PRIVILEGE_s), ACCOUNT_STATE_s = tostring(ACCOUNT_STATE_s), LAST_SYNC_AUDIT_DATE_s = tostring(LAST_SYNC_AUDIT_DATE_s), OS_PROPERTY_s = tostring(OS_PROPERTY_s), NEW_VALUE_s = tostring(NEW_VALUE_s), OLD_VALUE_s = tostring(OLD_VALUE_s), DEVICE_ID_s = tostring(DEVICE_ID_s), EventProduct = tostring(EventProduct), events_s = tostring(events_s), event_type_s = tostring(event_type_s)'
        outputStream: 'Custom-GWorkspace_ReportsAPI_mobile_CL'
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
