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
// Data Collection Rule for Corelight_v2_datared_CL
// ============================================================================
// Generated: 2025-09-19 14:20:03
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-Corelight_v2_datared_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_datared_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_datared_CL': {
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
            name: 'x509_red_d'
            type: 'string'
          }
          {
            name: 'weird_total_d'
            type: 'string'
          }
          {
            name: 'weird_red_d'
            type: 'string'
          }
          {
            name: 'ssl_coal_miss_d'
            type: 'string'
          }
          {
            name: 'ssl_total_d'
            type: 'string'
          }
          {
            name: 'ssl_red_d'
            type: 'string'
          }
          {
            name: 'http_total_d'
            type: 'string'
          }
          {
            name: 'x509_total_d'
            type: 'string'
          }
          {
            name: 'http_red_d'
            type: 'string'
          }
          {
            name: 'files_total_d'
            type: 'string'
          }
          {
            name: 'files_red_d'
            type: 'string'
          }
          {
            name: 'dns_coal_miss_d'
            type: 'string'
          }
          {
            name: 'dns_total_d'
            type: 'string'
          }
          {
            name: 'dns_red_d'
            type: 'string'
          }
          {
            name: 'conn_total_d'
            type: 'string'
          }
          {
            name: 'conn_red_d'
            type: 'string'
          }
          {
            name: 'files_coal_miss_d'
            type: 'string'
          }
          {
            name: 'x509_coal_miss_d'
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
          name: 'Sentinel-Corelight_v2_datared_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_datared_CL']
        destinations: ['Sentinel-Corelight_v2_datared_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), x509_red_d = toreal(x509_red_d), weird_total_d = toreal(weird_total_d), weird_red_d = toreal(weird_red_d), ssl_coal_miss_d = toreal(ssl_coal_miss_d), ssl_total_d = toreal(ssl_total_d), ssl_red_d = toreal(ssl_red_d), http_total_d = toreal(http_total_d), x509_total_d = toreal(x509_total_d), http_red_d = toreal(http_red_d), files_total_d = toreal(files_total_d), files_red_d = toreal(files_red_d), dns_coal_miss_d = toreal(dns_coal_miss_d), dns_total_d = toreal(dns_total_d), dns_red_d = toreal(dns_red_d), conn_total_d = toreal(conn_total_d), conn_red_d = toreal(conn_red_d), files_coal_miss_d = toreal(files_coal_miss_d), x509_coal_miss_d = toreal(x509_coal_miss_d)'
        outputStream: 'Custom-Corelight_v2_datared_CL'
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
