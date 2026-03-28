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
// Data Collection Rule for BitsightFindings_summary_CL
// ============================================================================
// Generated: 2025-09-19 14:19:57
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 15, DCR columns: 14 (Type column always filtered)
// Output stream: Custom-BitsightFindings_summary_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitsightFindings_summary_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitsightFindings_summary_CL': {
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
            name: 'Company'
            type: 'string'
          }
          {
            name: 'Confidence'
            type: 'string'
          }
          {
            name: 'Description'
            type: 'string'
          }
          {
            name: 'EndDate'
            type: 'string'
          }
          {
            name: 'EventCount'
            type: 'string'
          }
          {
            name: 'FirstSeen'
            type: 'string'
          }
          {
            name: 'HostCount'
            type: 'string'
          }
          {
            name: 'Id'
            type: 'string'
          }
          {
            name: 'Name'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'StartDate'
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
          name: 'Sentinel-BitsightFindings_summary_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitsightFindings_summary_CL']
        destinations: ['Sentinel-BitsightFindings_summary_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), EventProduct = tostring(EventProduct), Company = tostring(Company), Confidence = tostring(Confidence), Description = tostring(Description), EndDate = tostring(EndDate), EventCount = toreal(EventCount), FirstSeen = tostring(FirstSeen), HostCount = toreal(HostCount), Id = tostring(Id), Name = tostring(Name), Severity = tostring(Severity), StartDate = tostring(StartDate)'
        outputStream: 'Custom-BitsightFindings_summary_CL'
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
