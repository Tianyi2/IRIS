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
// Data Collection Rule for Gigamon_CL
// ============================================================================
// Generated: 2025-09-19 14:20:20
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 52, DCR columns: 48 (Type column always filtered)
// Output stream: Custom-Gigamon_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Gigamon_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Gigamon_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'uri_fileextension_s'
            type: 'string'
          }
          {
            name: 'basic_constraints_subject_type_s'
            type: 'string'
          }
          {
            name: 'certificateserialnumber_s'
            type: 'string'
          }
          {
            name: 'certificatesha256fingerprint_s'
            type: 'string'
          }
          {
            name: 'severity_type_s'
            type: 'string'
          }
          {
            name: 'truststatus_s'
            type: 'string'
          }
          {
            name: 'agentlastip_s'
            type: 'string'
          }
          {
            name: 'resultsuri_s'
            type: 'string'
          }
          {
            name: 'severity_ISG_PostQuantum_Security_s'
            type: 'string'
          }
          {
            name: 'certificatenotbefore_t'
            type: 'string'
          }
          {
            name: 'rank_s'
            type: 'string'
          }
          {
            name: 'agentid_s'
            type: 'string'
          }
          {
            name: 'standard_name_s'
            type: 'string'
          }
          {
            name: 'crypto_scanid_d'
            type: 'string'
          }
          {
            name: 'uri_filename_s'
            type: 'string'
          }
          {
            name: 'uri_filepath_s'
            type: 'string'
          }
          {
            name: 'agenthostname_s'
            type: 'string'
          }
          {
            name: 'starttime_t'
            type: 'string'
          }
          {
            name: 'object_fingerprint_s'
            type: 'string'
          }
          {
            name: 'endtime_t'
            type: 'string'
          }
          {
            name: 'standard_cse_classification_s'
            type: 'string'
          }
          {
            name: 'library_severity_description_s'
            type: 'string'
          }
          {
            name: 'severity_description_s'
            type: 'string'
          }
          {
            name: 'certificatepublickeysize_d'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'certificateextensions_s'
            type: 'string'
          }
          {
            name: 'certificateextkeyusage_s'
            type: 'string'
          }
          {
            name: 'certificatesha1fingerprint_s'
            type: 'string'
          }
          {
            name: 'certificatepublickeyalgorithm_s'
            type: 'string'
          }
          {
            name: 'certificatesignaturealgorithm_s'
            type: 'string'
          }
          {
            name: 'resultsscheme_s'
            type: 'string'
          }
          {
            name: 'certificatekeyusage_s'
            type: 'string'
          }
          {
            name: 'severity_score_s'
            type: 'string'
          }
          {
            name: 'certificatevaliditydays_d'
            type: 'string'
          }
          {
            name: 'basic_constraints_path_length_s'
            type: 'string'
          }
          {
            name: 'certificate_issuer_type_s'
            type: 'string'
          }
          {
            name: 'certificateselfsigned_s'
            type: 'string'
          }
          {
            name: 'cnformat_s'
            type: 'string'
          }
          {
            name: 'certificateparsingerror_s'
            type: 'string'
          }
          {
            name: 'certificate_usage_s'
            type: 'string'
          }
          {
            name: 'certs_scanid_d'
            type: 'string'
          }
          {
            name: 'uri_filetype_s'
            type: 'string'
          }
          {
            name: 'keyid_s'
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
          name: 'Sentinel-Gigamon_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Gigamon_CL']
        destinations: ['Sentinel-Gigamon_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), uri_fileextension_s = tostring(uri_fileextension_s), basic_constraints_subject_type_s = tostring(basic_constraints_subject_type_s), certificateserialnumber_s = tostring(certificateserialnumber_s), certificatesha256fingerprint_s = tostring(certificatesha256fingerprint_s), severity_type_s = tostring(severity_type_s), truststatus_s = tostring(truststatus_s), agentlastip_s = tostring(agentlastip_s), resultsuri_s = tostring(resultsuri_s), severity_ISG_PostQuantum_Security_s = tostring(severity_ISG_PostQuantum_Security_s), certificatenotbefore_t = tostring(certificatenotbefore_t), rank_s = tostring(rank_s), agentid_s = tostring(agentid_s), standard_name_s = tostring(standard_name_s), crypto_scanid_d = toreal(crypto_scanid_d), uri_filename_s = tostring(uri_filename_s), uri_filepath_s = tostring(uri_filepath_s), agenthostname_s = tostring(agenthostname_s), starttime_t = tostring(starttime_t), object_fingerprint_s = tostring(object_fingerprint_s), endtime_t = tostring(endtime_t), standard_cse_classification_s = tostring(standard_cse_classification_s), library_severity_description_s = tostring(library_severity_description_s), severity_description_s = tostring(severity_description_s), certificatepublickeysize_d = toreal(certificatepublickeysize_d), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), RawData = tostring(RawData), certificateextensions_s = toreal(certificateextensions_s), certificateextkeyusage_s = tostring(certificateextkeyusage_s), certificatesha1fingerprint_s = tostring(certificatesha1fingerprint_s), certificatepublickeyalgorithm_s = tostring(certificatepublickeyalgorithm_s), certificatesignaturealgorithm_s = tostring(certificatesignaturealgorithm_s), resultsscheme_s = tostring(resultsscheme_s), certificatekeyusage_s = tostring(certificatekeyusage_s), severity_score_s = tostring(severity_score_s), certificatevaliditydays_d = toreal(certificatevaliditydays_d), basic_constraints_path_length_s = tostring(basic_constraints_path_length_s), certificate_issuer_type_s = tostring(certificate_issuer_type_s), certificateselfsigned_s = tostring(certificateselfsigned_s), cnformat_s = tostring(cnformat_s), certificateparsingerror_s = tostring(certificateparsingerror_s), certificate_usage_s = tostring(certificate_usage_s), certs_scanid_d = toreal(certs_scanid_d), uri_filetype_s = tostring(uri_filetype_s), keyid_s = tostring(keyid_s)'
        outputStream: 'Custom-Gigamon_CL'
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
