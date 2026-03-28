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
// Data Collection Rule for ZeroFox_CTI_credit_cards_CL
// ============================================================================
// Generated: 2025-09-19 14:20:39
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 10, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_credit_cards_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_credit_cards_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_credit_cards_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'cc_num_s'
            type: 'string'
          }
          {
            name: 'month_s'
            type: 'string'
          }
          {
            name: 'year_s'
            type: 'string'
          }
          {
            name: 'cvv_s'
            type: 'string'
          }
          {
            name: 'issuer_s'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'cc_bin_s'
            type: 'string'
          }
          {
            name: 'breach_name_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
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
          name: 'Sentinel-ZeroFox_CTI_credit_cards_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_credit_cards_CL']
        destinations: ['Sentinel-ZeroFox_CTI_credit_cards_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), cc_num_s = tostring(cc_num_s), month_s = tostring(month_s), year_s = tostring(year_s), cvv_s = toreal(cvv_s), issuer_s = tostring(issuer_s), source_s = tostring(source_s), cc_bin_s = tostring(cc_bin_s), breach_name_s = tostring(breach_name_s), created_at_t = todatetime(created_at_t)'
        outputStream: 'Custom-ZeroFox_CTI_credit_cards_CL'
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
