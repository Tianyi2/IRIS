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
// Data Collection Rule for NexposeInsightVMCloud_vulnerabilities_CL
// ============================================================================
// Generated: 2025-09-19 14:20:26
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 49, DCR columns: 49 (Type column always filtered)
// Output stream: Custom-NexposeInsightVMCloud_vulnerabilities_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-NexposeInsightVMCloud_vulnerabilities_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-NexposeInsightVMCloud_vulnerabilities_CL': {
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
            name: 'vuln_details_cvss_v3_scope_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_user_interaction_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_vector_s'
            type: 'string'
          }
          {
            name: 'vuln_details_denial_of_service_b'
            type: 'string'
          }
          {
            name: 'vuln_details_description_s'
            type: 'string'
          }
          {
            name: 'vuln_details_exploits_s'
            type: 'string'
          }
          {
            name: 'vuln_details_id_s'
            type: 'string'
          }
          {
            name: 'vuln_details_links_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_privileges_required_s'
            type: 'string'
          }
          {
            name: 'vuln_details_malware_kits_s'
            type: 'string'
          }
          {
            name: 'vuln_details_pci_cvss_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_pci_fail_b'
            type: 'string'
          }
          {
            name: 'vuln_details_pci_severity_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_pci_special_notes_s'
            type: 'string'
          }
          {
            name: 'vuln_details_pci_status_s'
            type: 'string'
          }
          {
            name: 'vuln_details_published_t'
            type: 'string'
          }
          {
            name: 'vuln_details_references_s'
            type: 'string'
          }
          {
            name: 'vuln_details_risk_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_severity_s'
            type: 'string'
          }
          {
            name: 'vuln_details_modified_t'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_integrity_impact_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_impact_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_exploit_score_d'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'asset_id_s'
            type: 'string'
          }
          {
            name: 'host_name_s'
            type: 'string'
          }
          {
            name: 'ip_s'
            type: 'string'
          }
          {
            name: 'vuln_details_added_t'
            type: 'string'
          }
          {
            name: 'vuln_details_categories_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cves_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_access_complexity_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_access_vector_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_authentication_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_availability_impact_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_confidentiality_impact_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_exploit_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_impact_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_integrity_impact_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v2_vector_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_attack_complexity_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_attack_vector_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_availability_impact_s'
            type: 'string'
          }
          {
            name: 'vuln_details_cvss_v3_confidentiality_impact_s'
            type: 'string'
          }
          {
            name: 'vuln_details_severity_score_d'
            type: 'string'
          }
          {
            name: 'vuln_details_title_s'
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
          name: 'Sentinel-NexposeInsightVMCloud_vulnerabilities_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-NexposeInsightVMCloud_vulnerabilities_CL']
        destinations: ['Sentinel-NexposeInsightVMCloud_vulnerabilities_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), vuln_details_cvss_v3_scope_s = tostring(vuln_details_cvss_v3_scope_s), vuln_details_cvss_v3_score_d = toreal(vuln_details_cvss_v3_score_d), vuln_details_cvss_v3_user_interaction_s = tostring(vuln_details_cvss_v3_user_interaction_s), vuln_details_cvss_v3_vector_s = tostring(vuln_details_cvss_v3_vector_s), vuln_details_denial_of_service_b = tobool(vuln_details_denial_of_service_b), vuln_details_description_s = tostring(vuln_details_description_s), vuln_details_exploits_s = tostring(vuln_details_exploits_s), vuln_details_id_s = tostring(vuln_details_id_s), vuln_details_links_s = tostring(vuln_details_links_s), vuln_details_cvss_v3_privileges_required_s = tostring(vuln_details_cvss_v3_privileges_required_s), vuln_details_malware_kits_s = tostring(vuln_details_malware_kits_s), vuln_details_pci_cvss_score_d = toreal(vuln_details_pci_cvss_score_d), vuln_details_pci_fail_b = tobool(vuln_details_pci_fail_b), vuln_details_pci_severity_score_d = toreal(vuln_details_pci_severity_score_d), vuln_details_pci_special_notes_s = tostring(vuln_details_pci_special_notes_s), vuln_details_pci_status_s = tostring(vuln_details_pci_status_s), vuln_details_published_t = todatetime(vuln_details_published_t), vuln_details_references_s = tostring(vuln_details_references_s), vuln_details_risk_score_d = toreal(vuln_details_risk_score_d), vuln_details_severity_s = tostring(vuln_details_severity_s), vuln_details_modified_t = todatetime(vuln_details_modified_t), vuln_details_cvss_v3_integrity_impact_s = tostring(vuln_details_cvss_v3_integrity_impact_s), vuln_details_cvss_v3_impact_score_d = toreal(vuln_details_cvss_v3_impact_score_d), vuln_details_cvss_v3_exploit_score_d = toreal(vuln_details_cvss_v3_exploit_score_d), EventProduct = tostring(EventProduct), asset_id_s = tostring(asset_id_s), host_name_s = tostring(host_name_s), ip_s = tostring(ip_s), vuln_details_added_t = todatetime(vuln_details_added_t), vuln_details_categories_s = tostring(vuln_details_categories_s), vuln_details_cves_s = tostring(vuln_details_cves_s), vuln_details_cvss_v2_access_complexity_s = tostring(vuln_details_cvss_v2_access_complexity_s), vuln_details_cvss_v2_access_vector_s = tostring(vuln_details_cvss_v2_access_vector_s), vuln_details_cvss_v2_authentication_s = tostring(vuln_details_cvss_v2_authentication_s), vuln_details_cvss_v2_availability_impact_s = tostring(vuln_details_cvss_v2_availability_impact_s), vuln_details_cvss_v2_confidentiality_impact_s = tostring(vuln_details_cvss_v2_confidentiality_impact_s), vuln_details_cvss_v2_exploit_score_d = toreal(vuln_details_cvss_v2_exploit_score_d), vuln_details_cvss_v2_impact_score_d = toreal(vuln_details_cvss_v2_impact_score_d), vuln_details_cvss_v2_integrity_impact_s = tostring(vuln_details_cvss_v2_integrity_impact_s), vuln_details_cvss_v2_score_d = toreal(vuln_details_cvss_v2_score_d), vuln_details_cvss_v2_vector_s = tostring(vuln_details_cvss_v2_vector_s), vuln_details_cvss_v3_attack_complexity_s = tostring(vuln_details_cvss_v3_attack_complexity_s), vuln_details_cvss_v3_attack_vector_s = tostring(vuln_details_cvss_v3_attack_vector_s), vuln_details_cvss_v3_availability_impact_s = tostring(vuln_details_cvss_v3_availability_impact_s), vuln_details_cvss_v3_confidentiality_impact_s = tostring(vuln_details_cvss_v3_confidentiality_impact_s), vuln_details_severity_score_d = toreal(vuln_details_severity_score_d), vuln_details_title_s = tostring(vuln_details_title_s)'
        outputStream: 'Custom-NexposeInsightVMCloud_vulnerabilities_CL'
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
