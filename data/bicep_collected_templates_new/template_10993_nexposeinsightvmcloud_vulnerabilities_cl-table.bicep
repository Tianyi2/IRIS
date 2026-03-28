// Bicep template for Log Analytics custom table: NexposeInsightVMCloud_vulnerabilities_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 49, Deployed columns: 49 (Type column filtered)
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

resource nexposeinsightvmcloudvulnerabilitiesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'NexposeInsightVMCloud_vulnerabilities_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'NexposeInsightVMCloud_vulnerabilities_CL'
      description: 'Custom table NexposeInsightVMCloud_vulnerabilities_CL - imported from JSON schema'
      displayName: 'NexposeInsightVMCloud_vulnerabilities_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
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
          type: 'real'
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
          type: 'boolean'
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
          dataTypeHint: 0
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
          type: 'real'
        }
        {
          name: 'vuln_details_pci_fail_b'
          type: 'boolean'
        }
        {
          name: 'vuln_details_pci_severity_score_d'
          type: 'real'
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
          type: 'dateTime'
        }
        {
          name: 'vuln_details_references_s'
          type: 'string'
        }
        {
          name: 'vuln_details_risk_score_d'
          type: 'real'
        }
        {
          name: 'vuln_details_severity_s'
          type: 'string'
        }
        {
          name: 'vuln_details_modified_t'
          type: 'dateTime'
        }
        {
          name: 'vuln_details_cvss_v3_integrity_impact_s'
          type: 'string'
        }
        {
          name: 'vuln_details_cvss_v3_impact_score_d'
          type: 'real'
        }
        {
          name: 'vuln_details_cvss_v3_exploit_score_d'
          type: 'real'
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
          type: 'dateTime'
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
          type: 'real'
        }
        {
          name: 'vuln_details_cvss_v2_impact_score_d'
          type: 'real'
        }
        {
          name: 'vuln_details_cvss_v2_integrity_impact_s'
          type: 'string'
        }
        {
          name: 'vuln_details_cvss_v2_score_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'vuln_details_title_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = nexposeinsightvmcloudvulnerabilitiesclTable.name
output tableId string = nexposeinsightvmcloudvulnerabilitiesclTable.id
output provisioningState string = nexposeinsightvmcloudvulnerabilitiesclTable.properties.provisioningState
