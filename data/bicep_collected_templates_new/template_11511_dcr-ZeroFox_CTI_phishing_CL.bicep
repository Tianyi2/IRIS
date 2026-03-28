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
// Data Collection Rule for ZeroFox_CTI_phishing_CL
// ============================================================================
// Generated: 2025-09-19 14:20:40
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 10, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_phishing_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_phishing_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_phishing_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'scanned_t'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'cert_authority_s'
            type: 'string'
          }
          {
            name: 'cert_fingerprint_s'
            type: 'string'
          }
          {
            name: 'cert_issued_s'
            type: 'string'
          }
          {
            name: 'host_ip_s'
            type: 'string'
          }
          {
            name: 'host_asn_d'
            type: 'string'
          }
          {
            name: 'host_geo_s'
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
          name: 'Sentinel-ZeroFox_CTI_phishing_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_phishing_CL']
        destinations: ['Sentinel-ZeroFox_CTI_phishing_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), scanned_t = todatetime(scanned_t), domain_s = tostring(domain_s), url_s = tostring(url_s), cert_authority_s = tostring(cert_authority_s), cert_fingerprint_s = tostring(cert_fingerprint_s), cert_issued_s = tostring(cert_issued_s), host_ip_s = tostring(host_ip_s), host_asn_d = toreal(host_asn_d), host_geo_s = tostring(host_geo_s)'
        outputStream: 'Custom-ZeroFox_CTI_phishing_CL'
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
