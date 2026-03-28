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
// Data Collection Rule for CitrixAnalytics_userProfile_CL
// ============================================================================
// Generated: 2025-09-19 14:20:00
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 21, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-CitrixAnalytics_userProfile_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CitrixAnalytics_userProfile_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CitrixAnalytics_userProfile_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'app_s'
            type: 'string'
          }
          {
            name: 'uploaded_file_cnt_d'
            type: 'string'
          }
          {
            name: 'uploaded_bytes_d'
            type: 'string'
          }
          {
            name: 'tenant_id_s'
            type: 'string'
          }
          {
            name: 'shared_file_cnt_d'
            type: 'string'
          }
          {
            name: 'session_domain_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'entity_type_s'
            type: 'string'
          }
          {
            name: 'entity_id_s'
            type: 'string'
          }
          {
            name: 'downloaded_file_cnt_d'
            type: 'string'
          }
          {
            name: 'downloaded_bytes_d'
            type: 'string'
          }
          {
            name: 'device_s'
            type: 'string'
          }
          {
            name: 'deleted_file_cnt_d'
            type: 'string'
          }
          {
            name: 'data_usage_bytes_d'
            type: 'string'
          }
          {
            name: 'cur_riskscore_d'
            type: 'string'
          }
          {
            name: 'country_s'
            type: 'string'
          }
          {
            name: 'cnt_d'
            type: 'string'
          }
          {
            name: 'city_s'
            type: 'string'
          }
          {
            name: 'user_samaccountname_s'
            type: 'string'
          }
          {
            name: 'version_d'
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
          name: 'Sentinel-CitrixAnalytics_userProfile_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CitrixAnalytics_userProfile_CL']
        destinations: ['Sentinel-CitrixAnalytics_userProfile_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), app_s = tostring(app_s), uploaded_file_cnt_d = toreal(uploaded_file_cnt_d), uploaded_bytes_d = toreal(uploaded_bytes_d), tenant_id_s = tostring(tenant_id_s), shared_file_cnt_d = toreal(shared_file_cnt_d), session_domain_s = tostring(session_domain_s), event_type_s = tostring(event_type_s), entity_type_s = tostring(entity_type_s), entity_id_s = tostring(entity_id_s), downloaded_file_cnt_d = toreal(downloaded_file_cnt_d), downloaded_bytes_d = toreal(downloaded_bytes_d), device_s = tostring(device_s), deleted_file_cnt_d = toreal(deleted_file_cnt_d), data_usage_bytes_d = toreal(data_usage_bytes_d), cur_riskscore_d = toreal(cur_riskscore_d), country_s = tostring(country_s), cnt_d = toreal(cnt_d), city_s = tostring(city_s), user_samaccountname_s = tostring(user_samaccountname_s), version_d = toreal(version_d)'
        outputStream: 'Custom-CitrixAnalytics_userProfile_CL'
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
