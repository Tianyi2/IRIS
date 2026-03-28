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
// Data Collection Rule for Illumio_Workloads_Summarized_API_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 8, DCR columns: 8 (Type column always filtered)
// Output stream: Custom-Illumio_Workloads_Summarized_API_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Illumio_Workloads_Summarized_API_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Illumio_Workloads_Summarized_API_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'vens_by_enforcement_mode'
            type: 'dynamic'
          }
          {
            name: 'vens_by_managed'
            type: 'dynamic'
          }
          {
            name: 'vens_by_os'
            type: 'dynamic'
          }
          {
            name: 'vens_by_status'
            type: 'dynamic'
          }
          {
            name: 'vens_by_sync_state'
            type: 'dynamic'
          }
          {
            name: 'vens_by_type'
            type: 'dynamic'
          }
          {
            name: 'vens_by_version'
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
          name: 'Sentinel-Illumio_Workloads_Summarized_API_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Illumio_Workloads_Summarized_API_CL']
        destinations: ['Sentinel-Illumio_Workloads_Summarized_API_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), vens_by_enforcement_mode = todynamic(vens_by_enforcement_mode), vens_by_managed = todynamic(vens_by_managed), vens_by_os = todynamic(vens_by_os), vens_by_status = todynamic(vens_by_status), vens_by_sync_state = todynamic(vens_by_sync_state), vens_by_type = todynamic(vens_by_type), vens_by_version = tostring(vens_by_version)'
        outputStream: 'Custom-Illumio_Workloads_Summarized_API_CL'
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
