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
// Data Collection Rule for Illumio_Auditable_Events_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 11, DCR columns: 11 (Type column always filtered)
// Output stream: Custom-Illumio_Auditable_Events_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Illumio_Auditable_Events_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Illumio_Auditable_Events_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'href'
            type: 'string'
          }
          {
            name: 'pce_fqdn'
            type: 'string'
          }
          {
            name: 'created_by'
            type: 'dynamic'
          }
          {
            name: 'event_type'
            type: 'string'
          }
          {
            name: 'status'
            type: 'string'
          }
          {
            name: 'severity'
            type: 'string'
          }
          {
            name: 'action'
            type: 'dynamic'
          }
          {
            name: 'resource_changes'
            type: 'dynamic'
          }
          {
            name: 'notifications'
            type: 'dynamic'
          }
          {
            name: 'version'
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
          name: 'Sentinel-Illumio_Auditable_Events_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Illumio_Auditable_Events_CL']
        destinations: ['Sentinel-Illumio_Auditable_Events_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), href = tostring(href), pce_fqdn = tostring(pce_fqdn), created_by = todynamic(created_by), event_type = tostring(event_type), status = tostring(status), severity = tostring(severity), action = todynamic(action), resource_changes = todynamic(resource_changes), notifications = todynamic(notifications), version = toint(version)'
        outputStream: 'Custom-Illumio_Auditable_Events_CL'
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
