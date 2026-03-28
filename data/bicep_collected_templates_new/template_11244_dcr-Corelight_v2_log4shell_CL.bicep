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
// Data Collection Rule for Corelight_v2_log4shell_CL
// ============================================================================
// Generated: 2025-09-19 14:20:07
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 14 (Type column always filtered)
// Output stream: Custom-Corelight_v2_log4shell_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_log4shell_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_log4shell_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'ts_t'
            type: 'string'
          }
          {
            name: 'uid_s'
            type: 'string'
          }
          {
            name: 'http_uri_s'
            type: 'string'
          }
          {
            name: 'uri_s'
            type: 'string'
          }
          {
            name: 'stem_s'
            type: 'string'
          }
          {
            name: 'target_host_s'
            type: 'string'
          }
          {
            name: 'target_port_s'
            type: 'string'
          }
          {
            name: 'method_s'
            type: 'string'
          }
          {
            name: 'is_orig_b'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'value_s'
            type: 'string'
          }
          {
            name: 'matched_name_b'
            type: 'string'
          }
          {
            name: 'matched_value_b'
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
          name: 'Sentinel-Corelight_v2_log4shell_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_log4shell_CL']
        destinations: ['Sentinel-Corelight_v2_log4shell_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), uid_s = tostring(uid_s), http_uri_s = tostring(http_uri_s), uri_s = tostring(uri_s), stem_s = tostring(stem_s), target_host_s = tostring(target_host_s), target_port_s = tostring(target_port_s), method_s = tostring(method_s), is_orig_b = tobool(is_orig_b), name_s = tostring(name_s), value_s = tostring(value_s), matched_name_b = tobool(matched_name_b), matched_value_b = tobool(matched_value_b)'
        outputStream: 'Custom-Corelight_v2_log4shell_CL'
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
