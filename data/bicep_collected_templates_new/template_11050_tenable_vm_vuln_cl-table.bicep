// Bicep template for Log Analytics custom table: Tenable_VM_Vuln_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 65, Deployed columns: 63 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource tenablevmvulnclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Tenable_VM_Vuln_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Tenable_VM_Vuln_CL'
      description: 'Custom table Tenable_VM_Vuln_CL - imported from JSON schema'
      displayName: 'Tenable_VM_Vuln_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
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
          type: 'real'
        }
        {
          name: 'plugin_vpr_drivers_age_of_vuln_lower_bound_d'
          type: 'real'
        }
        {
          name: 'plugin_vpr_drivers_age_of_vuln_upper_bound_d'
          type: 'real'
        }
        {
          name: 'plugin_vpr_drivers_exploit_code_maturity_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'plugin_vpr_drivers_cvss_impact_score_predicted_b'
          type: 'boolean'
        }
        {
          name: 'plugin_vpr_drivers_cvss3_impact_score_d'
          type: 'real'
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
          type: 'dateTime'
        }
        {
          name: 'port_port_d'
          type: 'real'
        }
        {
          name: 'port_protocol_s'
          type: 'string'
        }
        {
          name: 'scan_completed_at_t'
          type: 'dateTime'
        }
        {
          name: 'scan_schedule_uuid_s'
          type: 'string'
        }
        {
          name: 'scan_started_at_t'
          type: 'dateTime'
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
          type: 'real'
        }
        {
          name: 'severity_default_id_d'
          type: 'real'
        }
        {
          name: 'severity_modification_type_s'
          type: 'string'
        }
        {
          name: 'first_found_t'
          type: 'dateTime'
        }
        {
          name: 'last_found_t'
          type: 'dateTime'
        }
        {
          name: 'plugin_id_d'
          type: 'real'
        }
        {
          name: 'plugin_has_patch_b'
          type: 'boolean'
        }
        {
          name: 'plugin_family_id_d'
          type: 'real'
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
          type: 'boolean'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'state_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = tenablevmvulnclTable.name
output tableId string = tenablevmvulnclTable.id
output provisioningState string = tenablevmvulnclTable.properties.provisioningState
