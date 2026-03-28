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
// Data Collection Rule for Corelight_v2_known_services_CL
// ============================================================================
// Generated: 2025-09-19 14:20:07
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 14 (Type column always filtered)
// Output stream: Custom-Corelight_v2_known_services_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_known_services_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_known_services_CL': {
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
            name: 'duration_d'
            type: 'string'
          }
          {
            name: 'kuid_s'
            type: 'string'
          }
          {
            name: 'host_ip_s'
            type: 'string'
          }
          {
            name: 'port_num_d'
            type: 'string'
          }
          {
            name: 'protocol_s'
            type: 'string'
          }
          {
            name: 'service_s'
            type: 'string'
          }
          {
            name: 'software_s'
            type: 'string'
          }
          {
            name: 'app_s'
            type: 'string'
          }
          {
            name: 'num_conns_d'
            type: 'string'
          }
          {
            name: 'annotations_s'
            type: 'string'
          }
          {
            name: 'last_active_session_s'
            type: 'string'
          }
          {
            name: 'last_active_interval_d'
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
          name: 'Sentinel-Corelight_v2_known_services_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_known_services_CL']
        destinations: ['Sentinel-Corelight_v2_known_services_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), duration_d = toreal(duration_d), kuid_s = tostring(kuid_s), host_ip_s = tostring(host_ip_s), port_num_d = toreal(port_num_d), protocol_s = tostring(protocol_s), service_s = tostring(service_s), software_s = tostring(software_s), app_s = tostring(app_s), num_conns_d = toreal(num_conns_d), annotations_s = tostring(annotations_s), last_active_session_s = tostring(last_active_session_s), last_active_interval_d = toreal(last_active_interval_d)'
        outputStream: 'Custom-Corelight_v2_known_services_CL'
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
