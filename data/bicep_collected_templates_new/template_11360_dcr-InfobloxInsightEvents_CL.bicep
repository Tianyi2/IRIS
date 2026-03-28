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
// Data Collection Rule for InfobloxInsightEvents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:22
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 48, DCR columns: 46 (Type column always filtered)
// Output stream: Custom-InfobloxInsightEvents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-InfobloxInsightEvents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-InfobloxInsightEvents_CL': {
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
            name: 'response_s'
            type: 'string'
          }
          {
            name: 'class_s'
            type: 'string'
          }
          {
            name: 'threatFamily_s'
            type: 'string'
          }
          {
            name: 'threatIndicator_s'
            type: 'string'
          }
          {
            name: 'detected_s'
            type: 'string'
          }
          {
            name: 'property_s'
            type: 'string'
          }
          {
            name: 'user_s'
            type: 'string'
          }
          {
            name: 'threatLevel_s'
            type: 'string'
          }
          {
            name: 'properties_objectGuid_g'
            type: 'string'
          }
          {
            name: 'properties_friendlyName_g'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'name_g'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'kind_s'
            type: 'string'
          }
          {
            name: 'properties_malwareName_s'
            type: 'string'
          }
          {
            name: 'properties_category_s'
            type: 'string'
          }
          {
            name: 'properties_friendlyName_s'
            type: 'string'
          }
          {
            name: 'InfobloxInsightID_g'
            type: 'string'
          }
          {
            name: 'InfobloxInsightfulID_s'
            type: 'string'
          }
          {
            name: 'queryType_s'
            type: 'string'
          }
          {
            name: 'InfobloxInsightLogType_s'
            type: 'string'
          }
          {
            name: 'query_s'
            type: 'string'
          }
          {
            name: 'policy_s'
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
            name: 'responseCountry_s'
            type: 'string'
          }
          {
            name: 'responseRegion_s'
            type: 'string'
          }
          {
            name: 'deviceName_g'
            type: 'string'
          }
          {
            name: 'osVersion_s'
            type: 'string'
          }
          {
            name: 'confidenceLevel_s'
            type: 'string'
          }
          {
            name: 'deviceCountry_s'
            type: 'string'
          }
          {
            name: 'deviceName_s'
            type: 'string'
          }
          {
            name: 'deviceRegion_s'
            type: 'string'
          }
          {
            name: 'dhcpFingerprint_s'
            type: 'string'
          }
          {
            name: 'dnsView_s'
            type: 'string'
          }
          {
            name: 'feed_s'
            type: 'string'
          }
          {
            name: 'macAddress_s'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'deviceIp_s'
            type: 'string'
          }
          {
            name: 'InsightID_g'
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
          name: 'Sentinel-InfobloxInsightEvents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-InfobloxInsightEvents_CL']
        destinations: ['Sentinel-InfobloxInsightEvents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), response_s = tostring(response_s), class_s = tostring(class_s), threatFamily_s = tostring(threatFamily_s), threatIndicator_s = tostring(threatIndicator_s), detected_s = tostring(detected_s), property_s = tostring(property_s), user_s = tostring(user_s), threatLevel_s = tostring(threatLevel_s), properties_objectGuid_g = tostring(properties_objectGuid_g), properties_friendlyName_g = tostring(properties_friendlyName_g), id_s = tostring(id_s), name_g = tostring(name_g), type_s = tostring(type_s), kind_s = tostring(kind_s), properties_malwareName_s = tostring(properties_malwareName_s), properties_category_s = tostring(properties_category_s), properties_friendlyName_s = tostring(properties_friendlyName_s), InfobloxInsightID_g = tostring(InfobloxInsightID_g), InfobloxInsightfulID_s = tostring(InfobloxInsightfulID_s), queryType_s = tostring(queryType_s), InfobloxInsightLogType_s = tostring(InfobloxInsightLogType_s), query_s = tostring(query_s), policy_s = tostring(policy_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), responseCountry_s = tostring(responseCountry_s), responseRegion_s = tostring(responseRegion_s), deviceName_g = tostring(deviceName_g), osVersion_s = tostring(osVersion_s), confidenceLevel_s = tostring(confidenceLevel_s), deviceCountry_s = tostring(deviceCountry_s), deviceName_s = tostring(deviceName_s), deviceRegion_s = tostring(deviceRegion_s), dhcpFingerprint_s = tostring(dhcpFingerprint_s), dnsView_s = tostring(dnsView_s), feed_s = tostring(feed_s), macAddress_s = tostring(macAddress_s), source_s = tostring(source_s), action_s = tostring(action_s), deviceIp_s = tostring(deviceIp_s), InsightID_g = tostring(InsightID_g)'
        outputStream: 'Custom-InfobloxInsightEvents_CL'
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
