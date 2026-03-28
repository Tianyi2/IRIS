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
// Data Collection Rule for ZeroFox_CTI_email_addresses_CL
// ============================================================================
// Generated: 2025-09-19 14:20:39
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 5, DCR columns: 5 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_email_addresses_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_email_addresses_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_email_addresses_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'email_s'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'tags_s'
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
          name: 'Sentinel-ZeroFox_CTI_email_addresses_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_email_addresses_CL']
        destinations: ['Sentinel-ZeroFox_CTI_email_addresses_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), created_at_t = todatetime(created_at_t), email_s = tostring(email_s), domain_s = tostring(domain_s), tags_s = tostring(tags_s)'
        outputStream: 'Custom-ZeroFox_CTI_email_addresses_CL'
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
