// Bicep template for Log Analytics custom table: NexposeInsightVMCloud_assets_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 30 (Type column filtered)
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

resource nexposeinsightvmcloudassetsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'NexposeInsightVMCloud_assets_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'NexposeInsightVMCloud_assets_CL'
      description: 'Custom table NexposeInsightVMCloud_assets_CL - imported from JSON schema'
      displayName: 'NexposeInsightVMCloud_assets_CL'
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
          name: 'unique_identifiers_s'
          type: 'string'
        }
        {
          name: 'total_vulnerabilities_d'
          type: 'real'
        }
        {
          name: 'severe_vulnerabilities_d'
          type: 'real'
        }
        {
          name: 'risk_score_d'
          type: 'real'
        }
        {
          name: 'os_version_s'
          type: 'string'
        }
        {
          name: 'os_vendor_s'
          type: 'string'
        }
        {
          name: 'os_type_s'
          type: 'string'
        }
        {
          name: 'os_system_name_s'
          type: 'string'
        }
        {
          name: 'os_name_s'
          type: 'string'
        }
        {
          name: 'os_family_s'
          type: 'string'
        }
        {
          name: 'os_description_s'
          type: 'string'
        }
        {
          name: 'os_architecture_s'
          type: 'string'
        }
        {
          name: 'same_s'
          type: 'string'
        }
        {
          name: 'moderate_vulnerabilities_d'
          type: 'real'
        }
        {
          name: 'last_scan_start_t'
          type: 'dateTime'
        }
        {
          name: 'last_scan_end_t'
          type: 'dateTime'
        }
        {
          name: 'last_assessed_for_vulnerabilities_t'
          type: 'dateTime'
        }
        {
          name: 'ip_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'host_name_s'
          type: 'string'
        }
        {
          name: 'exploits_d'
          type: 'real'
        }
        {
          name: 'critical_vulnerabilities_d'
          type: 'real'
        }
        {
          name: 'credential_assessments_s'
          type: 'string'
        }
        {
          name: 'assessed_for_vulnerabilities_b'
          type: 'boolean'
        }
        {
          name: 'assessed_for_policies_b'
          type: 'boolean'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'malware_kits_d'
          type: 'real'
        }
        {
          name: 'mac_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = nexposeinsightvmcloudassetsclTable.name
output tableId string = nexposeinsightvmcloudassetsclTable.id
output provisioningState string = nexposeinsightvmcloudassetsclTable.properties.provisioningState
