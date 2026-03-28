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
// Data Collection Rule for InfobloxInsightAssets_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-InfobloxInsightAssets_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-InfobloxInsightAssets_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-InfobloxInsightAssets_CL': {
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
            name: 'user_s'
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
            name: 'threatIndicatorDistinctCount_s'
            type: 'string'
          }
          {
            name: 'threatLevelMax_s'
            type: 'string'
          }
          {
            name: 'osVersion_s'
            type: 'string'
          }
          {
            name: 'location_s'
            type: 'string'
          }
          {
            name: 'qip_s'
            type: 'string'
          }
          {
            name: 'count_d'
            type: 'string'
          }
          {
            name: 'cmac_s'
            type: 'string'
          }
          {
            name: 'cid_s'
            type: 'string'
          }
          {
            name: 'InfobloxInsightID_s'
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
          name: 'Sentinel-InfobloxInsightAssets_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-InfobloxInsightAssets_CL']
        destinations: ['Sentinel-InfobloxInsightAssets_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), user_s = tostring(user_s), timeMin_t = todatetime(timeMin_t), timeMax_t = todatetime(timeMax_t), threatIndicatorDistinctCount_s = tostring(threatIndicatorDistinctCount_s), threatLevelMax_s = tostring(threatLevelMax_s), osVersion_s = tostring(osVersion_s), location_s = tostring(location_s), qip_s = tostring(qip_s), count_d = toreal(count_d), cmac_s = tostring(cmac_s), cid_s = tostring(cid_s), InfobloxInsightID_s = tostring(InfobloxInsightID_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), InfobloxInsightID_g = tostring(InfobloxInsightID_g), InfobloxInsightLogType_s = tostring(InfobloxInsightLogType_s)'
        outputStream: 'Custom-InfobloxInsightAssets_CL'
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
