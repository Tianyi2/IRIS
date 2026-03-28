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
// Data Collection Rule for VMware_CWS_Health_CL
// ============================================================================
// Generated: 2025-09-19 14:20:36
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 6, DCR columns: 6 (Type column always filtered)
// Output stream: Custom-VMware_CWS_Health_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-VMware_CWS_Health_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-VMware_CWS_Health_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'cws_component'
            type: 'string'
          }
          {
            name: 'healthtest_observed_unit'
            type: 'string'
          }
          {
            name: 'healthtest_observed_value'
            type: 'string'
          }
          {
            name: 'healthtest_status'
            type: 'string'
          }
          {
            name: 'healthtest_timestamp'
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
          name: 'Sentinel-VMware_CWS_Health_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-VMware_CWS_Health_CL']
        destinations: ['Sentinel-VMware_CWS_Health_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), cws_component = tostring(cws_component), healthtest_observed_unit = tostring(healthtest_observed_unit), healthtest_observed_value = toint(healthtest_observed_value), healthtest_status = tostring(healthtest_status), healthtest_timestamp = todatetime(healthtest_timestamp)'
        outputStream: 'Custom-VMware_CWS_Health_CL'
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
