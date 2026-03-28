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
// Data Collection Rule for WsSecurityEvents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:38
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 16, DCR columns: 16 (Type column always filtered)
// Output stream: Custom-WsSecurityEvents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-WsSecurityEvents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-WsSecurityEvents_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Activity'
            type: 'string'
          }
          {
            name: 'AdditionalExtensions'
            type: 'string'
          }
          {
            name: 'DeviceAction'
            type: 'string'
          }
          {
            name: 'DeviceCustomString1'
            type: 'string'
          }
          {
            name: 'DeviceCustomString1Label'
            type: 'string'
          }
          {
            name: 'DeviceCustomString2'
            type: 'string'
          }
          {
            name: 'DeviceCustomString2Label'
            type: 'string'
          }
          {
            name: 'DeviceEventClassID'
            type: 'string'
          }
          {
            name: 'DeviceVendor'
            type: 'string'
          }
          {
            name: 'LogSeverity'
            type: 'string'
          }
          {
            name: 'Message'
            type: 'string'
          }
          {
            name: 'SimplifiedDeviceAction'
            type: 'string'
          }
          {
            name: 'SourceHostName'
            type: 'string'
          }
          {
            name: 'SourceUserName'
            type: 'string'
          }
          {
            name: 'PersistenceTimestamp'
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
          name: 'Sentinel-WsSecurityEvents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-WsSecurityEvents_CL']
        destinations: ['Sentinel-WsSecurityEvents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Activity = tostring(Activity), AdditionalExtensions = tostring(AdditionalExtensions), DeviceAction = tostring(DeviceAction), DeviceCustomString1 = tostring(DeviceCustomString1), DeviceCustomString1Label = tostring(DeviceCustomString1Label), DeviceCustomString2 = tostring(DeviceCustomString2), DeviceCustomString2Label = tostring(DeviceCustomString2Label), DeviceEventClassID = tostring(DeviceEventClassID), DeviceVendor = tostring(DeviceVendor), LogSeverity = toint(LogSeverity), Message = tostring(Message), SimplifiedDeviceAction = tostring(SimplifiedDeviceAction), SourceHostName = tostring(SourceHostName), SourceUserName = tostring(SourceUserName), PersistenceTimestamp = todatetime(PersistenceTimestamp)'
        outputStream: 'Custom-WsSecurityEvents_CL'
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
