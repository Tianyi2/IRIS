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
// Data Collection Rule for Corelight_v2_pe_CL
// ============================================================================
// Generated: 2025-09-19 14:20:09
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 21, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-Corelight_v2_pe_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_pe_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_pe_CL': {
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
            name: 'has_cert_table_b'
            type: 'string'
          }
          {
            name: 'has_export_table_b'
            type: 'string'
          }
          {
            name: 'has_import_table_b'
            type: 'string'
          }
          {
            name: 'uses_seh_b'
            type: 'string'
          }
          {
            name: 'uses_code_integrity_b'
            type: 'string'
          }
          {
            name: 'uses_dep_b'
            type: 'string'
          }
          {
            name: 'has_debug_data_b'
            type: 'string'
          }
          {
            name: 'uses_aslr_b'
            type: 'string'
          }
          {
            name: 'is_exe_b'
            type: 'string'
          }
          {
            name: 'subsystem_s'
            type: 'string'
          }
          {
            name: 'os_s'
            type: 'string'
          }
          {
            name: 'compile_ts_t'
            type: 'string'
          }
          {
            name: 'machine_s'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'is_64bit_b'
            type: 'string'
          }
          {
            name: 'section_names_s'
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
          name: 'Sentinel-Corelight_v2_pe_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_pe_CL']
        destinations: ['Sentinel-Corelight_v2_pe_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), has_cert_table_b = tobool(has_cert_table_b), has_export_table_b = tobool(has_export_table_b), has_import_table_b = tobool(has_import_table_b), uses_seh_b = tobool(uses_seh_b), uses_code_integrity_b = tobool(uses_code_integrity_b), uses_dep_b = tobool(uses_dep_b), has_debug_data_b = tobool(has_debug_data_b), uses_aslr_b = tobool(uses_aslr_b), is_exe_b = tobool(is_exe_b), subsystem_s = tostring(subsystem_s), os_s = tostring(os_s), compile_ts_t = todatetime(compile_ts_t), machine_s = tostring(machine_s), id_s = tostring(id_s), is_64bit_b = tobool(is_64bit_b), section_names_s = tostring(section_names_s)'
        outputStream: 'Custom-Corelight_v2_pe_CL'
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
