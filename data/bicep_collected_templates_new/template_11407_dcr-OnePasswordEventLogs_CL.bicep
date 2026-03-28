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
// Data Collection Rule for OnePasswordEventLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:28
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 28, DCR columns: 28 (Type column always filtered)
// Output stream: Custom-OnePasswordEventLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-OnePasswordEventLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-OnePasswordEventLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'item_uuid'
            type: 'string'
          }
          {
            name: 'vault_uuid'
            type: 'string'
          }
          {
            name: 'used_version'
            type: 'string'
          }
          {
            name: 'session'
            type: 'dynamic'
          }
          {
            name: 'aux_info'
            type: 'string'
          }
          {
            name: 'aux_details'
            type: 'dynamic'
          }
          {
            name: 'aux_uuid'
            type: 'string'
          }
          {
            name: 'aux_id'
            type: 'string'
          }
          {
            name: 'object_details'
            type: 'dynamic'
          }
          {
            name: 'object_uuid'
            type: 'string'
          }
          {
            name: 'object_Type'
            type: 'string'
          }
          {
            name: 'user'
            type: 'dynamic'
          }
          {
            name: 'action'
            type: 'string'
          }
          {
            name: 'actor_uuid'
            type: 'string'
          }
          {
            name: 'location'
            type: 'dynamic'
          }
          {
            name: 'client'
            type: 'dynamic'
          }
          {
            name: 'target_user'
            type: 'dynamic'
          }
          {
            name: 'details'
            type: 'dynamic'
          }
          {
            name: 'action_Type'
            type: 'string'
          }
          {
            name: 'category'
            type: 'string'
          }
          {
            name: 'country'
            type: 'string'
          }
          {
            name: 'timestamp'
            type: 'string'
          }
          {
            name: 'session_uuid'
            type: 'string'
          }
          {
            name: 'uuid_s'
            type: 'string'
          }
          {
            name: 'actor_details'
            type: 'dynamic'
          }
          {
            name: 'log_source'
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
          name: 'Sentinel-OnePasswordEventLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-OnePasswordEventLogs_CL']
        destinations: ['Sentinel-OnePasswordEventLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), SourceSystem = tostring(SourceSystem), item_uuid = tostring(item_uuid), vault_uuid = tostring(vault_uuid), used_version = toint(used_version), session = todynamic(session), aux_info = tostring(aux_info), aux_details = todynamic(aux_details), aux_uuid = tostring(aux_uuid), aux_id = toint(aux_id), object_details = todynamic(object_details), object_uuid = tostring(object_uuid), object_Type = tostring(object_Type), user = todynamic(user), action = tostring(action), actor_uuid = tostring(actor_uuid), location = todynamic(location), client = todynamic(client), target_user = todynamic(target_user), details = todynamic(details), action_Type = tostring(action_Type), category = tostring(category), country = tostring(country), timestamp = todatetime(timestamp), session_uuid = tostring(session_uuid), uuid_s = tostring(uuid_s), actor_details = todynamic(actor_details), log_source = tostring(log_source)'
        outputStream: 'Custom-OnePasswordEventLogs_CL'
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
