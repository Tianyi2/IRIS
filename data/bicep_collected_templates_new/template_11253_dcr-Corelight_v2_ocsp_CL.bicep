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
// Data Collection Rule for Corelight_v2_ocsp_CL
// ============================================================================
// Generated: 2025-09-19 14:20:09
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 15, DCR columns: 12 (Type column always filtered)
// Output stream: Custom-Corelight_v2_ocsp_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_ocsp_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_ocsp_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'ts_t'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'hashAlgorithm_s'
            type: 'string'
          }
          {
            name: 'issuerNameHash_s'
            type: 'string'
          }
          {
            name: 'issuerKeyHash_s'
            type: 'string'
          }
          {
            name: 'serialNumber_s'
            type: 'string'
          }
          {
            name: 'certStatus_s'
            type: 'string'
          }
          {
            name: 'revoketime_t'
            type: 'string'
          }
          {
            name: 'revokereason_s'
            type: 'string'
          }
          {
            name: 'thisUpdate_t'
            type: 'string'
          }
          {
            name: 'nextUpdate_t'
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
          name: 'Sentinel-Corelight_v2_ocsp_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_ocsp_CL']
        destinations: ['Sentinel-Corelight_v2_ocsp_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), id_s = tostring(id_s), hashAlgorithm_s = tostring(hashAlgorithm_s), issuerNameHash_s = tostring(issuerNameHash_s), issuerKeyHash_s = tostring(issuerKeyHash_s), serialNumber_s = tostring(serialNumber_s), certStatus_s = tostring(certStatus_s), revoketime_t = todatetime(revoketime_t), revokereason_s = tostring(revokereason_s), thisUpdate_t = todatetime(thisUpdate_t), nextUpdate_t = todatetime(nextUpdate_t)'
        outputStream: 'Custom-Corelight_v2_ocsp_CL'
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
