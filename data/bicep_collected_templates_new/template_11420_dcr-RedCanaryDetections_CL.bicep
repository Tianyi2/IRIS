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
// Data Collection Rule for RedCanaryDetections_CL
// ============================================================================
// Generated: 2025-09-19 14:20:30
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-RedCanaryDetections_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-RedCanaryDetections_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-RedCanaryDetections_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'child_process_iocs_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'process_iocs_s'
            type: 'string'
          }
          {
            name: 'network_connection_iocs_s'
            type: 'string'
          }
          {
            name: 'identities_s'
            type: 'string'
          }
          {
            name: 'host_os_version_s'
            type: 'string'
          }
          {
            name: 'host_os_family_s'
            type: 'string'
          }
          {
            name: 'host_name_s'
            type: 'string'
          }
          {
            name: 'registry_modification_iocs_s'
            type: 'string'
          }
          {
            name: 'host_full_name_s'
            type: 'string'
          }
          {
            name: 'detection_url_s'
            type: 'string'
          }
          {
            name: 'detection_severity_s'
            type: 'string'
          }
          {
            name: 'detection_id_s'
            type: 'string'
          }
          {
            name: 'detection_headline_s'
            type: 'string'
          }
          {
            name: 'detection_details_s'
            type: 'string'
          }
          {
            name: 'cross_process_iocs_s'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'file_modification_iocs_s'
            type: 'string'
          }
          {
            name: 'tactics_s'
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
          name: 'Sentinel-RedCanaryDetections_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-RedCanaryDetections_CL']
        destinations: ['Sentinel-RedCanaryDetections_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), child_process_iocs_s = tostring(child_process_iocs_s), RawData = tostring(RawData), process_iocs_s = tostring(process_iocs_s), network_connection_iocs_s = tostring(network_connection_iocs_s), identities_s = tostring(identities_s), host_os_version_s = tostring(host_os_version_s), host_os_family_s = tostring(host_os_family_s), host_name_s = tostring(host_name_s), registry_modification_iocs_s = tostring(registry_modification_iocs_s), host_full_name_s = tostring(host_full_name_s), detection_url_s = tostring(detection_url_s), detection_severity_s = tostring(detection_severity_s), detection_id_s = tostring(detection_id_s), detection_headline_s = tostring(detection_headline_s), detection_details_s = tostring(detection_details_s), cross_process_iocs_s = tostring(cross_process_iocs_s), Computer = tostring(Computer), file_modification_iocs_s = tostring(file_modification_iocs_s), tactics_s = tostring(tactics_s)'
        outputStream: 'Custom-RedCanaryDetections_CL'
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
