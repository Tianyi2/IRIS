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
// Data Collection Rule for Corelight_v2_x509_CL
// ============================================================================
// Generated: 2025-09-19 14:20:14
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 26, DCR columns: 23 (Type column always filtered)
// Output stream: Custom-Corelight_v2_x509_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_x509_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_x509_CL': {
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
            name: 'basic_constraints_path_len_d'
            type: 'string'
          }
          {
            name: 'basic_constraints_ca_b'
            type: 'string'
          }
          {
            name: 'san_ip_s'
            type: 'string'
          }
          {
            name: 'san_email_s'
            type: 'string'
          }
          {
            name: 'san_uri_s'
            type: 'string'
          }
          {
            name: 'san_dns_s'
            type: 'string'
          }
          {
            name: 'certificate_curve_s'
            type: 'string'
          }
          {
            name: 'certificate_exponent_s'
            type: 'string'
          }
          {
            name: 'certificate_key_length_d'
            type: 'string'
          }
          {
            name: 'certificate_key_type_s'
            type: 'string'
          }
          {
            name: 'certificate_sig_alg_s'
            type: 'string'
          }
          {
            name: 'certificate_key_alg_s'
            type: 'string'
          }
          {
            name: 'certificate_not_valid_after_t'
            type: 'string'
          }
          {
            name: 'certificate_not_valid_before_t'
            type: 'string'
          }
          {
            name: 'certificate_issuer_s'
            type: 'string'
          }
          {
            name: 'certificate_subject_s'
            type: 'string'
          }
          {
            name: 'certificate_serial_s'
            type: 'string'
          }
          {
            name: 'certificate_version_d'
            type: 'string'
          }
          {
            name: 'fingerprint_s'
            type: 'string'
          }
          {
            name: 'host_cert_b'
            type: 'string'
          }
          {
            name: 'client_cert_b'
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
          name: 'Sentinel-Corelight_v2_x509_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_x509_CL']
        destinations: ['Sentinel-Corelight_v2_x509_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), basic_constraints_path_len_d = toreal(basic_constraints_path_len_d), basic_constraints_ca_b = tobool(basic_constraints_ca_b), san_ip_s = tostring(san_ip_s), san_email_s = tostring(san_email_s), san_uri_s = tostring(san_uri_s), san_dns_s = tostring(san_dns_s), certificate_curve_s = tostring(certificate_curve_s), certificate_exponent_s = tostring(certificate_exponent_s), certificate_key_length_d = toreal(certificate_key_length_d), certificate_key_type_s = tostring(certificate_key_type_s), certificate_sig_alg_s = tostring(certificate_sig_alg_s), certificate_key_alg_s = tostring(certificate_key_alg_s), certificate_not_valid_after_t = todatetime(certificate_not_valid_after_t), certificate_not_valid_before_t = todatetime(certificate_not_valid_before_t), certificate_issuer_s = tostring(certificate_issuer_s), certificate_subject_s = tostring(certificate_subject_s), certificate_serial_s = tostring(certificate_serial_s), certificate_version_d = toreal(certificate_version_d), fingerprint_s = tostring(fingerprint_s), host_cert_b = tobool(host_cert_b), client_cert_b = tobool(client_cert_b)'
        outputStream: 'Custom-Corelight_v2_x509_CL'
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
