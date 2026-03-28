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
// Data Collection Rule for TransmitSecurityAdminActivity_CL
// ============================================================================
// Generated: 2025-09-19 14:20:35
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 9, DCR columns: 9 (Type column always filtered)
// Output stream: Custom-TransmitSecurityAdminActivity_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TransmitSecurityAdminActivity_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TransmitSecurityAdminActivity_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'activity'
            type: 'string'
          }
          {
            name: 'actor_id'
            type: 'string'
          }
          {
            name: 'actor_type'
            type: 'string'
          }
          {
            name: 'ip'
            type: 'string'
          }
          {
            name: 'target_resource_id'
            type: 'string'
          }
          {
            name: 'target_resource_type'
            type: 'string'
          }
          {
            name: 'timestamp'
            type: 'string'
          }
          {
            name: 'user_agent'
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
          name: 'Sentinel-TransmitSecurityAdminActivity_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TransmitSecurityAdminActivity_CL']
        destinations: ['Sentinel-TransmitSecurityAdminActivity_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), activity = tostring(activity), actor_id = tostring(actor_id), actor_type = tostring(actor_type), ip = tostring(ip), target_resource_id = tostring(target_resource_id), target_resource_type = tostring(target_resource_type), timestamp = todatetime(timestamp), user_agent = tostring(user_agent)'
        outputStream: 'Custom-TransmitSecurityAdminActivity_CL'
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
