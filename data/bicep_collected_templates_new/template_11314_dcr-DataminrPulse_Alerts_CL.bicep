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
// Data Collection Rule for DataminrPulse_Alerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 19, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-DataminrPulse_Alerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DataminrPulse_Alerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DataminrPulse_Alerts_CL': {
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
            name: 'odsStatus_timestamp_d'
            type: 'string'
          }
          {
            name: 'dataMap_headlineMds_content_s'
            type: 'string'
          }
          {
            name: 'relatedAlerts_s'
            type: 'string'
          }
          {
            name: 'EventVolume'
            type: 'string'
          }
          {
            name: 'timestamp_d'
            type: 'string'
          }
          {
            name: 'location_longitude_d'
            type: 'string'
          }
          {
            name: 'watchlistsMatchedByType_s'
            type: 'string'
          }
          {
            name: 'location_latitude_d'
            type: 'string'
          }
          {
            name: 'companies_s'
            type: 'string'
          }
          {
            name: 'headline_s'
            type: 'string'
          }
          {
            name: 'availableRelatedAlerts_d'
            type: 'string'
          }
          {
            name: 'alertType_name_s'
            type: 'string'
          }
          {
            name: 'index_s'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'categories_s'
            type: 'string'
          }
          {
            name: 'location_name_s'
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
          name: 'Sentinel-DataminrPulse_Alerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DataminrPulse_Alerts_CL']
        destinations: ['Sentinel-DataminrPulse_Alerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), odsStatus_timestamp_d = toreal(odsStatus_timestamp_d), dataMap_headlineMds_content_s = tostring(dataMap_headlineMds_content_s), relatedAlerts_s = tostring(relatedAlerts_s), EventVolume = toreal(EventVolume), timestamp_d = toreal(timestamp_d), location_longitude_d = toreal(location_longitude_d), watchlistsMatchedByType_s = tostring(watchlistsMatchedByType_s), location_latitude_d = toreal(location_latitude_d), companies_s = tostring(companies_s), headline_s = tostring(headline_s), availableRelatedAlerts_d = toreal(availableRelatedAlerts_d), alertType_name_s = tostring(alertType_name_s), index_s = tostring(index_s), EventProduct = tostring(EventProduct), categories_s = tostring(categories_s), location_name_s = tostring(location_name_s)'
        outputStream: 'Custom-DataminrPulse_Alerts_CL'
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
