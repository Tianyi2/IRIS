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
// Data Collection Rule for SophosEPAlerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-SophosEPAlerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SophosEPAlerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SophosEPAlerts_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'CustomerId'
            type: 'string'
          }
          {
            name: 'ThreatName'
            type: 'string'
          }
          {
            name: 'info'
            type: 'dynamic'
          }
          {
            name: 'Source'
            type: 'string'
          }
          {
            name: 'data'
            type: 'dynamic'
          }
          {
            name: 'EventOriginalUid'
            type: 'string'
          }
          {
            name: 'DvcHostname'
            type: 'string'
          }
          {
            name: 'threat_cleanable'
            type: 'string'
          }
          {
            name: 'description'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'event_service_event_id'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'EventSeverity'
            type: 'string'
          }
          {
            name: 'DvcAction'
            type: 'string'
          }
          {
            name: 'Created'
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
          name: 'Sentinel-SophosEPAlerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SophosEPAlerts_CL']
        destinations: ['Sentinel-SophosEPAlerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), CustomerId = tostring(CustomerId), ThreatName = tostring(ThreatName), info = todynamic(info), Source = tostring(Source), data = todynamic(data), EventOriginalUid = tostring(EventOriginalUid), DvcHostname = tostring(DvcHostname), threat_cleanable = tobool(threat_cleanable), description = tostring(description), EventEndTime = todatetime(EventEndTime), event_service_event_id = tostring(event_service_event_id), EventProduct = tostring(EventProduct), EventType = tostring(EventType), EventVendor = tostring(EventVendor), EventSeverity = tostring(EventSeverity), DvcAction = tostring(DvcAction), Created = todatetime(Created)'
        outputStream: 'Custom-SophosEPAlerts_CL'
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
