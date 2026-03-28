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
// Data Collection Rule for Corelight_v2_ntp_CL
// ============================================================================
// Generated: 2025-09-19 14:20:08
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-Corelight_v2_ntp_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_ntp_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_ntp_CL': {
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
            name: 'rec_time_t'
            type: 'string'
          }
          {
            name: 'org_time_t'
            type: 'string'
          }
          {
            name: 'ref_time_t'
            type: 'string'
          }
          {
            name: 'ref_id_s'
            type: 'string'
          }
          {
            name: 'root_disp_d'
            type: 'string'
          }
          {
            name: 'root_delay_d'
            type: 'string'
          }
          {
            name: 'precision_d'
            type: 'string'
          }
          {
            name: 'xmt_time_t'
            type: 'string'
          }
          {
            name: 'poll_d'
            type: 'string'
          }
          {
            name: 'mode_d'
            type: 'string'
          }
          {
            name: 'version_d'
            type: 'string'
          }
          {
            name: 'id_resp_p_d'
            type: 'string'
          }
          {
            name: 'id_resp_h_s'
            type: 'string'
          }
          {
            name: 'id_orig_p_d'
            type: 'string'
          }
          {
            name: 'id_orig_h_s'
            type: 'string'
          }
          {
            name: 'uid_s'
            type: 'string'
          }
          {
            name: 'stratum_d'
            type: 'string'
          }
          {
            name: 'num_exts_d'
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
          name: 'Sentinel-Corelight_v2_ntp_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_ntp_CL']
        destinations: ['Sentinel-Corelight_v2_ntp_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), rec_time_t = todatetime(rec_time_t), org_time_t = todatetime(org_time_t), ref_time_t = todatetime(ref_time_t), ref_id_s = tostring(ref_id_s), root_disp_d = toreal(root_disp_d), root_delay_d = toreal(root_delay_d), precision_d = toreal(precision_d), xmt_time_t = todatetime(xmt_time_t), poll_d = toreal(poll_d), mode_d = toreal(mode_d), version_d = toreal(version_d), id_resp_p_d = toreal(id_resp_p_d), id_resp_h_s = tostring(id_resp_h_s), id_orig_p_d = toreal(id_orig_p_d), id_orig_h_s = tostring(id_orig_h_s), uid_s = tostring(uid_s), stratum_d = toreal(stratum_d), num_exts_d = toreal(num_exts_d)'
        outputStream: 'Custom-Corelight_v2_ntp_CL'
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
