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
// Data Collection Rule for BitsightBreaches_data_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 16, DCR columns: 15 (Type column always filtered)
// Output stream: Custom-BitsightBreaches_data_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitsightBreaches_data_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitsightBreaches_data_CL': {
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
            name: 'GUID'
            type: 'string'
          }
          {
            name: 'Date'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'Text'
            type: 'string'
          }
          {
            name: 'DateCreated'
            type: 'string'
          }
          {
            name: 'PreviwURL'
            type: 'string'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'EventTypeDescription'
            type: 'string'
          }
          {
            name: 'BreachedCompanies'
            type: 'string'
          }
          {
            name: 'DependentCompanies'
            type: 'string'
          }
          {
            name: 'Companyname'
            type: 'string'
          }
          {
            name: 'CompanyGUID'
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
          name: 'Sentinel-BitsightBreaches_data_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitsightBreaches_data_CL']
        destinations: ['Sentinel-BitsightBreaches_data_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), EventProduct = tostring(EventProduct), GUID = tostring(GUID), Date = tostring(Date), Severity = toint(Severity), Text = tostring(Text), DateCreated = tostring(DateCreated), PreviwURL = tostring(PreviwURL), EventType = tostring(EventType), EventTypeDescription = tostring(EventTypeDescription), BreachedCompanies = tostring(BreachedCompanies), DependentCompanies = tostring(DependentCompanies), Companyname = tostring(Companyname), CompanyGUID = tostring(CompanyGUID)'
        outputStream: 'Custom-BitsightBreaches_data_CL'
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
