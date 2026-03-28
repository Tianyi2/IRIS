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
// Data Collection Rule for InfobloxInsightIndicators_CL
// ============================================================================
// Generated: 2025-09-19 14:20:22
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 29, DCR columns: 27 (Type column always filtered)
// Output stream: Custom-InfobloxInsightIndicators_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-InfobloxInsightIndicators_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-InfobloxInsightIndicators_CL': {
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
            name: 'properties_friendlyName_s'
            type: 'string'
          }
          {
            name: 'properties_category_s'
            type: 'string'
          }
          {
            name: 'properties_malwareName_s'
            type: 'string'
          }
          {
            name: 'kind_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'name_g'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'properties_friendlyName_g'
            type: 'string'
          }
          {
            name: 'properties_objectGuid_g'
            type: 'string'
          }
          {
            name: 'actor_s'
            type: 'string'
          }
          {
            name: 'timeMin_t'
            type: 'string'
          }
          {
            name: 'timeMax_t'
            type: 'string'
          }
          {
            name: 'indicator_s'
            type: 'string'
          }
          {
            name: 'threatLevelMax_s'
            type: 'string'
          }
          {
            name: 'feedName_s'
            type: 'string'
          }
          {
            name: 'count_d'
            type: 'string'
          }
          {
            name: 'confidence_s'
            type: 'string'
          }
          {
            name: 'action_s'
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
            name: 'InfobloxInsightID_g'
            type: 'string'
          }
          {
            name: 'InfobloxInsightLogType_s'
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
          name: 'Sentinel-InfobloxInsightIndicators_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-InfobloxInsightIndicators_CL']
        destinations: ['Sentinel-InfobloxInsightIndicators_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), properties_friendlyName_s = tostring(properties_friendlyName_s), properties_category_s = tostring(properties_category_s), properties_malwareName_s = tostring(properties_malwareName_s), kind_s = tostring(kind_s), type_s = tostring(type_s), name_g = tostring(name_g), id_s = tostring(id_s), properties_friendlyName_g = tostring(properties_friendlyName_g), properties_objectGuid_g = tostring(properties_objectGuid_g), actor_s = tostring(actor_s), timeMin_t = todatetime(timeMin_t), timeMax_t = todatetime(timeMax_t), indicator_s = tostring(indicator_s), threatLevelMax_s = tostring(threatLevelMax_s), feedName_s = tostring(feedName_s), count_d = toreal(count_d), confidence_s = tostring(confidence_s), action_s = tostring(action_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), InfobloxInsightID_g = tostring(InfobloxInsightID_g), InfobloxInsightLogType_s = tostring(InfobloxInsightLogType_s)'
        outputStream: 'Custom-InfobloxInsightIndicators_CL'
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
