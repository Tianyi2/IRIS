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
// Data Collection Rule for beSECURE_ScanEvent_CL
// ============================================================================
// Generated: 2025-09-19 14:19:55
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 16 (Type column always filtered)
// Output stream: Custom-beSECURE_ScanEvent_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-beSECURE_ScanEvent_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-beSECURE_ScanEvent_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'additional_information'
            type: 'string'
          }
          {
            name: 'event_code'
            type: 'string'
          }
          {
            name: 'event_id'
            type: 'string'
          }
          {
            name: 'event_name'
            type: 'string'
          }
          {
            name: 'event_time'
            type: 'string'
          }
          {
            name: 'scan_id'
            type: 'string'
          }
          {
            name: 'scan_name'
            type: 'string'
          }
          {
            name: 'scan_type'
            type: 'string'
          }
          {
            name: 'scan_event_s'
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
          name: 'Sentinel-beSECURE_ScanEvent_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-beSECURE_ScanEvent_CL']
        destinations: ['Sentinel-beSECURE_ScanEvent_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), additional_information = tostring(additional_information), event_code = tostring(event_code), event_id = tostring(event_id), event_name = tostring(event_name), event_time = tostring(event_time), scan_id = tostring(scan_id), scan_name = tostring(scan_name), scan_type = tostring(scan_type), scan_event_s = tostring(scan_event_s)'
        outputStream: 'Custom-beSECURE_ScanEvent_CL'
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
