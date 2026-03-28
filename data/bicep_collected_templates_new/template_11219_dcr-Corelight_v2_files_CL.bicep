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
// Data Collection Rule for Corelight_v2_files_CL
// ============================================================================
// Generated: 2025-09-19 14:20:04
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 28, DCR columns: 25 (Type column always filtered)
// Output stream: Custom-Corelight_v2_files_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_files_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_files_CL': {
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
            name: 'extracted_s'
            type: 'string'
          }
          {
            name: 'sha256_s'
            type: 'string'
          }
          {
            name: 'sha1_s'
            type: 'string'
          }
          {
            name: 'parent_fuid_s'
            type: 'string'
          }
          {
            name: 'timedout_b'
            type: 'string'
          }
          {
            name: 'overflow_bytes_d'
            type: 'string'
          }
          {
            name: 'missing_bytes_d'
            type: 'string'
          }
          {
            name: 'total_bytes_d'
            type: 'string'
          }
          {
            name: 'seen_bytes_d'
            type: 'string'
          }
          {
            name: 'is_orig_b'
            type: 'string'
          }
          {
            name: 'local_orig_b'
            type: 'string'
          }
          {
            name: 'duration_d'
            type: 'string'
          }
          {
            name: 'filename_s'
            type: 'string'
          }
          {
            name: 'mime_type_s'
            type: 'string'
          }
          {
            name: 'analyzers_s'
            type: 'string'
          }
          {
            name: 'depth_d'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'conn_uids_s'
            type: 'string'
          }
          {
            name: 'rx_hosts_s'
            type: 'string'
          }
          {
            name: 'tx_hosts_s'
            type: 'string'
          }
          {
            name: 'fuid_s'
            type: 'string'
          }
          {
            name: 'extracted_cutoff_b'
            type: 'string'
          }
          {
            name: 'extracted_size_d'
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
          name: 'Sentinel-Corelight_v2_files_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_files_CL']
        destinations: ['Sentinel-Corelight_v2_files_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), extracted_s = tostring(extracted_s), sha256_s = tostring(sha256_s), sha1_s = tostring(sha1_s), parent_fuid_s = tostring(parent_fuid_s), timedout_b = tobool(timedout_b), overflow_bytes_d = toreal(overflow_bytes_d), missing_bytes_d = toreal(missing_bytes_d), total_bytes_d = toreal(total_bytes_d), seen_bytes_d = toreal(seen_bytes_d), is_orig_b = tobool(is_orig_b), local_orig_b = tobool(local_orig_b), duration_d = toreal(duration_d), filename_s = tostring(filename_s), mime_type_s = tostring(mime_type_s), analyzers_s = tostring(analyzers_s), depth_d = toreal(depth_d), source_s = tostring(source_s), conn_uids_s = tostring(conn_uids_s), rx_hosts_s = tostring(rx_hosts_s), tx_hosts_s = tostring(tx_hosts_s), fuid_s = tostring(fuid_s), extracted_cutoff_b = tobool(extracted_cutoff_b), extracted_size_d = toreal(extracted_size_d)'
        outputStream: 'Custom-Corelight_v2_files_CL'
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
