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
// Data Collection Rule for BitsightCompany_rating_details_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 15, DCR columns: 14 (Type column always filtered)
// Output stream: Custom-BitsightCompany_rating_details_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitsightCompany_rating_details_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitsightCompany_rating_details_CL': {
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
            name: 'CompanyName'
            type: 'string'
          }
          {
            name: 'Beta'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'CategoryOrder'
            type: 'string'
          }
          {
            name: 'DisplayURL'
            type: 'string'
          }
          {
            name: 'Grade'
            type: 'string'
          }
          {
            name: 'GradeColor'
            type: 'string'
          }
          {
            name: 'Name'
            type: 'string'
          }
          {
            name: 'Order'
            type: 'string'
          }
          {
            name: 'Percentile'
            type: 'string'
          }
          {
            name: 'Rating'
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
          name: 'Sentinel-BitsightCompany_rating_details_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitsightCompany_rating_details_CL']
        destinations: ['Sentinel-BitsightCompany_rating_details_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), EventProduct = tostring(EventProduct), CompanyName = tostring(CompanyName), Beta = tobool(Beta), Category = tostring(Category), CategoryOrder = toreal(CategoryOrder), DisplayURL = tostring(DisplayURL), Grade = tostring(Grade), GradeColor = tostring(GradeColor), Name = tostring(Name), Order = toreal(Order), Percentile = toreal(Percentile), Rating = toreal(Rating)'
        outputStream: 'Custom-BitsightCompany_rating_details_CL'
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
