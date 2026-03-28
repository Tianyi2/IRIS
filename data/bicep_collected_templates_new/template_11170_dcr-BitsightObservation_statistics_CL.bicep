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
// Data Collection Rule for BitsightObservation_statistics_CL
// ============================================================================
// Generated: 2025-09-19 14:19:57
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 9, DCR columns: 8 (Type column always filtered)
// Output stream: Custom-BitsightObservation_statistics_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitsightObservation_statistics_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitsightObservation_statistics_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'Count'
            type: 'string'
          }
          {
            name: 'CountPeriod'
            type: 'string'
          }
          {
            name: 'AverageDurationDays'
            type: 'string'
          }
          {
            name: 'RiskVector'
            type: 'string'
          }
          {
            name: 'CompanyName'
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
          name: 'Sentinel-BitsightObservation_statistics_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitsightObservation_statistics_CL']
        destinations: ['Sentinel-BitsightObservation_statistics_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), EventProduct = tostring(EventProduct), Count = toreal(Count), CountPeriod = tostring(CountPeriod), AverageDurationDays = toreal(AverageDurationDays), RiskVector = tostring(RiskVector), CompanyName = tostring(CompanyName)'
        outputStream: 'Custom-BitsightObservation_statistics_CL'
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
