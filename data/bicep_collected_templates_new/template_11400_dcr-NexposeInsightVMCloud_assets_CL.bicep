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
// Data Collection Rule for NexposeInsightVMCloud_assets_CL
// ============================================================================
// Generated: 2025-09-19 14:20:26
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 30 (Type column always filtered)
// Output stream: Custom-NexposeInsightVMCloud_assets_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-NexposeInsightVMCloud_assets_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-NexposeInsightVMCloud_assets_CL': {
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
            name: 'unique_identifiers_s'
            type: 'string'
          }
          {
            name: 'total_vulnerabilities_d'
            type: 'string'
          }
          {
            name: 'severe_vulnerabilities_d'
            type: 'string'
          }
          {
            name: 'risk_score_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'last_scan_start_t'
            type: 'string'
          }
          {
            name: 'last_scan_end_t'
            type: 'string'
          }
          {
            name: 'last_assessed_for_vulnerabilities_t'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'critical_vulnerabilities_d'
            type: 'string'
          }
          {
            name: 'credential_assessments_s'
            type: 'string'
          }
          {
            name: 'assessed_for_vulnerabilities_b'
            type: 'string'
          }
          {
            name: 'assessed_for_policies_b'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'malware_kits_d'
            type: 'string'
          }
          {
            name: 'mac_s'
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
          name: 'Sentinel-NexposeInsightVMCloud_assets_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-NexposeInsightVMCloud_assets_CL']
        destinations: ['Sentinel-NexposeInsightVMCloud_assets_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), unique_identifiers_s = tostring(unique_identifiers_s), total_vulnerabilities_d = toreal(total_vulnerabilities_d), severe_vulnerabilities_d = toreal(severe_vulnerabilities_d), risk_score_d = toreal(risk_score_d), os_version_s = tostring(os_version_s), os_vendor_s = tostring(os_vendor_s), os_type_s = tostring(os_type_s), os_system_name_s = tostring(os_system_name_s), os_name_s = tostring(os_name_s), os_family_s = tostring(os_family_s), os_description_s = tostring(os_description_s), os_architecture_s = tostring(os_architecture_s), same_s = tostring(same_s), moderate_vulnerabilities_d = toreal(moderate_vulnerabilities_d), last_scan_start_t = todatetime(last_scan_start_t), last_scan_end_t = todatetime(last_scan_end_t), last_assessed_for_vulnerabilities_t = todatetime(last_assessed_for_vulnerabilities_t), ip_s = tostring(ip_s), id_s = tostring(id_s), host_name_s = tostring(host_name_s), exploits_d = toreal(exploits_d), critical_vulnerabilities_d = toreal(critical_vulnerabilities_d), credential_assessments_s = tostring(credential_assessments_s), assessed_for_vulnerabilities_b = tobool(assessed_for_vulnerabilities_b), assessed_for_policies_b = tobool(assessed_for_policies_b), EventProduct = tostring(EventProduct), malware_kits_d = toreal(malware_kits_d), mac_s = tostring(mac_s)'
        outputStream: 'Custom-NexposeInsightVMCloud_assets_CL'
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
