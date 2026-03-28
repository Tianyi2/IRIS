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
// Data Collection Rule for Ipinfo_Company_CL
// ============================================================================
// Generated: 2025-09-19 14:20:22
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 10, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-Ipinfo_Company_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Ipinfo_Company_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Ipinfo_Company_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'as_domain'
            type: 'string'
          }
          {
            name: 'as_name'
            type: 'string'
          }
          {
            name: 'as_type'
            type: 'string'
          }
          {
            name: 'asn'
            type: 'string'
          }
          {
            name: 'country'
            type: 'string'
          }
          {
            name: 'company_domain'
            type: 'string'
          }
          {
            name: 'company_name'
            type: 'string'
          }
          {
            name: 'company_type'
            type: 'string'
          }
          {
            name: 'range'
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
          name: 'Sentinel-Ipinfo_Company_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Ipinfo_Company_CL']
        destinations: ['Sentinel-Ipinfo_Company_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), as_domain = tostring(as_domain), as_name = tostring(as_name), as_type = tostring(as_type), asn = tostring(asn), country = tostring(country), company_domain = tostring(company_domain), company_name = tostring(company_name), company_type = tostring(company_type), range = tostring(range)'
        outputStream: 'Custom-Ipinfo_Company_CL'
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
