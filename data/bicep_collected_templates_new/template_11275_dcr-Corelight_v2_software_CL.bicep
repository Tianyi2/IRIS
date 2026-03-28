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
// Data Collection Rule for Corelight_v2_software_CL
// ============================================================================
// Generated: 2025-09-19 14:20:11
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 15, DCR columns: 12 (Type column always filtered)
// Output stream: Custom-Corelight_v2_software_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_software_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_software_CL': {
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
            name: 'host_s'
            type: 'string'
          }
          {
            name: 'host_p_d'
            type: 'string'
          }
          {
            name: 'software_type_s'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'version_major_d'
            type: 'string'
          }
          {
            name: 'version_minor_d'
            type: 'string'
          }
          {
            name: 'version_minor2_d'
            type: 'string'
          }
          {
            name: 'version_minor3_d'
            type: 'string'
          }
          {
            name: 'version_addl_s'
            type: 'string'
          }
          {
            name: 'unparsed_version_s'
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
          name: 'Sentinel-Corelight_v2_software_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_software_CL']
        destinations: ['Sentinel-Corelight_v2_software_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), host_s = tostring(host_s), host_p_d = toreal(host_p_d), software_type_s = tostring(software_type_s), name_s = tostring(name_s), version_major_d = toreal(version_major_d), version_minor_d = toreal(version_minor_d), version_minor2_d = toreal(version_minor2_d), version_minor3_d = toreal(version_minor3_d), version_addl_s = tostring(version_addl_s), unparsed_version_s = tostring(unparsed_version_s)'
        outputStream: 'Custom-Corelight_v2_software_CL'
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
