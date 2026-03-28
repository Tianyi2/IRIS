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
// Data Collection Rule for Tenable_VM_Vuln_CL
// ============================================================================
// Generated: 2025-09-19 14:20:35
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 65, DCR columns: 63 (Type column always filtered)
// Output stream: Custom-Tenable_VM_Vuln_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Tenable_VM_Vuln_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Tenable_VM_Vuln_CL': {
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
            name: 'plugin_name_s'
            type: 'string'
          }
          {
            name: 'plugin_risk_factor_s'
            type: 'string'
          }
          {
            name: 'plugin_see_also_s'
            type: 'string'
          }
          {
            name: 'plugin_solution_s'
            type: 'string'
          }
          {
            name: 'plugin_synopsis_s'
            type: 'string'
          }
          {
            name: 'plugin_vpr_score_d'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_age_of_vuln_lower_bound_d'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_age_of_vuln_upper_bound_d'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_exploit_code_maturity_s'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_cvss_impact_score_predicted_b'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_cvss3_impact_score_d'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_threat_intensity_last28_s'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_threat_sources_last28_s'
            type: 'string'
          }
          {
            name: 'plugin_vpr_drivers_product_coverage_s'
            type: 'string'
          }
          {
            name: 'plugin_vpr_updated_t'
            type: 'string'
          }
          {
            name: 'port_port_d'
            type: 'string'
          }
          {
            name: 'port_protocol_s'
            type: 'string'
          }
          {
            name: 'scan_completed_at_t'
            type: 'string'
          }
          {
            name: 'scan_schedule_uuid_s'
            type: 'string'
          }
          {
            name: 'scan_started_at_t'
            type: 'string'
          }
          {
            name: 'scan_uuid_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'severity_id_d'
            type: 'string'
          }
          {
            name: 'severity_default_id_d'
            type: 'string'
          }
          {
            name: 'severity_modification_type_s'
            type: 'string'
          }
          {
            name: 'first_found_t'
            type: 'string'
          }
          {
            name: 'last_found_t'
            type: 'string'
          }
          {
            name: 'plugin_id_d'
            type: 'string'
          }
          {
            name: 'plugin_has_patch_b'
            type: 'string'
          }
          {
            name: 'plugin_family_id_d'
            type: 'string'
          }
          {
            name: 'plugin_family_s'
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
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'asset_fqdn_s'
            type: 'string'
          }
          {
            name: 'asset_hostname_s'
            type: 'string'
          }
          {
            name: 'asset_uuid_g'
            type: 'string'
          }
          {
            name: 'asset_ipv4_s'
            type: 'string'
          }
          {
            name: 'asset_operating_system_s'
            type: 'string'
          }
          {
            name: 'asset_network_id_g'
            type: 'string'
          }
          {
            name: 'asset_tracked_b'
            type: 'string'
          }
          {
            name: 'output_s'
            type: 'string'
          }
          {
            name: 'indexed_at_s'
            type: 'string'
          }
          {
            name: 'plugin_cve_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_temporal_score_d'
            type: 'string'
          }
          {
            name: 'plugin_cvss_temporal_vector_exploitability_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_temporal_vector_remediation_level_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_temporal_vector_report_confidence_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_temporal_vector_raw_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_vector_access_complexity_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_vector_access_vector_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_vector_authentication_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_vector_confidentiality_impact_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_vector_integrity_impact_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_vector_availability_impact_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_vector_raw_s'
            type: 'string'
          }
          {
            name: 'plugin_description_s'
            type: 'string'
          }
          {
            name: 'plugin_cvss_base_score_d'
            type: 'string'
          }
          {
            name: 'state_s'
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
          name: 'Sentinel-Tenable_VM_Vuln_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Tenable_VM_Vuln_CL']
        destinations: ['Sentinel-Tenable_VM_Vuln_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), plugin_name_s = tostring(plugin_name_s), plugin_risk_factor_s = tostring(plugin_risk_factor_s), plugin_see_also_s = tostring(plugin_see_also_s), plugin_solution_s = tostring(plugin_solution_s), plugin_synopsis_s = tostring(plugin_synopsis_s), plugin_vpr_score_d = toreal(plugin_vpr_score_d), plugin_vpr_drivers_age_of_vuln_lower_bound_d = toreal(plugin_vpr_drivers_age_of_vuln_lower_bound_d), plugin_vpr_drivers_age_of_vuln_upper_bound_d = toreal(plugin_vpr_drivers_age_of_vuln_upper_bound_d), plugin_vpr_drivers_exploit_code_maturity_s = tostring(plugin_vpr_drivers_exploit_code_maturity_s), plugin_vpr_drivers_cvss_impact_score_predicted_b = tobool(plugin_vpr_drivers_cvss_impact_score_predicted_b), plugin_vpr_drivers_cvss3_impact_score_d = toreal(plugin_vpr_drivers_cvss3_impact_score_d), plugin_vpr_drivers_threat_intensity_last28_s = tostring(plugin_vpr_drivers_threat_intensity_last28_s), plugin_vpr_drivers_threat_sources_last28_s = tostring(plugin_vpr_drivers_threat_sources_last28_s), plugin_vpr_drivers_product_coverage_s = tostring(plugin_vpr_drivers_product_coverage_s), plugin_vpr_updated_t = todatetime(plugin_vpr_updated_t), port_port_d = toreal(port_port_d), port_protocol_s = tostring(port_protocol_s), scan_completed_at_t = todatetime(scan_completed_at_t), scan_schedule_uuid_s = tostring(scan_schedule_uuid_s), scan_started_at_t = todatetime(scan_started_at_t), scan_uuid_s = tostring(scan_uuid_s), severity_s = tostring(severity_s), severity_id_d = toreal(severity_id_d), severity_default_id_d = toreal(severity_default_id_d), severity_modification_type_s = tostring(severity_modification_type_s), first_found_t = todatetime(first_found_t), last_found_t = todatetime(last_found_t), plugin_id_d = toreal(plugin_id_d), plugin_has_patch_b = tobool(plugin_has_patch_b), plugin_family_id_d = toreal(plugin_family_id_d), plugin_family_s = tostring(plugin_family_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), asset_fqdn_s = tostring(asset_fqdn_s), asset_hostname_s = tostring(asset_hostname_s), asset_uuid_g = tostring(asset_uuid_g), asset_ipv4_s = tostring(asset_ipv4_s), asset_operating_system_s = tostring(asset_operating_system_s), asset_network_id_g = tostring(asset_network_id_g), asset_tracked_b = tobool(asset_tracked_b), output_s = tostring(output_s), indexed_at_s = tostring(indexed_at_s), plugin_cve_s = tostring(plugin_cve_s), plugin_cvss_temporal_score_d = toreal(plugin_cvss_temporal_score_d), plugin_cvss_temporal_vector_exploitability_s = tostring(plugin_cvss_temporal_vector_exploitability_s), plugin_cvss_temporal_vector_remediation_level_s = tostring(plugin_cvss_temporal_vector_remediation_level_s), plugin_cvss_temporal_vector_report_confidence_s = tostring(plugin_cvss_temporal_vector_report_confidence_s), plugin_cvss_temporal_vector_raw_s = tostring(plugin_cvss_temporal_vector_raw_s), plugin_cvss_vector_access_complexity_s = tostring(plugin_cvss_vector_access_complexity_s), plugin_cvss_vector_access_vector_s = tostring(plugin_cvss_vector_access_vector_s), plugin_cvss_vector_authentication_s = tostring(plugin_cvss_vector_authentication_s), plugin_cvss_vector_confidentiality_impact_s = tostring(plugin_cvss_vector_confidentiality_impact_s), plugin_cvss_vector_integrity_impact_s = tostring(plugin_cvss_vector_integrity_impact_s), plugin_cvss_vector_availability_impact_s = tostring(plugin_cvss_vector_availability_impact_s), plugin_cvss_vector_raw_s = tostring(plugin_cvss_vector_raw_s), plugin_description_s = tostring(plugin_description_s), plugin_cvss_base_score_d = toreal(plugin_cvss_base_score_d), state_s = tostring(state_s)'
        outputStream: 'Custom-Tenable_VM_Vuln_CL'
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
