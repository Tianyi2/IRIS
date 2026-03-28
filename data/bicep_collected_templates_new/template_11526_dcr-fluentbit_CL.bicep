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
// Data Collection Rule for fluentbit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:18
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 17 (Type column always filtered)
// Output stream: Custom-fluentbit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-fluentbit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-fluentbit_CL': {
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
            name: 'pri_s'
            type: 'string'
          }
          {
            name: 'time_s'
            type: 'string'
          }
          {
            name: 'host_s'
            type: 'string'
          }
          {
            name: 'ident_s'
            type: 'string'
          }
          {
            name: 'Year_s'
            type: 'string'
          }
          {
            name: 'Month_s'
            type: 'string'
          }
          {
            name: 'Day_s'
            type: 'string'
          }
          {
            name: 'Hour_s'
            type: 'string'
          }
          {
            name: 'Min_s'
            type: 'string'
          }
          {
            name: 'Sec_s'
            type: 'string'
          }
          {
            name: 'Message'
            type: 'string'
          }
          {
            name: 'FirewallName_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'action'
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
          name: 'Sentinel-fluentbit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-fluentbit_CL']
        destinations: ['Sentinel-fluentbit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), SourceSystem = tostring(SourceSystem), pri_s = tostring(pri_s), time_s = tostring(time_s), host_s = tostring(host_s), ident_s = tostring(ident_s), Year_s = tostring(Year_s), Month_s = tostring(Month_s), Day_s = tostring(Day_s), Hour_s = tostring(Hour_s), Min_s = tostring(Min_s), Sec_s = tostring(Sec_s), Message = tostring(Message), FirewallName_s = tostring(FirewallName_s), RawData = tostring(RawData), action = tostring(action)'
        outputStream: 'Custom-fluentbit_CL'
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
